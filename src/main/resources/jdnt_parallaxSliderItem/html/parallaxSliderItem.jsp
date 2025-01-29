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
<template:addResources type="css" resources="jahiademo-components.css"/>

<c:set var="backgroundImg" value="${currentNode.properties['backgroundImg'].node}"/>
<c:if test="${not empty backgroundImg}">
    <template:addCacheDependency node="${backgroundImg}"/>
    <c:url var="backgroundImgUrl" value="${backgroundImg.url}" context="/"/>
</c:if>
<c:set var="pause" value="${currentNode.properties['pause'].boolean}"/>
<c:set var="width" value="${currentNode.properties['width'].string}"/>
<c:set var="body" value="${currentNode.properties['body'].string}"/>
<c:set var="slideTheme" value="${currentNode.properties['slideTheme'].string}"/>

<c:if test="${not currentNode.properties['effect'].boolean}">
    <c:set var="effectClass" value="noeffect"/>
</c:if>

<section class="parallaxPanel ${effectClass} parallax${slideTheme}" id="parallax${currentNode.identifier}"
         style="background-image: url('${backgroundImgUrl}');
         <c:if test="${pause}">margin-bottom:400px</c:if> ">
    <div style="width: ${width};">${body}</div>
</section>

