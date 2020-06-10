<dsp:page>
<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler"/>
<dsp:getvalueof var="record" param="record"/>
<dsp:getvalueof var="dealerId" param="dealerId"/>

<dsp:importbean bean="/com/lzb/droplet/LZBWishListContainDroplet" />
<dsp:getvalueof var="navUrl" param="${requestScope['javax.servlet.forward.request_uri']}"/>
<dsp:getvalueof var="record" param="${record}"/>
 <dsp:droplet name="LZBWishListContainDroplet">
	     <dsp:param name="configSkuId" value="${record.attributes['sku.repositoryId']}" />
	     <dsp:param name="productId" value="${record.attributes['product.repositoryId']}"/>
	     <dsp:param name="profile" bean="/atg/userprofiling/Profile" />
		<dsp:oparam name="true">
		<dsp:getvalueof var="wishlistid" param="wishListId"/>
		<a href='${navUrl}' onclick='removeFavorites(this)' data-wishlistid="${wishlistid}" >Remove</a>				
		</dsp:oparam>				
		<dsp:oparam name="false">
				<a href='${navUrl}' id="addToWishListId"><fmt:message key="pdp.addToWishList" /></a>				
		</dsp:oparam>
</dsp:droplet>	

</dsp:page>