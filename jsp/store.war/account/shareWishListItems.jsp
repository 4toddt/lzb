<dsp:page>
<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler"/>
<dsp:getvalueof param="skuId" var="giftListId"/>
<dsp:getvalueof bean="GiftlistFormHandler.formError" var="formError"/>

	<c:if test="${formError eq 'true'}">
		<dsp:include page="/includes/global/errors.jsp">
			<dsp:param name="formHandler" bean="GiftlistFormHandler"/>
		</dsp:include>
	</c:if>
	
	<h3><fmt:message key="wishListItemEmail.shareByEmailtitle"/></h3><br/>
	<fmt:message key="wishListItemEmail.shareItems"/><br/>
	<br/><br/><fmt:message key="wishListItemEmail.shareText"/>
	<fmt:message key="wishListItemEmail.emailMesage"/><br/>
	<fmt:message key="wishListItemEmail.viewItems"/><br/><br/>
	<fmt:message key="account.wishlist.requiredFields"/><br/>
		
	<dsp:form  method="post" name="wishListItemEmail">
		<fmt:message key="wishListItemEmail.commaSeprateEmail"/><br/>
		<dsp:textarea type="text" bean="GiftlistFormHandler.profileValueMap.emails" name="emails"/><br/>
		<fmt:message key="wishListItemsEmail.message"/><br/>
		<dsp:textarea type="text" bean="GiftlistFormHandler.profileValueMap.message" name="message"/><br/>
		<dsp:input type="hidden" bean="GiftlistFormHandler.giftItems" value="${giftListId}"/>
		<dsp:input type="hidden" bean="GiftlistFormHandler.shareItemssuccessURL" value="${pageContext.request.contextPath}/account/shareWishListItems.jsp?success=true"/>
		<dsp:input type="hidden" bean="GiftlistFormHandler.shareItemserrorURL" value="${pageContext.request.contextPath}/account/shareWishListItems.jsp?error=true"/>
		<dsp:input type="submit" value="submit" bean="GiftlistFormHandler.sendWishListItemsEmail"/>&nbsp;
		<dsp:a href="${pageContext.request.contextPath}/account/wish_list_items.jsp"><fmt:message key="account.wishlist.cancelBtn"/></dsp:a>
	</dsp:form>
</dsp:page>