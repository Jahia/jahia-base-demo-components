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

<%-- get the node properties --%>
<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="description" value="${currentNode.properties['description'].string}"/>
<c:set var="image" value="${currentNode.properties['image'].node}"/>

<c:choose>
    <%-- If no image has been supplied for the image view, put a placeholder image in place --%>
    <c:when test="${empty image}">
        <c:url var="imageUrl" value="${url.currentModule}/img/background.jpg"/>
    </c:when>
    <c:otherwise>
        <c:url var="imageUrl" value="${image.url}" context="/"/>
    </c:otherwise>
</c:choose>

<c:if test="${jcr:isNodeType(currentNode.parent, 'jdnt:highlights')}">
    <c:set var="griditem" value="grid-item"/>
</c:if>

<%-- check if the link property has been used on this content --%>
<c:if test="${jcr:isNodeType(currentNode, 'jdmix:hasLink') and not empty currentNode.properties['internalLink']
and not empty currentNode.properties['internalLink'].node}">
    <c:set var="linkNode" value="${currentNode.properties['internalLink'].node}" />
</c:if>

<%-- add ontouchstart for touch devices compatibility --%>
<div class="${griditem} thumbnails thumbnail-style ${flipClass} flip-container">
    <div class="flipper">
        <div class="front">
            <img class="img-responsive" src="${imageUrl}" alt="">
        </div>
        <div class="back">
            <div class="caption">
                <c:choose>
                    <c:when test="${not empty linkNode}">
                        <template:addCacheDependency node="${linkNode}"/>
                        <h3><a class="hover-effect" href="<c:url value="${linkNode.url}" context="/"/>">${fn:replace(title, fn:substring(title, 30, fn:length(title)), ' ...')}</a></h3>
                    </c:when>
                    <c:otherwise>
                        <h3>${fn:replace(title, fn:substring(title, 30, fn:length(title)), ' ...')}</h3>
                    </c:otherwise>
                </c:choose>
                <p>${fn:replace(description, fn:substring(description, 100, fn:length(description)), ' ...')}</p>
                <%-- only display the read more text if a link has been provided --%>
                <c:if test="${not empty linkNode}">
                    <template:addCacheDependency node="${linkNode}"/>
                    <a class="btn-more-2 hover-effect" href="<c:url value="${linkNode.url}" context="/"/>" alt="${title}">
                        <c:choose>
                            <c:when test="${jcr:isNodeType(currentNode, 'jdmix:buttonText')}">
                                <template:include view="hidden.buttonText"/>
                            </c:when>
                            <c:otherwise>
                                <fmt:message key="jdnt_highlight.readmore"/>
                            </c:otherwise>
                        </c:choose>
                        &nbsp;+
                    </a>
                </c:if>
            </div>
        </div>
    </div>
</div>
