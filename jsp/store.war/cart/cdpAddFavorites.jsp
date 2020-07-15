<%-- JIRA DMI-1763 Hide Wishlist UI
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<dsp:page>
	<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBWishListContainDroplet" />

	<dsp:getvalueof var="record" param="record"/>
	<dsp:getvalueof var="dealerId" param="dealerId"/>
	<dsp:getvalueof var="refPage" param="refPage"/>
	<dsp:getvalueof var="prodName" param="prodName"/>

	<c:choose>
		<c:when test="${refPage eq 'quickView'}">
			<dsp:getvalueof var="skuId" value="${record['sku.repositoryId']}"/>
			<dsp:getvalueof var="productId" value="${record['product.repositoryId']}"/>
			<dsp:getvalueof var="defaultCoverSku" value="${record['defaultCoverSku']}"/>
		</c:when>
		<c:otherwise>
			<dsp:getvalueof var="skuId" value="${record.attributes['sku.repositoryId']}"/>
			<dsp:getvalueof var="productId" value="${record.attributes['product.repositoryId']}"/>
			<dsp:getvalueof var="defaultCoverSku" value="${record.attributes['defaultCoverSku']}"/>
		</c:otherwise>
	</c:choose>

	<dsp:droplet name="LZBWishListContainDroplet">
		<dsp:param name="configSkuId" value="${skuId}" />
		<dsp:param name="productId" value="${productId}"/>
		<dsp:param name="profile" bean="/atg/userprofiling/Profile" />
		<dsp:oparam name="true">
			<dsp:getvalueof var="wishlistid" param="wishListId"/>
			<span class="cdp-wishlist active-wishlist ${refPage}" data-prodname="${prodName }" data-skuid="${skuId}" data-cover-type="cover" data-productid="${productId}" data-coverid="${defaultCoverSku}" data-dealerid="${dealerId}" data-wishlistid="${wishlistid}">
				<span class="icon icon-heart" tabindex="0">
					<span class="sr-only">Open a add to wishlist modal</span>
				</span>
			</span>
		</dsp:oparam>
		<dsp:oparam name="false">
			<span class="cdp-wishlist ${refPage}" data-prodname="${prodName }" data-skuid="${skuId}" data-cover-type="cover" data-productid="${productId}" data-coverid="${defaultCoverSku}" data-dealerid="${dealerId}">
				<span class="icon icon-heart-outline" tabindex="0">
					<span class="sr-only">Open a add to wishlist modal</span>
				</span>
			</span>
		</dsp:oparam>
	</dsp:droplet>

</dsp:page>
--%>