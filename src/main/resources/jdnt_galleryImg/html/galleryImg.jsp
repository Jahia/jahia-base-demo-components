<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<c:set var="image" value="${currentNode.properties['image']}"/>
<c:set var="caption" value="${currentNode.properties['jcr:title'].string}"/>
    <c:choose>
        <c:when test="${renderContext.editMode}">
            <img src="${image.node.url}" itemprop="thumbnail" alt="${fn:escapeXml(caption)}"/>
            <br>
        </c:when>
        <c:otherwise>
            <a href="${image.node.url}" itemprop="contentUrl"
               data-size="${image.node.properties['j:width'].string}x${image.node.properties['j:height'].string}">
                <img src="${image.node.url}" itemprop="thumbnail" alt="${fn:escapeXml(caption)}"/>
                <br>
            </a>
        </c:otherwise>
    </c:choose>
<figcaption itemprop="caption description">${fn:escapeXml(caption)}</figcaption>

