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


<%-- if social icons were included, get the urls --%>
    <c:set var="facebook" value="${fn:trim(currentNode.properties.facebook.string)}"/>
    <c:set var="linkedin" value="${fn:trim(currentNode.properties.linkedIn.string)}"/>
    <c:set var="twitter" value="${fn:trim(currentNode.properties.twitter.string)}"/>
    <c:set var="googlePlus" value="${fn:trim(currentNode.properties.googlePlus.string)}"/>
    <%-- a value with no http(s), ftp, mailto or tel scheme links as http:// --%>
    <c:set var="linkSchemes" value="(?i)(https?|ftp)://.*|(mailto|tel):.*"/>
<!-- Contact Social Icons -->
<ul class="list-inline who">
    <c:if test="${not empty facebook and facebook != 'http://'}">
        <li><a href="${functions:matches(linkSchemes, facebook) ? '' : 'http://'}${fn:escapeXml(facebook)}"><i class="fa fa-facebook-official"></i></a></li>
    </c:if>
    <c:if test="${not empty twitter and twitter != 'http://'}">
        <li><a href="${functions:matches(linkSchemes, twitter) ? '' : 'http://'}${fn:escapeXml(twitter)}"><i class="fa fa-twitter-square"></i></a></li>
    </c:if>
    <c:if test="${not empty googlePlus and googlePlus != 'http://'}">
        <li><a href="${functions:matches(linkSchemes, googlePlus) ? '' : 'http://'}${fn:escapeXml(googlePlus)}"><i class="fa fa-google-plus-square"></i></a></li>
    </c:if>
    <c:if test="${not empty linkedin and linkedin != 'http://'}">
        <li><a href="${functions:matches(linkSchemes, linkedin) ? '' : 'http://'}${fn:escapeXml(linkedin)}"><i class="fa fa-linkedin-square"></i></a></li>
    </c:if>
</ul>
