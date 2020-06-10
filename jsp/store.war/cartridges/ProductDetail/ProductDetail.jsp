<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
			<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
			<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
			<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
			<dsp:importbean bean="/atg/userprofiling/Profile" />
			
			<dsp:getvalueof var="contextPath" value="${originatingRequest.ContextPath}" />
			<dsp:getvalueof var="content"vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
			<dsp:getvalueof var="productRecord" value="${content.record.attributes}" />
			<dsp:importbean bean="/com/lzb/droplet/LZBItemJsonRequestDroplet" />
			<c:set var="endecaUrl" value="${requestScope['javax.servlet.forward.request_uri']}" />
			<dsp:include page="/global/giftlisterrors.jsp">
					<dsp:param name="formHandler" bean="GiftlistFormHandler" />
			</dsp:include>
			<dsp:include page="/includes/global/errors.jsp">
			<dsp:param name="formHandler" bean="ProfileFormHandler"/>
			</dsp:include>
			<c:set var="isActive" value="A" />
			<c:set var="isPurchasable" value="true" />
			<c:set var="madeInACABadgeFullImagePath" value="/Images/productIcons/ACA-Badge.png" scope="request" />
			<c:set var="madeInUSABadgeFullImagePath" value="/Images/productIcons/MIA-Badge.png" scope="request" />

			<c:choose>
				<c:when test="${empty productRecord['sku.isPurchaseable']}">
					<c:set var="isPurchasable" value="false" />
				</c:when>
				<c:otherwise>
					<c:set var="isPurchasable" value="${productRecord['sku.isPurchaseable']}" />
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${empty productRecord['sku.status']}">
					<c:set var="isActive" value="D" />
				</c:when>
				<c:otherwise>
					<c:set var="isActive" value="${productRecord['sku.status']}" />
				</c:otherwise>
			</c:choose>
			<dsp:getvalueof var="loginStatus" bean="Profile.transient"/>
			<input type="hidden" class="loginStatus" value="${loginStatus}" />

		<dsp:droplet name="LZBItemJsonRequestDroplet">
			<dsp:param name="commid" param="commid" />
			<dsp:oparam name="output">
			<dsp:getvalueof var="jsonrequest" param="jsonrequest" />
			<dsp:getvalueof var="item_qty" param="item_qty" />
			<c:set var="jsonRequestValue" scope="request" value="${jsonrequest}"/>
			<c:set var="itemQtyValue" scope="request" value="${item_qty}"/>
			</dsp:oparam>
		</dsp:droplet>
		<input type="hidden" id="itemQtyValue" value="${itemQtyValue}" />

	<%-- Defines the conditions of each template --%>
  <dsp:include src="${pageContext.request.contextPath}/includes/pdpComponentData.jsp"/>

  <dsp:include page="/browse/pdp/pdpImage.jsp">
	  <dsp:param name="productRecord" value="${productRecord}"/>
	  <dsp:param name="coverId" param="coverId"/>
  </dsp:include>
	<%-- Render HTML comments for testing proper template loading --%>
	<%-- JIRA DMI-1763 Hide Wishlist UI
	 <p class="wishlist-message" style="display:none;">
        	<span class="wishlist-check-icon"></span>
        	<span class="wishlist-message-text"></span>
        	<span class="wishlist-secondary">
        		<a href="/account/wish_list_items.jsp">View your Favorites</a>
        	</span>
        	<span class="wishlist-close-tag">X</span>
        </p>
	--%>
        <div class="sectionHeaderTemplate">
            <div class="large-swatch-sample">
                 <img src="/img/icon_pillow_standard.jpg"/>
            </div>
            <div class="swatchDetails swatch-sample-details">
                <div class="top-part">
                    <h4 class="suboptH3" class="inject-h3ClassName" data-optionitem="data.sub-option-name"></h4>
                    <span class="accordion-state icon-arrow-down"></span>
                </div>
                <div class="color">
                    <span></span>
                </div>
                <span class="price swatch-price"></span>
            </div>
        </div>

		<%-- Load the correct product detail UI template --%>
		<c:choose>
			<c:when test="${isConfigurable eq 'true'}">
				<%-- Configurable Products --%>
				<dsp:include src="${pageContext.request.contextPath}/browse/pdp/configurableSkuPdp.jsp"></dsp:include>
			</c:when>

			<c:when test="${isDiscontinuedConfigurable eq 'true'}">
				<%-- Configurable Products - Discontinued --%>
				<dsp:include src="${pageContext.request.contextPath}/browse/pdp/discontinuedConfigurableSkuPdp.jsp"></dsp:include>
			</c:when>

			<c:when test="${isSectional eq 'true'}">
				<%-- Sectionals Products --%>
				<dsp:include src="${pageContext.request.contextPath}/browse/pdp/sectionalPdp.jsp"></dsp:include>
			</c:when>

			<c:when test="${isDiscontinuedSectional eq 'true'}">
				<%-- Sectionals Products - Discontinued --%>
				<dsp:include src="${pageContext.request.contextPath}/browse/pdp/discontinuedSectionalPdp.jsp"></dsp:include>
			</c:when>

			<c:when test="${isSimple eq 'true'}">
				<%-- Simple Products --%>
				<dsp:include src="${pageContext.request.contextPath}/browse/pdp/simplePdp.jsp"></dsp:include>
			</c:when>

			<c:when test="${isDiscontinuedSimple eq 'true'}">
				<%-- Simple Products - Discontinued --%>
				<dsp:include src="${pageContext.request.contextPath}/browse/pdp/discontinuedSimplePdp.jsp"></dsp:include>
			</c:when>
		</c:choose>

</dsp:page>