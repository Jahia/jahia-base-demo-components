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

<c:set var="image" value="${currentNode.properties['videoPoster'].node}"/>
<template:addCacheDependency node="${image}"/>
<c:url var="imageUrl" value="${image.url}" context="/"/>

<c:set var="caption" value="${currentNode.properties['jcr:title'].string}"/>

<c:set var="itemWidth" value="${currentNode.parent.properties['itemWidth'].string}"/>
<template:addCacheDependency node="${currentNode.properties.video.node}"/>
<c:url var="videoURL" value="${currentNode.properties.video.node.url}" context="/"/>
<galleryfigure itemprop="associatedMedia" itemscope itemtype="http://schema.org/ImageObject" >
<c:choose>
    <c:when test="${renderContext.editMode}">
        <%-- if edit mode do not link to the photoswipe preview --%>
        <img src="${imageUrl}" itemprop="thumbnail" alt="${caption}" style="width: ${itemWidth}px"/>
        <br>
    </c:when>
    <c:otherwise>
        <a href="#" itemprop="contentUrl"
           data-size="${image.properties['j:width'].string}x${image.properties['j:height'].string}"
           data-type="video"
           data-video='<div class="pswp__wrapper"><div class="pswp__video-wrapper"><iframe class="pswp__video" width="960" height="640" src="${videoURL}" frameborder="0" allowfullscreen></iframe></div></div>'
        >
            <img src="${imageUrl}" itemprop="thumbnail" alt="${caption}" style="width: ${itemWidth}px" class="img-responsive">
            <br/>
        </a>
        <figcaption itemprop="caption description">${caption}</figcaption>
    </c:otherwise>
</c:choose>
</galleryfigure>