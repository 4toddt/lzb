<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contextPath" value="${originatingRequest.ContextPath}" />
	<dsp:getvalueof var="refererPath" value="${originatingRequest.referer}" />
	<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
	<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ErrorMessageForEach"/>
	<dsp:importbean bean="/atg/dynamo/droplet/Switch"/>
	<dsp:getvalueof var="giftListId" param="skuId"/>
	<dsp:getvalueof param="prodId" var="productId"/>
	<dsp:getvalueof param="ProdName" var="prodDisplayName"/>
	<dsp:getvalueof param="skuId" var="skuNo"/>
	<dsp:getvalueof param="coverId" var="coverSkuId"/>

	<dsp:getvalueof var="prodInfo" param="jsonResponseWithProdInfo"/>
	<lzb:pageContainer>
		<jsp:attribute name="bodyClass">npc</jsp:attribute>
		<jsp:attribute name="seoAlternateURL">/account/shareProductByEmail.jsp</jsp:attribute>
		<jsp:attribute name="seoCanonicalURL">${originatingRequest.getRequestURI()}</jsp:attribute>
		<jsp:body>
			<dsp:getvalueof bean="GiftlistFormHandler.formError" var="formError"/>

			<main role="main">

				<h1><fmt:message key="shareProd.shareProdText"/></h1>

				<c:if test="${formError eq  'true'}">
				<dsp:include page="/includes/global/errors.jsp">
					<dsp:param name="formHandler" bean="GiftlistFormHandler"/>
				</dsp:include>
				</c:if>

				<p><fmt:message key="sharProd.fillInfo"/></p>

				<p>
					<fmt:message key="shareProd.sendEmail"/>
					<fmt:message key="shareProd.seeOur"/> <dsp:a href="#"><fmt:message key="shareProd.privacyPolicy"/></dsp:a> <fmt:message key="shareProd.moreDetail"/>
				</p>

				<p><fmt:message key="form.required"/></p>
					<dsp:droplet name="LZBPDPURLDroplet">
						<dsp:param name="productId" value="${productId}" />
						<dsp:param name="prodName" value="${prodDisplayName}" />
						<dsp:param name="fromCDP" value="true" />
						<dsp:param name="elementName" value="url" />
						<dsp:oparam name="output">
							<dsp:getvalueof var="pdpurl" param="url" />
						</dsp:oparam>
					</dsp:droplet>

				<dsp:form name="shareProdByEmail" method="post">

					<fieldset>

						<legend>Share this product form</legend>

						<fieldset>

							<legend>Sender Name</legend>

							<label for="senderName"><fmt:message key="wishList.yourName"/></label>
							<dsp:input type="text" name="senderName" id="senderName" maxlength="30" bean="GiftlistFormHandler.profileValueMap.senderName" value=""/>

						</fieldset>

						<fieldset>

							<legend>Sender Email</legend>

							<label for="senderEmail"><fmt:message key="wishList.yourEmail"/></label>
							<dsp:input type="text" name="senderEmail" id="senderEmail" maxlength="50" bean="GiftlistFormHandler.profileValueMap.senderEmail" value="" />

						</fieldset>

						<fieldset>

							<legend>Recipient Name</legend>

							<label for="reciepientName"><fmt:message key="shareProd.recipientName"/></label>
							<dsp:input type="text" name="reciepientName" id="reciepientName" maxlength="30" bean="GiftlistFormHandler.profileValueMap.reciepientName" value=""/><br/>

						</fieldset>

						<fieldset>

							<legend>Recipient Email</legend>

							<label for="reciepientEmail"><fmt:message key="shareProd.recipientEmail"/></label>
							<dsp:input type="text" name="reciepientEmail" id="reciepientEmail" maxlength="50" bean="GiftlistFormHandler.profileValueMap.reciepientEmail" value=""/><br/>

						</fieldset>

						<fieldset>

							<legend>Recipient Name Field</legend>

							<label for="captch"><fmt:message key="wishList.verifictionImage"/></label>
							<span><img id="captch" src="captchaImage.jpg"></span>

						</fieldset>

						<fieldset>

							<legend>Captcha</legend>

							<label for="captch"><fmt:message key="wishList.verificationNumber"/></label>
							<dsp:input type="text" name="captchaImageNumber" id="captchaImageNumber" bean="GiftlistFormHandler.profileValueMap.captchaImageNumber" value=""/>
							<dsp:input type="hidden" bean="GiftlistFormHandler.productId" value="${productId}"/>
							<dsp:input type="hidden" bean="GiftlistFormHandler.productName" value="${prodDisplayName}"/>
							<dsp:input type="hidden" bean="GiftlistFormHandler.skuNo" value="${skuNo}"/>
							<dsp:input type="hidden" bean="GiftlistFormHandler.coverSkuId" value="${coverSkuId}"/>
							<dsp:input type="hidden" bean="GiftlistFormHandler.shareItemssuccessURL" value="${siteBaseUrl}${pdpurl}"/>
							<dsp:input type="hidden" bean="GiftlistFormHandler.shareItemserrorURL" value="${pageContext.request.contextPath}/global/includes/shareThisProduct.jsp?error=true&prodId=${productId}&ProdName=${prodDisplayName}&skuNo=${skuNo}&coverId=${coverSkuId}"/>

						</fieldset>
						<dsp:a href="${siteBaseUrl}${pdpurl}"><fmt:message key="account.wishlist.cancelBtn"/></dsp:a>
						<dsp:input type="submit" iclass="btn-primary" bean="GiftlistFormHandler.ShareProductByEmail" value="SUBMIT"/>

					</fieldset>

				</dsp:form>
			</main>
	</jsp:body>
  </lzb:pageContainer>
</dsp:page>
