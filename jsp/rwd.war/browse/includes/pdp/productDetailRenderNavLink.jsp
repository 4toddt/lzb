<%--
    - File Name: productDetailRenderNavLink.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page renders navigation links for product page breadcrumbs. navAction is an endeca NavigationAction.
  	- Required Parameters:
		- contentItem,
        - navAction: action url for anchor,
        - text: display text for anchor,
        - showRemoveLink: style class definition
    - Optional Parameters:
        - titleText: text for anchor title attribute
--%>
<dsp:page>
    <%-- Imports --%>
    <dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>
    <dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>

    <%-- Page Variables --%>
    <dsp:getvalueof var="navAction" vartype="com.endeca.infront.cartridge.model.NavigationAction" param="navAction"/>
    <dsp:getvalueof var="linkText" param="text"/>
    <dsp:getvalueof var="showRemoveLink" vartype="java.lang.Boolean" param="showRemoveLink"/>
    <dsp:getvalueof var="titleText" vartype="java.lang.String" param="titleText"/>

    <%-- Render Link --%>
    <c:choose>
        <c:when test="${(not empty navAction.contentPath) && (not empty titleText)}">
            <li>
                <a href="${contextPath}${storeConfig.mobileBrowseUrl}${fn:escapeXml(navAction.navigationState)}" class="crumb ${showRemoveLink == true ? 'curnt' : ''}" title="${titleText}" itemprop="url">
                    <span itemprop="title">${linkText}</span>
                </a>
            </li>
        </c:when>
        <c:when test="${(not empty navAction.contentPath) && (empty titleText)}">
            <li>
                <a href="${contextPath}${storeConfig.mobileBrowseUrl}${fn:escapeXml(navAction.navigationState)}" class="crumb ${showRemoveLink == true ? 'curnt' : ''}" itemprop="url">
                    <span itemprop="title">${linkText}</span>
                </a>
            </li>
        </c:when>
        <c:when test="${(empty navAction.contentPath) && (not empty titleText)}">
            <li>
                <a href="${contextPath}${storeConfig.mobileBrowseUrl}${fn:escapeXml(navAction.navigationState)}" class="crumb ${showRemoveLink == true ? 'curnt' : ''}" title="${titleText}" itemprop="url">
                    <span itemprop="title">${linkText}</span>
                </a>
            </li>
        </c:when>
        <c:otherwise>
            <li>
                <a href="${contextPath}${storeConfig.mobileBrowseUrl}${fn:escapeXml(navAction.navigationState)}" class="crumb ${showRemoveLink == true ? 'curnt' : ''}" itemprop="url">
                    <span itemprop="title">${linkText}</span>
                </a>
            </li>
        </c:otherwise>
    </c:choose>
</dsp:page>