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
<!-- Core CSS file -->

<template:addResources type="css" resources="photoswipe/photoswipe.css"/>

<!-- Skin CSS file (styling of UI - buttons, caption, etc.)
In the folder of skin CSS file there are also:
- .png and .svg icons sprite,
- preloader.gif (for browsers that do not support CSS animations) -->
<template:addResources type="css" resources="photoswipe/default-skin/default-skin.css"/>
<!-- Core JS file -->
<template:addResources type="javascript" resources="plugins/photoswipe/photoswipe.min.js"/>
<!-- UI JS file -->
<template:addResources type="javascript" resources="plugins/photoswipe/photoswipe-ui-default.min.js"/>
<template:addResources type="javascript" resources="custom/photoSwipeInit.js"/>
<template:addResources type="javascript" resources="custom/photoGallery.js"/>

<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="photosWidth" value="${currentNode.properties['photosWidth'].string}"/>

<%-- get the child galleryImgs --%>
<c:set var="images" value="${jcr:getChildrenOfType(currentNode, 'jdnt:galleryImg')}"/>

<c:if test="${not empty title}">
<h2>${fn:escapeXml(title)}</h2>
</c:if>

<div class="myPhotoGallery" itemscope itemtype="http://schema.org/ImageGallery">
    <c:forEach items="${images}" var="galImage" varStatus="item">
        <galleryfigure itemprop="associatedMedia" itemscope itemtype="http://schema.org/ImageObject" style="width: ${photosWidth}px">
            <template:module node="${galImage}" nodeTypes="jdnt:gallerImag" editable="true"/>
        </galleryfigure>
    </c:forEach>
</div>
<div class="row"></div>

<c:if test="${renderContext.editMode}">
    <br/>
    <template:module path="*"/>
</c:if>