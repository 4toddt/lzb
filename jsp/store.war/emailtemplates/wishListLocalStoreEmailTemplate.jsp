<%@ taglib prefix="dsp"	uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_1"%><%-- JSON Rendering Taglib --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<dsp:page>
<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty" />
<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
<dsp:importbean bean="/com/lzb/droplet/LZBWishListItemDroplet"/>
<dsp:include page="${pageContext.request.contextPath}/cartridges/LZBEmailTemplateHeader/LZBEmailTemplateHeader.jsp">
	<dsp:param name="image_name" value="profile-change"/>
</dsp:include>
	<!-- email template messages  -->
	<dsp:getvalueof var="firstName" param="firstName" />
	<dsp:getvalueof var="formInfoFromMap" param="formDetailFromMap"/> 
	<dsp:getvalueof var="profile" param="profile"/>  
	<p><span><dsp:valueof param="firstName" /></span>,is interested in the following LaZBoy product(s).<fmt:message key="wishList.templateHeadText"/> </p>
	<dsp:getvalueof var="profileCurrentStore" value="${profile.currentStore}"/>
	<dsp:getvalueof var="profilePreferredStore" value="${profile.preferredStore}"/>
	<c:choose>
		<c:when test="${not empty profileCurrentStore}">
			<c:set var="storeDetail" value="${profileCurrentStore}"/>
		</c:when>
		<c:otherwise>
			<c:set var="storeDetail" value="${profilePreferredStore}"/>
		</c:otherwise>
	</c:choose>
	
	<!-- display store detail  -->
	<fmt:message key="wishList.storeInfo"/><br/>
	${storeDetail.name}<br/>
	${storeDetail.address1}<br/>
	${storeDetail.city},${storeDetail.stateAddress},${storeDetail.postalCode}<br/>
	<dsp:a href="#"><fmt:message key="storeLocator.visit"/></dsp:a><br/>
	<dsp:a href="#"><fmt:message key="preferdStore.getDirection"/></dsp:a>
	<br/>
	
	<!--display send local store form details  -->
	<fmt:message key="dealertools.createUser.name"/>: ${formInfoFromMap.fullName} <br/>
	<fmt:message key="dealertools.managedealer.email"/>: ${formInfoFromMap.email}<br/> 
	<fmt:message key="account.wishlist.address"/>: ${formInfoFromMap.address}<br/>
	<fmt:message key="address.city"/>:${formInfoFromMap.city}<br/>
	<fmt:message key="account.wishlist.state"/>:${formInfoFromMap.state}&nbsp;Zip:${formInfoFromMap.postalCode}<br/>
	<fmt:message key="account.wishlist.phone"/>:${formInfoFromMap.phoneNumber} <br/>
	<fmt:message key="store.Comments"/>:${formInfoFromMap.comments}<br/>
	
	<fmt:message key="wishList.templateCstmrText"/> 
	<dsp:a href="#"><fmt:message key="wishList.lzbLink"/></dsp:a>
	<fmt:message key="wishList.templateLearnText"/><br/>
	
	<!-- param hold the selected  wishlist id -->
	<dsp:getvalueof param="selectedWishListId" var="giftListId"/>
	<dsp:getvalueof param="wishListItems" var="wishlist"/>
	<dsp:droplet name="LZBWishListItemDroplet">
		<dsp:param name="id" value="${wishlist}"/>
		<dsp:oparam name="output">
										
		<!-- display the item  based on id which is selected on main wishlist  -->		
			<dsp:getvalueof var="wishlistItemId" param="wishListItem.id" />
			<dsp:getvalueof var="skuId" param="wishListItem.catalogRefId" />
			<dsp:valueof param="wishListItem.description" /> - <dsp:valueof param="wishListItem.displayName" /> <br>
			Product Dimensions:<br/>
			<dsp:valueof param="dimensions"/>
				<dsp:droplet name="ForEach">
					<dsp:param name="array" param="wishListItem.configurationOptions" />
					<dsp:setvalue param="wishlistOptionItem" paramvalue="element"/>
						<dsp:oparam name="output">
							 <dsp:getvalueof var="option" param="wishlistOptionItem.optionCatalogRefid" />
							 <dsp:getvalueof var="suboptions" value="${suboptions}&${option}" /> 
							 <dsp:valueof param="wishlistOptionItem.displayName" /><dsp:valueof param="wishlistOptionItem.Id" />:<dsp:valueof value="${option}"/><br/>
		                     <input type="hidden" name="opt1" value="${suboptions}" />
						</dsp:oparam>
				</dsp:droplet>
				<%-- This email template is not being used as the share wishlist buttons were disabled --%>
				<%-- Image URL needs to be considered if template is enabled --%>
				<dsp:getvalueof var="marxentImageURL" value="/"/>
				<img src="${marxentImageURL}"/>
		</dsp:oparam>
	</dsp:droplet>
	<p><fmt:message key="address.emailSincerelyMsg"/></p>
	<!-- endeca header here -->
				
				<dsp:include page="${pageContext.request.contextPath}/global/includes/emailFooter.jsp">
					<dsp:param name="storePhoneNumber" value="${storeDetail.phoneNumber}"/>
					<dsp:param name="currentDealerId" value="${profile.currentDealerId}"/>
				</dsp:include>
				<dsp:include page="${pageContext.request.contextPath}/cartridges/LZBEmailTemplateFooter/LZBEmailTemplateFooter.jsp"/>
</dsp:page>
