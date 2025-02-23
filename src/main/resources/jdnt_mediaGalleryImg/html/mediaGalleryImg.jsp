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

<c:set var="image" value="${currentNode.properties['image'].node}"/>
<template:addCacheDependency node="${image}"/>
<c:url var="imageUrl" value="${image.url}" context="/"/>
<template:module path='${image.path}' editable='false' view='hidden.imageSize' var="imageSize"/>

<c:set var="caption" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="itemWidth" value="${currentNode.parent.properties['itemWidth'].string}"/>
<galleryfigure itemprop="associatedMedia" itemscope itemtype="http://schema.org/ImageObject" >
<c:choose>
    <c:when test="${renderContext.editMode}">
        <img src="${imageUrl}" itemprop="thumbnail" alt="${caption}" style="width: ${itemWidth}px"/>
        <br>
    </c:when>
    <c:otherwise>
        <a href="${imageUrl}" itemprop="contentUrl"
           data-size="${imageSize}">
            <img src="${imageUrl}" itemprop="thumbnail" alt="${caption}" style="width: ${itemWidth}px"/>
            <br>
        </a>
    </c:otherwise>
</c:choose>
<figcaption itemprop="caption description">${caption}</figcaption>
</galleryfigure>

