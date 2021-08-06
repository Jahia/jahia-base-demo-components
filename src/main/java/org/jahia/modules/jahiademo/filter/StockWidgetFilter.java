/*
 * ==========================================================================================
 * =                   JAHIA'S DUAL LICENSING - IMPORTANT INFORMATION                       =
 * ==========================================================================================
 *
 *                                 http://www.jahia.com
 *
 *     Copyright (C) 2002-2020 Jahia Solutions Group SA. All rights reserved.
 *
 *     THIS FILE IS AVAILABLE UNDER TWO DIFFERENT LICENSES:
 *     1/GPL OR 2/JSEL
 *
 *     1/ GPL
 *     ==================================================================================
 *
 *     IF YOU DECIDE TO CHOOSE THE GPL LICENSE, YOU MUST COMPLY WITH THE FOLLOWING TERMS:
 *
 *     This program is free software: you can redistribute it and/or modify
 *     it under the terms of the GNU General Public License as published by
 *     the Free Software Foundation, either version 3 of the License, or
 *     (at your option) any later version.
 *
 *     This program is distributed in the hope that it will be useful,
 *     but WITHOUT ANY WARRANTY; without even the implied warranty of
 *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *     GNU General Public License for more details.
 *
 *     You should have received a copy of the GNU General Public License
 *     along with this program. If not, see <http://www.gnu.org/licenses/>.
 *
 *
 *     2/ JSEL - Commercial and Supported Versions of the program
 *     ===================================================================================
 *
 *     IF YOU DECIDE TO CHOOSE THE JSEL LICENSE, YOU MUST COMPLY WITH THE FOLLOWING TERMS:
 *
 *     Alternatively, commercial and supported versions of the program - also known as
 *     Enterprise Distributions - must be used in accordance with the terms and conditions
 *     contained in a separate written agreement between you and Jahia Solutions Group SA.
 *
 *     If you are unsure which license is appropriate for your use,
 *     please contact the sales department at sales@jahia.com.
 */
package org.jahia.modules.jahiademo.filter;

import org.apache.hc.client5.http.classic.methods.HttpGet;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.CloseableHttpResponse;
import org.apache.hc.core5.http.io.entity.EntityUtils;
import org.apache.hc.core5.net.URIBuilder;
import org.jahia.services.content.JCRCallback;
import org.jahia.services.content.JCRNodeWrapper;
import org.jahia.services.content.JCRSessionWrapper;
import org.jahia.services.content.JCRTemplate;
import org.jahia.services.notification.HttpClientService;
import org.jahia.services.render.RenderContext;
import org.jahia.services.render.Resource;
import org.jahia.services.render.filter.AbstractFilter;
import org.jahia.services.render.filter.RenderChain;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.jcr.RepositoryException;
import java.net.URI;
import java.net.URL;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

public class StockWidgetFilter extends AbstractFilter {

    private final static Logger LOGGER = LoggerFactory.getLogger(StockWidgetFilter.class);
    private static final String PROPERTY_VALUE = "value";
    private static final String PROPERTY_VARIATION = "variation";
    private static final String PROPERTY_DESCRIPTION = "description";
    private static String API_URL = "finance.google.com";
    private static String API_path = "/finance";

    private HttpClientService httpClientService;

    /**
     *
     * @param renderContext
     * @param resource
     * @param chain
     * @return
     * @throws Exception
     */
    @Override
    public String prepare(final RenderContext renderContext,
                          final Resource resource,
                          final RenderChain chain) throws Exception {
        final JSONObject stock = queryGoogleFinanceAPI(API_path, "client", "ig",
                "q", getStockProperty(resource, "stock"), "output", "json");
        final String stockValue;
        final String stockVariation;
        final String stockDescription;

        if (stock != null) {
            final String value = stock.getString("l");
            final String variation = stock.getString("c");
            final String description = stock.getString("e");
            stockValue = value;
            stockVariation = variation;
            stockDescription = description;

            saveStock(resource, value, variation, description);
        } else {
            stockValue = getStockProperty(resource, PROPERTY_VALUE);
            stockVariation = getStockProperty(resource, PROPERTY_VARIATION);
            stockDescription = getStockProperty(resource, PROPERTY_DESCRIPTION);
        }
        renderContext.getRequest().setAttribute("stockValue", stockValue);
        renderContext.getRequest().setAttribute("stockVariation", stockVariation);
        renderContext.getRequest().setAttribute("stockDescription", stockDescription);

        return super.prepare(renderContext, resource, chain);
    }

    /**
     *
     * @param path
     * @param params
     * @return
     * @throws RepositoryException
     */
    private JSONObject queryGoogleFinanceAPI(final String path,
                                             final String... params) throws RepositoryException {
        try {
            final CloseableHttpClient httpClient = httpClientService.getHttpClient(API_URL);
            URIBuilder builder = new URIBuilder(new URL("http", API_URL, -1, path).toExternalForm());


            final Map<String, String> m = new LinkedHashMap<String, String>();
            for (int i = 0; i < params.length; i += 2) {
                builder.setParameter(params[i], params[i + 1]);
            }

            final long l = System.currentTimeMillis();
            URI uri = builder.build();
            LOGGER.debug("Start request : " + uri);
            final HttpGet httpMethod = new HttpGet(uri);
            httpMethod.setConfig(httpClientService.getRequestConfigBuilder(httpClient).setResponseTimeout(1000L, TimeUnit.MILLISECONDS).build());
            try (CloseableHttpResponse response = httpClient.execute(httpMethod)) {
                return new JSONObject(EntityUtils.toString(response.getEntity()));
            } finally {
                LOGGER.debug("Request " + uri + " done in " + (System.currentTimeMillis() - l) + "ms");
            }
        } catch (java.net.SocketTimeoutException te) {
            LOGGER.warn("Timeout Exception on request to Google Finance API");
            return null;
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return null;
        }
    }

    /**
     *
     * @param resource
     * @param value
     * @param variation
     * @param description
     * @throws RepositoryException
     */
    private void saveStock(final Resource resource,
                           final String value,
                           final String variation,
                           final String description) throws RepositoryException {
        JCRTemplate.getInstance().doExecuteWithSystemSessionAsUser(null, "live", null,
                new JCRCallback<Object>() {
                    public Object doInJCR(final JCRSessionWrapper session) throws RepositoryException {
                        String currentNodePath = resource.getNode().getPath();
                        if(session.nodeExists(currentNodePath)) {
                            final JCRNodeWrapper stockWidgetNode = session.getNode(currentNodePath);
                            stockWidgetNode.setProperty(PROPERTY_VALUE, value);
                            stockWidgetNode.setProperty(PROPERTY_VARIATION, variation);
                            stockWidgetNode.setProperty(PROPERTY_DESCRIPTION, description);
                            stockWidgetNode.saveSession();
                        }

                        return null;
                    }
                });
    }

    /**
     *
     * @param resource
     * @param property
     * @return
     * @throws RepositoryException
     */
    private String getStockProperty(final Resource resource,
                                    final String property) throws RepositoryException {
        final JCRNodeWrapper stockwidgetNode = resource.getNode();
        if (stockwidgetNode.hasProperty(property)) {
            return stockwidgetNode.getProperty(property).getString();
        } else {
            return "";
        }
    }

    /**
     * Injects an instance of the {@link HttpClientService}.
     * 
     * @param httpClientService
     *            an instance of the service
     */
    public void setHttpClientService(HttpClientService httpClientService) {
        this.httpClientService = httpClientService;
    }
}
