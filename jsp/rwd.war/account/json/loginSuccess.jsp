<%@ include file="/sitewide/fragments/content-type-json.jspf" %>
<dsp:page>

	<dsp:getvalueof param="originalURL" var="originalURL" />
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
	<dsp:getvalueof var="cartMerged" bean="ProfileFormHandler.cartMerged"/>
	<dsp:getvalueof param="pageType" var="pageType"/>

	<c:choose>
		<c:when test="${cartMerged}">
			<dsp:getvalueof var="redirectUrl" scope="request" value="/rwd/checkout/cart.jsp"/>
		</c:when>
		<c:when test="${not empty pageType}">
			<dsp:getvalueof var="redirectUrl" scope="request" value="${contextLinkPath}/account/account.jsp"/>
		</c:when>
		<c:otherwise>
			<dsp:getvalueof var="redirectUrl" scope="request" value=""/>
		</c:otherwise>
	</c:choose>

	<json:object>
		<json:property name="success">true</json:property>
		<json:property name="cartMerged">${cartMerged}</json:property>
		<json:property name="url">${redirectUrl}</json:property>
	</json:object>

</dsp:page>
