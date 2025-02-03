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

<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="subtitle" value="${currentNode.properties.subtitle.string}"/>
<c:set var="summary" value="${currentNode.properties.body.string}"/>
<c:set var="textColor" value="${currentNode.properties.textColor.string}"/>
<c:set var="link" value="${currentNode.properties.internalLink.node}"/>
<c:set var="linkText" value="${currentNode.properties.linkText.string}"/>
<c:set var="background" value="${currentNode.properties.backgroundImg.node}"/>
<c:set var="image" value="${currentNode.properties.smallPhoto.node}"/>

<%-- If a color theme was not selected use light --%>
<c:if test="${empty textColor}"><c:set var="textColor" value="light"/></c:if>
<c:if test="${textColor eq 'dark'}">
    <c:set var="textColorClass" value="color-dark"/>
</c:if>

<%-- if linkText is not filled in use default Read More from resource file--%>
<c:if test="${empty linkText}">
    <c:set var="linkText"><fmt:message key="jdnt_sliderPanel.readMore"/></c:set>
</c:if>

<%-- get the background image, if none provided use default background.jpg image --%>
<c:choose>
    <c:when test="${empty background}">
        <c:url var="backgroundUrl" value="${url.currentModule}/img/background.jpg"/>
    </c:when>
    <c:otherwise>
        <c:url var="backgroundUrl" value="${background.url}" context="/"/>
    </c:otherwise>
</c:choose>

<%-- get pixel layout for text and image --%>
<c:set var="layout" value="${currentNode.properties.layout.string}"/>

<c:if test="${layout == 'right'}">
    <c:set var="textLayout" value="-right"/>
</c:if>


<div id="slidertab-${currentNode.identifier}" class="slider-tab-content tab-selector-${currentNode.parent.identifier}"
     style="background: url('${backgroundUrl}')">
    <div class="edit-slider-cont${textLayout}">

        <c:if test="${not empty subtitle}">
            <div class="first-layer-editslider ${textColorClass}">${subtitle}</div>
        </c:if>
        <c:if test="${not empty title}">
            <div class="second-layer-editslider">
                <span class="color-theme">${title}</span>
            </div>
        </c:if>

        <c:if test="${not empty summary}">
            <div class="text-layer-editslider ${textColorClass}">${summary}</div>
        </c:if>

        <c:if test="${not empty link}">
            <template:addCacheDependency node="${link}"/>
            <a class="but-layer-editslider" href="<c:url value="${link.url}" context="/"/>" alt="${title}">${linkText}</a>
        </c:if>
    </div>
    <%-- second image if exists --%>
    <c:if test="${not empty image}">
        <img class="ms-img-bordered edit-slider-img" src="<c:url value="${image.url}" context="/"/>" alt="">
    </c:if>
</div>



