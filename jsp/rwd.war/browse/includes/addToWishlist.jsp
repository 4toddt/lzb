<%--
	- File Name: addToWishlist.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This page lays out the add to wishlist action.
	- Required Parameters:
		- record: single product record
        - dealerId
        - refPage
        - prodName
	- Optional Parameters:
--%>
<dsp:page>
    <%-- Imports --%>
    <%-- TODO: DO WE NEED THIS IMPROT: GiftlistFormHandler and why is this also in the ResultsListRecordsLoop.jsp??? --%>
    <dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler"/>
    <dsp:importbean bean="/com/lzb/droplet/LZBWishListContainDroplet" />

    <%-- Page Variables --%>
    <dsp:getvalueof var="record" param="record"/>
	<dsp:getvalueof var="dealerId" param="dealerId"/>
	<dsp:getvalueof var="refPage" param="refPage"/>
	<dsp:getvalueof var="prodName" param="prodName"/>

    <%-- Reference Page Detection --%>
    <c:choose>
		<c:when test="${refPage eq 'quickView'}">
			<%-- Quick View has not been setup in rwd.war. Commenting out incase of future itegration. --%>
            <%-- <dsp:getvalueof var="skuId" value="${record['sku.repositoryId']}"/>
			<dsp:getvalueof var="productId" value="${record['product.repositoryId']}"/>
			<dsp:getvalueof var="defaultCoverSku" value="${record['defaultCoverSku']}"/> --%>
		</c:when>
		<c:otherwise>
			<dsp:getvalueof var="skuId" value="${record.attributes['sku.repositoryId']}"/>
			<dsp:getvalueof var="productId" value="${record.attributes['product.repositoryId']}"/>
			<%-- TODO: product record does not contain defaultCoverSku so this is empty on both rwd.war and store.war --%>
            <dsp:getvalueof var="defaultCoverSku" value="${record.attributes['defaultCoverSku']}"/>
		</c:otherwise>
	</c:choose>

    <%-- Checks against user profile and renders the add to wishlist action --%>
    <dsp:droplet name="LZBWishListContainDroplet">
		<dsp:param name="configSkuId" value="${skuId}" />
		<dsp:param name="productId" value="${productId}"/>
		<dsp:param name="profile" bean="/atg/userprofiling/Profile" />
		<dsp:oparam name="true">
			<dsp:getvalueof var="wishlistid" param="wishListId"/>
            <%-- Display Selected Wishlist Item --%>
            <a href="javascript:void(0);" class="add-to-wishlist ${refPage}" data-prodname="${prodName}" data-skuid="${skuId}" data-cover-type="cover" data-productid="${productId}" data-coverid="${defaultCoverSku}" data-dealerid="${dealerId}" data-wishlistid="${wishlistid}">
                <span class="icon icon-heart-filled" aria-hidden="true"></span>
                <span class="sr-only"><fmt:message key="common.wishlist.srAction"/></span>
            </a>
		</dsp:oparam>
		<dsp:oparam name="false">
            <%-- Display Unselected Wishlist Item --%>
            <a href="javascript:void(0);" class="add-to-wishlist ${refPage}" data-prodname="${prodName}" data-skuid="${skuId}" data-cover-type="cover" data-productid="${productId}" data-coverid="${defaultCoverSku}" data-dealerid="${dealerId}">
                <span class="icon icon-heart-empty" aria-hidden="true"></span>
                <span class="sr-only"><fmt:message key="common.wishlist.srAction"/></span>
            </a>
		</dsp:oparam>
	</dsp:droplet>
</dsp:page>
