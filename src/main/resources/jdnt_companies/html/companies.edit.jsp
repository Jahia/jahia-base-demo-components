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
<%-- edit mode view for companies --%>

<div class="content-xs">
    <%-- Add Cube-Portfolio filters container --%>
    <%-- Get filter categories from the choice list of industries --%>
    <jcr:propertyInitializers var="options" nodeType="jdnt:company" name="industryCat" node="${currentNode}"/>

    <div id="filters-container" class="cbp-l-filters-text content-xs">
        <div data-filter="*" class="cbp-filter-item-active cbp-filter-item"> <fmt:message key="jdnt_companies.all"/></div>
        |
        <c:forEach items="${options}" var="option" varStatus="items">
            <div data-filter=".${option.value.string}" class="cbp-filter-item">${fn:escapeXml(option.displayName)}</div>
            <c:if test="${not items.last}"> |</c:if>
        </c:forEach>
    </div>
    <%--/end Filters Container--%>
</div>


<div class="container">
    <div class="row">
        <c:set var="resourceReadOnly" value="${currentResource.moduleParams.readOnly}"/>
        <%-- Displaying the view of inherited nodetype jnt:contentList and this view is loading all subnodes,
                                                the view is setting modulemap that we get from the included template header --%>
        <template:include view="hidden.header"/>
        <c:set var="isEmpty" value="true"/>
        <c:forEach items="${moduleMap.currentList}" var="subchild" begin="${moduleMap.begin}" end="${moduleMap.end}"
                   varStatus="item">
            <div class="col-md-4 col-sm-6 col-xs-12">
                <template:module node="${subchild}" view="edit" editable="${moduleMap.editable && !resourceReadOnly}"/>
            </div>
            <c:set var="isEmpty" value="false"/>
        </c:forEach>
        <%-- If the list is empty then we will display a sample imgView and default view Highlight --%>
        <c:if test="${not empty moduleMap.emptyListMessage and (renderContext.editMode or moduleMap.forceEmptyListMessageDisplay) and isEmpty}">
            <%-- Sample company --%>
            <div class="col-md-4 col-sm-6 col-xs-12">
                <div class="edit-comp-wrapper">
                    <div class="edit-comp-img-cont">
                        <img src="${url.currentModule}/img/background.jpg" alt=""/>
                    </div>
                    <div class="edit-comp-text-cont">
                        <a href="#" class="edit-comp-title"><fmt:message key="jdnt_companies.company"/></a>
                        <div class="edit-comp-subtitle"><fmt:message key="jdnt_companies.company_description"/></div>
                    </div>
                </div>
            </div>
        </c:if>

    </div>
</div>


<%-- Add the add new content item button if in edit mode --%>
<c:if test="${moduleMap.editable and renderContext.editMode && !resourceReadOnly}">
    <%-- limit to adding jdnt:highlight nodes to the list --%>
    <template:module path="*" nodeTypes="jdnt:company"/>
</c:if>
<template:include view="hidden.footer"/>
