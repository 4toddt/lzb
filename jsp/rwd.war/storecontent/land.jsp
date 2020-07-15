<%--
	- File Name: land.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This is the store content landing page.
	- Parameters:
	-
--%>
<dsp:page>
    <%-- Imports --%>

    <%-- Page Variables --%>
    <dsp:getvalueof var="pageItem" param="page" />

    <dsp:include page="/includes/SEOTagData.jsp" otherContext="/">
		<dsp:param name="paramKeyForSEOTagData" value="metaTagDataForStorePages"/>
	</dsp:include>
	<c:if test="${not empty sEOTagTitle}">
		<c:set var="sEOTagTitle" value="${sEOTagTitle } | ${storeItemSEOAttr.streetAddress }, ${storeItemSEOAttr.addressLocality }, ${storeItemSEOAttr.addressRegion } ${ storeItemSEOAttr.postalCode }" />
	</c:if>

    <layout:default>
        <jsp:attribute name="pageTitle">${sEOTagTitle}</jsp:attribute>
		<jsp:attribute name="metaDescription">${sEOMetaTagDescription}</jsp:attribute>
		<jsp:attribute name="metaKeywords"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL">${fn:toLowerCase(requestScope['javax.servlet.forward.request_uri'])}</jsp:attribute>
		<jsp:attribute name="seoRobots">index,follow</jsp:attribute>
		<jsp:attribute name="lastModified"></jsp:attribute>
		<jsp:attribute name="doSessionTimeout">false</jsp:attribute>
		<jsp:attribute name="section">store</jsp:attribute>
		<jsp:attribute name="pageType">storeLanding</jsp:attribute>
		<jsp:attribute name="bodyClass">store-landing</jsp:attribute>
		<jsp:attribute name="analyticsPageType">storeLandingPage</jsp:attribute>
		<jsp:attribute name="pageSpecificCSS"></jsp:attribute>
		<jsp:attribute name="pageSpecificJS"></jsp:attribute>

        <jsp:body>
            <main>
                <c:set var="telephoneVar" value="${storeItemSEOAttr.telephone}" />
                <c:set var="telephoneVarF" value="(${fn:substring(telephoneVar, 0, 3)})${fn:substring(telephoneVar, 3, 6)}-${fn:substring(telephoneVar, 6, fn:length(telephoneVar))}"/>

                <c:set var="openingHoursVar" value="" />
                <c:set var="openingHoursStr" value="${fn:substring(storeItemSEOAttr.openingHours, 1, fn:length(storeItemSEOAttr.openingHours)-1)}" />

                <c:forEach items="${fn:split(openingHoursStr, ',')}" var="openingHoursText" varStatus="status">
                    <c:set var="openingHoursTextDay" value="${fn:substringBefore(openingHoursText, ':')}" />
                    <c:set var="openingHoursTextHours" value="${fn:substringAfter(openingHoursText, ':')}" />
                    <c:set var="openingHoursTextKey" value="${fn:substring(openingHoursTextDay, 1, fn:length(openingHoursTextDay)-1)}" />
                    <c:set var="openingHoursTextVal" value="${fn:substring(openingHoursTextHours, 1, fn:length(openingHoursTextHours)-1)}" />
                    <c:choose>
                        <c:when test="${status.count == 0}">
                            <c:set var="openingHoursVar" value="${openingHoursTextKey} ${openingHoursTextVal}" />
                        </c:when>
                        <c:otherwise>
                            <c:set var="openingHoursVar" value="${openingHoursVar}, ${openingHoursTextKey} ${openingHoursTextVal}" />
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:set var="openingHoursVar" value="${fn:substring(openingHoursVar, 2, fn:length(openingHoursVar))}" />

                <c:out value="${storeContentFromUmbraco}" escapeXml="false"/>

            </main>
        </jsp:body>
    </layout:default>
</dsp:page>