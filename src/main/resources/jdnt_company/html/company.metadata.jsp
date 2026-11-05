<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<%-- metadata view of company --%>

<jcr:nodeProperty node="${currentNode}" name="phone" var="phone"/>
<jcr:nodeProperty node="${currentNode}" name="email" var="email"/>
<jcr:nodeProperty node="${currentNode}" name="website" var="website"/>
<jcr:nodeProperty node="${currentNode}" name="j:street" var="street"/>
<jcr:nodeProperty node="${currentNode}" name="j:zipCode" var="zipCode"/>
<jcr:nodeProperty node="${currentNode}" name="j:town" var="town"/>
<jcr:nodeProperty node="${currentNode}" name="j:country" var="country"/>
<c:set var="websiteUrl" value="${fn:trim(website.string)}"/>
<%-- a value with no http(s), ftp, mailto or tel scheme links as http:// --%>
<c:set var="linkSchemes" value="(?i)(https?|ftp)://.*|(mailto|tel):.*"/>

<%-- display the headline title, get wording from resource files --%>
<div class="headline"><h2><fmt:message key="jdnt_company.headlineTitle"/></h2></div>
<ul class="list-unstyled who">
    <c:if test="${not empty street or not empty  town or not empty country}">
    <li><a href="https://maps.google.com?q=${fn:escapeXml(street.string)}+${fn:escapeXml(town.string)}+${fn:escapeXml(zipCode.string)}+${fn:escapeXml(country.string)}"><i
            class="fa fa-building-o"></i>${fn:escapeXml(street.string)}
        <br/><i class="fa fa-building-o" style="visibility: hidden;"></i>${fn:escapeXml(town.string)}&nbsp;${fn:escapeXml(zipCode.string)}&nbsp;-&nbsp;${fn:escapeXml(country.string)}
    </a>
        </c:if>
        <c:if test="${not empty email}">
    <li><a href="mailto:${fn:escapeXml(email.string)}"><i class="fa fa-envelope"></i>${fn:escapeXml(email.string)}</a></li>
    </c:if>
    <c:if test="${not empty phone}">
        <li><a href="tel:${fn:escapeXml(phone.string)}"><i class="fa fa-phone"></i>${fn:escapeXml(phone.string)}</a></li>
    </c:if>
    <c:if test="${not empty websiteUrl and websiteUrl != 'http://'}">
        <li><a href="${functions:matches(linkSchemes, websiteUrl) ? '' : 'http://'}${fn:escapeXml(websiteUrl)}"><i class="fa fa-globe"></i>${fn:escapeXml(websiteUrl)}</a></li>
    </c:if>
</ul>

<%-- If social icons have been added use mixin view to display --%>
<c:if test="${jcr:isNodeType(currentNode, 'jdmix:socialIcons')}">
    <template:include view="hidden.company"/>
</c:if>
