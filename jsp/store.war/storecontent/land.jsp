<%@ taglib prefix="dsp" uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_1" %>
<dsp:page>

 	<dsp:include page="/includes/SEOTagData.jsp">
		<dsp:param name="paramKeyForSEOTagData" value="metaTagDataForStorePages"/>
	</dsp:include>
	<c:if test="${not empty sEOTagTitle}">
		<c:set var="sEOTagTitle" value="${sEOTagTitle } | ${storeItemSEOAttr.streetAddress }, ${storeItemSEOAttr.addressLocality }, ${storeItemSEOAttr.addressRegion } ${ storeItemSEOAttr.postalCode }"  scope="request"/>
	</c:if>
	<c:choose>
		<c:when test="${not empty isMobileSiteRequest and isMobileSiteRequest eq true }" >
				<dsp:include page="/storecontent/land.jsp" otherContext="/mobile"/>
		</c:when>
		<c:otherwise>

    <lzb:pageContainer>
			<jsp:attribute name="bodyClass">
				umbraco
			</jsp:attribute>
            <jsp:attribute name="seoAlternateURL">${fn:toLowerCase(requestScope['javax.servlet.forward.request_uri'])}</jsp:attribute>
    		<jsp:attribute name="seoCanonicalURL">${fn:toLowerCase(requestScope['javax.servlet.forward.request_uri'])}</jsp:attribute>
        <dsp:getvalueof var="pageItem" param="page" />
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
    </lzb:pageContainer>

		</c:otherwise>
	</c:choose>
</dsp:page>
