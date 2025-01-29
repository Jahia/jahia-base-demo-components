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
<template:module path='${image.path}' editable='false' view='hidden.imageSize' var="imageSize"/>

<c:set var="caption" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="itemWidth" value="${currentNode.parent.properties['itemWidth'].string}"/>
<c:set var="videoID" value="${currentNode.properties['videoId'].string}"/>
<c:set var="videoSource" value="${currentNode.properties['videoService'].string}"/>
<galleryfigure itemprop="associatedMedia" itemscope itemtype="http://schema.org/ImageObject" >
<%-- set the url of the video based on the service hosting the video --%>
<c:choose>
    <c:when test="${fn:toLowerCase(videoSource) == 'vimeo'}">
        <c:set var="videoURL" value="http://player.vimeo.com/video/${videoID}"/>
    </c:when>
    <c:otherwise>
        <c:set var="videoURL" value="http://www.youtube.com/embed/${videoID}"/>
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${renderContext.editMode}">
        <%-- if in edit mode, do not link to the photoswipe preview --%>
        <img src="${imageUrl}" itemprop="thumbnail" alt="${caption}" style="width: ${itemWidth}px"/>
        <br>
    </c:when>
    <c:otherwise>
        <a href="#" itemprop="contentUrl"
           data-size="${imageSize}"
           data-type="video"
           data-video='<div class="pswp_wrapper"><div class="pswp_video-wrapper"><iframe class="pswp__video" width="960" height="640" src="${videoURL}" frameborder="0" allowfullscreen></iframe></div></div>'
        >
            <img src="${imageUrl}" itemprop="thumbnail" alt="${caption}" style="width: ${itemWidth}px" class="img-responsive">
            <br/>
        </a>
        <figcaption itemprop="caption description">${caption}</figcaption>
    </c:otherwise>
</c:choose>
</galleryfigure>

