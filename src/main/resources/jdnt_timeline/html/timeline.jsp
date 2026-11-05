<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="propertyDefinition" type="org.jahia.services.content.nodetypes.ExtendedPropertyDefinition"--%>
<%--@elvariable id="type" type="org.jahia.services.content.nodetypes.ExtendedNodeType"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<template:addResources type="css" resources="shortcode_timeline2.css"/>

<%-- Get the title of the timeline, if exists display above carousel --%>
<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:if test="${not empty title}">
    <div class="headline"><h2>${fn:escapeXml(title)}</h2></div>
</c:if>

<ul class="timeline-v2">

    <c:set var="resourceReadOnly" value="${currentResource.moduleParams.readOnly}"/>
    <%-- Displaying the view of inherited nodetype jnt:contentList and this view is loading all subnodes,
                                    the view is setting modulemap that we get from the included template header --%>
    <%-- must set the Sub Nodes View to "timeline" when setting the layout --%>
    <template:include view="hidden.header"/>
    <c:set var="isEmpty" value="true"/>
    <c:forEach items="${moduleMap.currentList}" var="subchild" begin="${moduleMap.begin}" end="${moduleMap.end}">
        <template:module node="${subchild}" view="timeline" editable="${moduleMap.editable && !resourceReadOnly}"/>
        <c:set var="isEmpty" value="false"/>
    </c:forEach>

    <%-- If the list is empty then we will display the default contentList message for empty list --%>
    <c:if test="${not empty moduleMap.emptyListMessage and (renderContext.editMode or moduleMap.forceEmptyListMessageDisplay) and isEmpty}">
        <p>${moduleMap.emptyListMessage}</p>
        <%-- Add the placeholder content in edit mode --%>
        <template:include view="hidden.placeholder"/>
    </c:if>
</ul>
<%-- Add the add new content item button if in edit mode --%>
    <c:if test="${moduleMap.editable and renderContext.editMode && !resourceReadOnly}">
        <%-- limit to adding jnt:news nodes to the list --%>
        <template:module path="*" nodeTypes="jnt:news"/>
    </c:if>
    <template:include view="hidden.footer"/>
