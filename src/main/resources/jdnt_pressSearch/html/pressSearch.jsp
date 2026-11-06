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
<template:addResources type="javascript" resources="custom/jahiademo-custom.js"/>
<template:addResources type="javascript" resources="custom/pressSearch.js"/>
<template:include view="hidden.header"/>
<c:if test="${currentNode.properties.disableAjax.boolean}">
    <c:set var="disableAjax" value="disableAjax=true"/>
</c:if>

<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate value="${now}" pattern="yyyy" var="thisYear"/>

<c:set var="view" value="default"/>
<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>

<%-- get the number of tabs to display --%>
<c:set var="numTabs" value="${currentNode.properties['numTabs'].string}"/>
<c:if test="${empty numTabs}">
    <c:set var="numTabs" value="3"/>
</c:if>

<div class="pressContainer">

    <div id="pressSearch-content-${currentNode.identifier}" class="pressSearch"
         url="<c:url value='${url.base}${currentNode.path}.html'/>"
         uuid="${currentNode.identifier}" ${disableAjax}>
        <c:if test="${not empty title}">
            <div class="headline"><h2>${fn:escapeXml(title)}</h2></div>
        </c:if>
        <%-- generate tabs --%>
        <div class="tab-v1">
            <ul class="nav nav-tabs">
                <li class="${thisYear} defaultYear">
                    <a class="pressTabItem" view="${thisYear}" href="javascript:void(0)">${thisYear}</a>
                </li>
                <c:forEach var="i" begin="1" end="${numTabs-1}">
                    <li class="${thisYear-i}">
                        <a class="pressTabItem" view="${thisYear-i}" href="javascript:void(0)">${thisYear-i}</a>
                    </li>
                </c:forEach>
                <li class="older">
                    <a class="pressTabItem" view="older" href="javascript:void(0)"> <fmt:message
                            key='jdnt_pressSearch.older'/></a>
                </li>
            </ul>
            <div id="tab-content-${currentNode.identifier}">
                <c:forEach items="${moduleMap.currentList}" var="pressRelease" varStatus="item">
                    <template:module view="${view}" path="${pressRelease.path}" editable="false"/>
                </c:forEach>
            </div>
        </div>
    </div>
</div>