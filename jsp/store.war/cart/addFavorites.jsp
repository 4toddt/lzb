<dsp:page>
<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler"/>
<dsp:getvalueof var="record" param="record"/>
<dsp:getvalueof var="dealerId" param="dealerId"/>

<dsp:importbean bean="/com/lzb/droplet/LZBWishListContainDroplet" />
<dsp:getvalueof var="navUrl" param="${navUrl}"/>
 <dsp:droplet name="LZBWishListContainDroplet">
	     <dsp:param name="configSkuId" value="${record.attributes['sku.repositoryId']}" />
	     <dsp:param name="productId" value="${record.attributes['product.repositoryId']}"/>
	     <dsp:param name="profile" bean="/atg/userprofiling/Profile" />
		<dsp:oparam name="true">
		<dsp:getvalueof var="wishlistid" param="wishListId"/>
		<a href='${navUrl}' onclick='removeFavorites(this)' data-wishlistid="${wishlistid}" >Remove</a>				
		</dsp:oparam>				
		<dsp:oparam name="false">
				<a href='#' onclick='addFavorites(this)' data-skuid="${record.attributes['sku.repositoryId']}" data-productid="${record.attributes['product.repositoryId']}" data-coverid="${record.attributes['defaultCoverSku']}" data-dealerid="${dealerId}">Add To Favorites</a>				
		</dsp:oparam>
</dsp:droplet>	

</dsp:page>