<dsp:page>
<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler"/>
<dsp:getvalueof param="giftItemId" var="giftListId"/>
<dsp:getvalueof bean="GiftlistFormHandler.formError" var="formError"/>
	<section class="wishlist-modal">
		<dsp:form  method="post" name="wishListItemEmail" id="wishListItemEmail" iclass="modal-jquery-validation wishListItemEmail-form standard-border">
			<div class="wish-modal-title">
			    <h2><fmt:message key="wishListItemEmail.shareByEmailtitle"/></h2>
			</div>
			<c:if test="${formError eq 'true'}">
				<dsp:include page="/includes/global/errors.jsp">
					<dsp:param name="formHandler" bean="GiftlistFormHandler"/>
				</dsp:include>
			</c:if>
			<div class="wishlist-msg">  
				<p><fmt:message key="wishListItemEmail.shareItems"/><fmt:message key="wishListItemEmail.shareText"/></p>
				<p><fmt:message key="wishListItemEmail.emailMesage"/>
				<fmt:message key="wishListItemEmail.viewItems"/></p>
			</div>
			<p><fmt:message key="account.wishlist.requiredFields"/></p>	
			<div>
		    <fieldset>
			     <label><fmt:message key="wishListItemEmail.commaSeprateEmail"/></label>
			     <dsp:textarea  bean="GiftlistFormHandler.profileValueMap.emails" name="emails"></dsp:textarea>
		    </fieldset>
		    <fieldset>
			     <label><fmt:message key="wishListItemsEmail.message"/></label>
			     <dsp:textarea  bean="GiftlistFormHandler.profileValueMap.message" name="message"></dsp:textarea> 
		    </fieldset>
		   </div>
		   <div class="wish-modal-button">
		   	<dsp:input type="hidden" bean="GiftlistFormHandler.giftItems" value="${giftListId}"/>
			<dsp:input type="hidden" bean="GiftlistFormHandler.shareItemssuccessURL" value="${pageContext.request.contextPath}/account/wish_list_items.jsp?success=true"/>
			<dsp:input type="hidden" bean="GiftlistFormHandler.shareItemserrorURL" value="${pageContext.request.contextPath}/account/wish_list_items.jsp?error=true"/>
		    <dsp:a href="${pageContext.request.contextPath}/account/wish_list_items.jsp"><fmt:message key="account.wishlist.cancelBtn"/></dsp:a>
		    <dsp:input type="submit" value="SHARE" bean="GiftlistFormHandler.sendWishListItemsEmail" iclass="btn-primary"/>
		   </div>
		</dsp:form>
	</section>
</dsp:page>