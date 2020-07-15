<dsp:page>
<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler"/>
<dsp:getvalueof var="giftListId" param=""/>
<c:set var="giftListId" value=""/>
<dsp:getvalueof param="coverSkuId" var="coverSkuNo"/>
<dsp:getvalueof param="prodId" var="productId"/>
<dsp:getvalueof param="ProdName" var="productName"/>
<dsp:getvalueof param="skuNo" var="skuId"/>
<dsp:getvalueof param="jsonrequest" var="jsonrequest"/>



<layout:default>
	<jsp:attribute name="pageTitle"><fmt:message key="shareProd.shareProdText"/></jsp:attribute>
	<jsp:attribute name="metaDescription"></jsp:attribute>
	<jsp:attribute name="metaKeywords"></jsp:attribute>
	<jsp:attribute name="seoCanonicalURL"></jsp:attribute>
	<jsp:attribute name="seoRobots">index,follow</jsp:attribute>
	<jsp:attribute name="lastModified"></jsp:attribute>
	<jsp:attribute name="doSessionTimeout">false</jsp:attribute>
	<jsp:attribute name="section">account</jsp:attribute>
	<jsp:attribute name="pageType">sharing</jsp:attribute>
	<jsp:attribute name="bodyClass">account</jsp:attribute>
	<jsp:attribute name="analyticsPageType">shareProductByEmailPage</jsp:attribute>
	<jsp:attribute name="pageSpecificCSS"></jsp:attribute>
	<jsp:attribute name="pageSpecificJS"></jsp:attribute>

	<jsp:body>
		<!-- breadcrumbs -->
		<section class="breadcrumbs">
			<ul aria-label="breadcrumbs" role="navigation">
				<li><a class="crumb" href="${contextPath}/"><fmt:message key="breadcrumb.home"/></a></li>
				<li><span class="crumb active"><fmt:message key="shareProd.shareProdText"/></span></li>
			</ul>
		</section>
		
		<!-- page title -->
		<div class="section-title hide-for-large">
			<h1><fmt:message key="shareProd.shareProdText"/></h1>
		</div>



	<dsp:layeredBundle basename="com.lzb.common.MobileWebAppResources">
		<dsp:getvalueof var="formError" bean="GiftlistFormHandler.formError"/>

		<div class="social-share">


		<dsp:form  method="post" name="shareProdByEmail" id="shareProdByEmail" formid="shareProdByEmail" autocomplete="false" data-validate>
			<div class="field-group">
				<label for="senderName"><fmt:message key="shareProd.yourName"/><span>*</span><span class="sr-only"><fmt:message key="shareProd.yourName"/></span></label>
				<dsp:input type="text" bean="GiftlistFormHandler.profileValueMap.senderName" name="senderName" id="senderName" data-validation="required name" aria-required="true" data-fieldname="Your Name" placeholder="Your Name"/>
			</div>
		
			<div class="field-group">
				<label for="senderEmail"><fmt:message   key="shareProd.yourEmail"/><span>*</span><span class="sr-only"><fmt:message key="shareProd.yourEmail"/></span></label>
				<dsp:input type="text" bean="GiftlistFormHandler.profileValueMap.senderEmail" name="senderEmail" id="senderEmail" data-validation="required email" aria-required="true" data-fieldname="Your Email Address" placeholder="name@email.com"/>
			</div>
		
			<div class="field-group">
				<label for="reciepientName"><fmt:message key="shareProd.recipientName"/><span>*</span><span class="sr-only"><fmt:message key="shareProd.recipientName"/></span></label>
				<dsp:input type="text" bean="GiftlistFormHandler.profileValueMap.reciepientName" name="reciepientName" id="reciepientName" data-validation="required name" aria-required="true" data-fieldname="Recipient Name" placeholder="Recipient Name"/>
			</div>
		
			<div class="field-group">
				<label for="reciepientEmail"><fmt:message key="shareProd.recipientEmail"/><span>*</span><span class="sr-only"><fmt:message key="shareProd.recipientEmail"/></span></label>
				<dsp:input type="text" bean="GiftlistFormHandler.profileValueMap.reciepientEmail" name="reciepientEmail" id="reciepientEmail" data-validation="required email" aria-required="true" data-fieldname="Recipient Email Address" placeholder="Recipient Email Address"/>
			</div>
			<dsp:input type="hidden" bean="GiftlistFormHandler.productId" value="${productId}"/>
			<dsp:input type="hidden" bean="GiftlistFormHandler.productName" value="${productName}"/>
			<dsp:input type="hidden" bean="GiftlistFormHandler.skuNo" value="${skuId}"/>
			<dsp:input type="hidden" bean="GiftlistFormHandler.coverSkuId" value="${coverSkuNo}"/>
			<dsp:input type="hidden" bean="GiftlistFormHandler.shareItemserrorURL" value="${pageContext.request.contextPath}/account/shareProductByEmail.jsp?error=true&coverSkuId=${coverSkuNo}&prodId=${productId}&ProdName=${productName}&skuNo=${skuId}"/>
			<dsp:input type="hidden" bean="GiftlistFormHandler.shareItemssuccessURL" value="${pageContext.request.contextPath}/account/shareProductSuccess.jsp?success=true&skuId=${skuId}&productName=${productName}"/>
			<dsp:input type="submit" bean="GiftlistFormHandler.shareProductByEmail" value="submit" iclass="button primary"/>
		</dsp:form>
	</dsp:layeredBundle>
	</jsp:body>
</layout:default>
</dsp:page>