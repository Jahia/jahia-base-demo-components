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
<%-- Banner view of Company --%>

<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="title"/>
<jcr:nodeProperty node="${currentNode}" name="bannerImg" var="bannerImg"/>
<jcr:nodeProperty node="${currentNode}" name="headline" var="headline"/>
<jcr:nodeProperty node="${currentNode}" name="logo" var="logo"/>

<div class="breadcrumbs-v3 img-v1 text-center"
    <c:if test="${not empty bannerImg}">
        <c:url value="${url.files}${bannerImg.node.path}" var="bannerUrl"/>
        style='background-image: url("${bannerUrl}")'
    </c:if>
>
    <div class="container">
        <c:choose>
            <c:when test="${not empty logo}">
                <template:addCacheDependency node="${logo.node}"/>
                <c:url value="${url.files}${logo.node.path}" var="logoUrl"/>
                <img src="${logoUrl}" class="company-banner-logo"/>
            </c:when>
            <c:otherwise>
                <h1>${title.string}</h1>
            </c:otherwise>
        </c:choose>
        <p>${headline.string}</p>
    </div>
</div>