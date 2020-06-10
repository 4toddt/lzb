<%--
    - File Name: orderItem.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page renders the order item row on the cart page.
    - Required Parameters:
    - Optional Parameters:
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
	<dsp:importbean bean="/com/lzb/droplet/LZBItemStatusDroplet" />
	<dsp:importbean bean="/com/lzb/service/SessionBean" var="sessionBean" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>

	<%-- Page Variables --%>
	<dsp:getvalueof var="productName" param="productName" />
	<dsp:getvalueof var="categoryName" param="categoryName" />
	<dsp:getvalueof var="cartItem" param="cartItem" />
    <dsp:getvalueof var="commerceItem" param="cartItem.commerceItem" />
    <dsp:getvalueof var="commerceItemId" param="cartItem.commerceItem.id" />
	<dsp:getvalueof var="catalogRefId" param="cartItem.commerceItem.catalogRefId" />
	<dsp:getvalueof var="quantity" param="cartItem.commerceItem.quantity"/>
	<dsp:getvalueof var="status" param="cartItem.commerceItem.auxiliaryData.catalogRef.status" />

	<dsp:getvalueof var="count" param="count" />
	<c:set var="contentHostName" value="//${storeConfig.contentHostName}"/>

	<dsp:droplet name="LZBPDPURLDroplet">
		<dsp:param name="productId" value="${catalogRefId}" />
		<dsp:param name="prodName" value="${productName}" />
		<dsp:param name="fromCDP" value="true" />
		<dsp:param name="isMobile" value="${isMobile}" />
		<dsp:param name="elementName" value="url" />
		<dsp:param name="categorydisplayName" value="${categoryName}" />
		<dsp:oparam name="output">
			<dsp:getvalueof var="pdpurl" param="url" />
		</dsp:oparam>
	</dsp:droplet>

	<dsp:getvalueof var="fullpdpurl" value="${contextLinkPath}${pdpurl}" />

	<dsp:droplet name="LZBItemStatusDroplet">
	<dsp:param name="commerceitem" value="${commerceItem}" />
	<dsp:oparam name="output">
		<dsp:getvalueof var="status" param="itemdiscontinued" />
		<dsp:getvalueof var="isOptionDiscontinued" param="isOptionDiscontinued" />
	</dsp:oparam>
	</dsp:droplet>
					
	<div class="order-item">
		<a class="product-name hide-for-medium" href="${fullpdpurl}?commid=${commerceItemId}">
			${productName}
		</a>
		<div class="item-image order-item-section">
			<dsp:include page="/checkout/includes/cartItemImage.jsp">
				<dsp:param name="cartItem" param="cartItem" />
				<dsp:param name="asLink" value="${fullpdpurl}?commid=${commerceItemId}" />
				<dsp:param name="productName" value="${productName}" />
			</dsp:include>
		</div>
		<div class="item-details order-item-section">
			<div class="product-name-details">
				<a href="${fullpdpurl}?commid=${commerceItemId}" class="product-name">
					${productName}
				</a>
			
		  		<c:if test="${not cartItem.licensedProduct}">
					<div class="accordion" data-accordion aria-multiselectable="false" role="tablist">
			 			<div class="accordion-container">
			    			<div class="accordion-title product-details" role="tab" aria-controls="productDetailsBody${count}" aria-expanded="false" id="productDetailsTitle${count}" tabindex="0">
			    				<span class="icon icon-arrow-down" aria-hidden="true"></span><fmt:message key="cart.item.productDetails"/>
			    			</div>
			    			<div class="accordion-body" aria-labeledby="productDetailsTitle${count}" role="tabpanel" id="productDetailsBody${count}">
			      				<div class="accordion-body-content">
			      					<ul class="item-detail">
										<li><fmt:message key="cart.item.color"/>: <dsp:valueof param="cartItem.coverItem.auxiliaryData.catalogRef.id" /></li>
			        					<li><fmt:message key="cart.item.material"/>: <dsp:valueof param="cartItem.coverItem.auxiliaryData.catalogRef.materialType" /></li>
			        					<li><fmt:message key="cart.item.pattern"/>: <dsp:valueof param="cartItem.coverItem.auxiliaryData.catalogRef.patternName" /></li>
									</ul>
			        				<ul class="item-detail">
			        					<dsp:getvalueof var="customOptions" param="cartItem.customOptions" />
										<dsp:getvalueof var="sectionalPieces" param="cartItem.sectionalPieces" />
									
			        					<dsp:include page="/checkout/includes/optionalItemsFragment.jsp">
											<dsp:param name="sectionalPieces" value="${sectionalPieces}" />
											<dsp:param name="customOptions" value="${customOptions}" />
											<dsp:param name="skuId" value="${catalogRefId}"/>
										</dsp:include>
			        				</ul>
			      				</div>
			    			</div>
			  			</div>
			  		</div>
				</c:if>
	  		</div>

			<div class="quantity">
				<label for="item-qty-${commerceItemId}" class="hide-for-medium"><fmt:message key="cart.item.qty"/></label>
				<div class="custom-select">
					<select id="item-qty-${commerceItemId}" class="item-qty-value" name="item-qty" data-ciid="${commerceItemId}">
						<c:forEach var="qtyValue" begin="1" end="20">
							<c:choose>
								<c:when test="${qtyValue eq quantity}">
									<option value="${qtyValue}" selected="selected">${qtyValue}</option>
								</c:when>
								<c:otherwise>
									<option value="${qtyValue}">${qtyValue}</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
					<span class="icon icon-dropdown-arrow" aria-hidden="true"></span>
				</div>
			</div>

	  		<div class="item-price-unit" id="item-price-${commerceItemId}">
	  			<div class="price-text"><fmt:message key="cart.item.price"/>&nbsp;</div>
	  			<div class="price">
	  				<dsp:getvalueof var="itemTotal" param="cartItem.itemTotal" />
	  				<dsp:getvalueof var="listPrice" param="cartItem.listPrice" />
					<dsp:getvalueof var="salePrice" param="cartItem.salePrice" />
					<dsp:getvalueof var="listPriceTotal" value="${quantity*listPrice}" />
					<dsp:getvalueof var="salePriceTotal" value="${quantity*salePrice}" />
					
					<span class=" ${empty salePrice || salePrice <= 0.0 ? 'item-total-price' : 'regular-price'}">
						<c:if test="${categoryName ne 'Sectionals' && categoryName ne 'Sectional Pieces'}">
							<dsp:getvalueof var="protectionPlan" param="cartItem.protectionPlan" />
							<dsp:getvalueof var="hasTreatment" param="cartItem.hasTreatment" />
							<dsp:getvalueof var="totalPrice" param='cartItem.protectionPlan.priceInfo.amount' />
							<c:if test="${hasTreatment =='true' && not empty protectionPlan}">
							   <dsp:getvalueof var="totalPlanPrice" value="${totalPrice}" />
							</c:if>
						</c:if>
					
					<c:choose>
						<c:when test="${salePrice > 0.0}">
							<dsp:include page="/global/includes/formattedPrice.jsp">
								<dsp:param name="price" value="${listPriceTotal - totalPlanPrice}" />
							</dsp:include>
						</c:when>
						<c:otherwise>
							<dsp:include page="/global/includes/formattedPrice.jsp">
								<dsp:param name="price" value="${itemTotal}" />
							</dsp:include>
						</c:otherwise>	
					</c:choose>				
					</span>
					<c:if test="${salePrice > 0.0}">
						<span class="sale-price">
							<dsp:include page="/global/includes/formattedPrice.jsp">
								<dsp:param name="price" value="${itemTotal}" />
							</dsp:include>
						</span>					
					</c:if>
				</div>
			</div>
		</div>

		<%-- Protection Plan not available for Sectional products --%>
		<c:if test="${categoryName ne 'Sectionals' && categoryName ne 'Sectional Pieces'}">
			<%-- for after treatment details --%>
			<dsp:getvalueof var="protectionPlan" param="cartItem.protectionPlan" />
			<dsp:getvalueof var="hasTreatment" param="cartItem.hasTreatment" />
			<dsp:getvalueof var="afterTreatmentPlan" param="cartItem.afterTreatmentPlan" />
			<c:choose>
				<c:when test="${hasTreatment =='false' && not empty afterTreatmentPlan}">
					<%-- Cart does not have after treatment paln --%>
					<dsp:getvalueof var="planName" 	param="cartItem.afterTreatmentPlan.displayName" />
					<dsp:getvalueof var="skuId" param="cartItem.afterTreatmentPlan.id" />
					<dsp:getvalueof var="salePrice" param="cartItem.protectionPlanAmount" />
					<dsp:getvalueof var="qty" param="cartItem.afterTreatmentPlan.quantity" />
					<dsp:getvalueof var="planPrice" value="${quantity*salePrice}" />
					<dsp:getvalueof var="planImagePath" param="cartItem.afterTreatmentPlan.smallImage.url" />

					<c:if test="${planPrice gt 0}">
						<div class="item-protection-plan unapplied">
							<c:if test="${not empty planImagePath}">
								<img src="${contentHostName}${planImagePath}" alt="${planName}" class="icon-protection-plan" align="left" />
							</c:if>

							<div id="item-protection-plan-${commerceItemId}" class="item-protection-plan-detail">
								${planName}: 

								<a id="treat_${commerceItemId}" href="#" class="add-remove-plan js-add-plan" data-ciid="${commerceItemId}"><fmt:message key="cart.item.addPlan"/>&nbsp; 
									<dsp:include page="/global/includes/formattedPrice.jsp">
										<dsp:param name="price" value="${planPrice}" />
									</dsp:include>
								</a>
							</div>
						</div>
					</c:if>
				</c:when>
				<c:otherwise>
					<c:if test="${not empty protectionPlan}">
						<dsp:getvalueof var="protectionPlan" param="cartItem.protectionPlan" />
						<dsp:getvalueof var="planName" param="cartItem.protectionPlan.auxiliaryData.catalogRef.displayName" />
						<dsp:getvalueof var="skuId" param="cartItem.protectionPlan.id" />
						<dsp:getvalueof var="totalPrice" param='cartItem.protectionPlan.priceInfo.amount' />
						<dsp:getvalueof var="planSalePrice" param='cartItem.protectionPlan.priceInfo.salePrice' />
						<dsp:getvalueof var="planListPrice" param='cartItem.protectionPlan.priceInfo.listPrice' />
						<dsp:getvalueof var="qty" param="cartItem.protectionPlan.quantity" />
						<dsp:getvalueof var="totalPlanPrice" value="${totalPrice * quantity}" />
						<dsp:getvalueof var="planImagePath" param="cartItem.protectionPlan.auxiliaryData.catalogRef.smallImage.url"/>

						<div class="item-protection-plan">
							<c:if test="${not empty planImagePath}">
								<img src="${contentHostName}${planImagePath}" alt="${planName}" class="icon-protection-plan" align="left" />
							</c:if>

							<div id="item-protection-plan-${commerceItemId}" class="item-protection-plan-detail">
								${planName}: 

								<span class="total-plan-price hide-for-medium">
									<dsp:include page="/global/includes/formattedPrice.jsp">
										<dsp:param name="price" value="${totalPlanPrice}" />
									</dsp:include>
								</span>

								<a id="treat_${commerceItemId}" href="#" class="add-remove-plan js-remove-plan" data-ciid="${commerceItemId}"><fmt:message key="cart.item.removePlan"/></a>

								<div class="total-plan-price hide-for-small">
									<dsp:include page="/global/includes/formattedPrice.jsp">
										<dsp:param name="price" value="${totalPlanPrice}" />
									</dsp:include>
								</div>
							</div>
						</div>
					</c:if>
				</c:otherwise>
			</c:choose>
		</c:if>
		
		<c:choose>
			<c:when test="${status}">
				<div class="cart-content-item-error">
					<span class="icon icon-error"></span>
					<span class="error-msg">
						<fmt:message key="cart.error.itemNotAvailable" />
					</span>
				</div>
			</c:when>
			<c:when test="${isOptionDiscontinued}">
				<dsp:getvalueof var="coverItem" param="cartItem.coverItem" />
				<c:if test="${not empty coverItem}">
					<dsp:getvalueof param="cartItem.coverItem.auxiliaryData.catalogRef.status" var="coverstatus" />
					<c:if test="${coverstatus eq 'D'}">
						<div class="cart-content-item-error">
							<span class="icon icon-error"></span>
							<span class="error-msg">
								<fmt:message key="cart.error.unfortunately" />&nbsp;<dsp:valueof param="cartItem.coverItem.auxiliaryData.catalogRef.displayName" />&nbsp; 
								<fmt:message key="cart.error.selected" />&nbsp;${productName}&nbsp;<fmt:message key="cart.error.noavailable" />  
								<fmt:message key="cart.error.returnToProductPage" />&nbsp;${productName}&nbsp;<fmt:message key="cart.error.fromCart" />
							</span>
						</div>
					</c:if>
				</c:if>
				
				<dsp:getvalueof var="pillowItem" param="cartItem.pillowItem" />
				<c:if test="${not empty pillowItem}">
					<dsp:getvalueof param="cartItem.pillowItem.auxiliaryData.catalogRef.status" var="pillowstatus" />
					<c:if test="${pillowstatus eq 'D'}">
						<div class="cart-content-item-error">
							<span class="icon icon-error"></span>
							<span class="error-msg">
								<fmt:message key="cart.error.unfortunately" />&nbsp;<dsp:valueof param="cartItem.pillowItem.auxiliaryData.catalogRef.displayName" />&nbsp; 
								<fmt:message key="cart.error.selected" />&nbsp;${productName}&nbsp;<fmt:message key="cart.error.noavailable" />  
								<fmt:message key="cart.error.returnToProductPage" />&nbsp;${productName}&nbsp;<fmt:message key="cart.error.fromCart" />
							</span>
						</div>																	
					</c:if>
				</c:if>
				
				<dsp:getvalueof var="customOptions" param="cartItem.customOptions" />
				<c:if test="${not empty customOptions}">
					<dsp:droplet name="ForEach">
					<dsp:param name="array" param="cartItem.customOptions" />
					<dsp:param name="elementName" value="customOption" />
					<dsp:oparam name="output">
						<dsp:getvalueof param="customOption.auxiliaryData.catalogRef.status" var="optionstatus" />
						<c:if test="${optionstatus eq 'D'}">
							<div class="cart-content-item-error">
								<span class="icon icon-error"></span>
								<span class="error-msg">
									<fmt:message key="cart.error.unfortunately" />&nbsp;<dsp:valueof param="customOption.auxiliaryData.catalogRef.displayName" />&nbsp; 
									<fmt:message key="cart.error.selected" />&nbsp;${productName}&nbsp;<fmt:message key="cart.error.noavailable" />  
									<fmt:message key="cart.error.returnToProductPage" />&nbsp;${productName}&nbsp;<fmt:message key="cart.error.fromCart" />
								</span>
							</div>
						</c:if>
					</dsp:oparam>
					</dsp:droplet>
				</c:if>
			</c:when>
		</c:choose>
			
		<div class="item-actions">
			<div class="item-action"><a href="${contextPath}/checkout/ajax/removeItemModal.jsp?ciid=${commerceItemId}&qty=${quantity}" class="item-remove modal-trigger" data-dismiss="modal" data-target="remove-item-modal" tabindex="0" aria-label="Click to remove ${productName}"><fmt:message key="cart.item.remove"/></a></div>
			<%-- NOTE: Commenting out this link as Wishlist functionality was removed from mobile redesign until it can be re-written in a future project --%>
			<%-- <div class="item-action"><a href="" class="item-save"><fmt:message key="cart.item.save"/></a></div> --%>
		</div>
	</div>
</dsp:page>
