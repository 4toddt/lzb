<dsp:page>
<dsp:importbean bean="/atg/commerce/catalog/comparison/ProductList" />
<dsp:getvalueof var="productListItems" bean="ProductList.items" />
<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
<dsp:importbean bean="/atg/userprofiling/Profile" />
<dsp:getvalueof var="dealerId" bean="/atg/userprofiling/ProfileTools.priceListId" />
	<!-- dsp:getvalueof var="dealerId" bean="Profile.currentDealerId" / -->
<dsp:importbean bean="/com/lzb/droplet/LZBWishListContainDroplet" />
<dsp:getvalueof var="cotextPath" value="${originatingRequest.ContextPath}" />
<c:choose>
		<%-- We have products in the comparisons list so render them --%>
	<c:when test="${not empty productListItems}">
		
	
			<c:forEach var="comparisonListItem" items="${productListItems}" varStatus="status">
				<dsp:param name="indexvalue" value="${status.count-1}"/>
				<dsp:getvalueof var="skuId" value="${comparisonListItem.sku.repositoryId}" />
		   		<dsp:getvalueof var="productId" value="${comparisonListItem.product.repositoryId}" />
		   		<dsp:getvalueof var="coverSkuId" value="${comparisonListItem.defaultCoverId}" />
		   		<dsp:getvalueof var="json" value="${comparisonListItem.jsonString}" />
				<td>
					<dsp:getvalueof var="pdpurl" param="urlparam[param:indexvalue]"/>
					
					<a href="${cotextPath}${pdpurl}" aria-label="Customize It link" class="customize-it-link">
						<span class="btn btn-primary customize-it"><fmt:message key="compare.customizedit"/></span>
					</a>
					<span>
					
	<%-- JIRA DMI-1763 Hide Wishlist UI
	<dsp:droplet name="LZBWishListContainDroplet">
	     <dsp:param name="configSkuId" value="${skuId}" />
	     <dsp:param name="productId" value="${productId}"/>
	     <dsp:param name="profile" bean="/atg/userprofiling/Profile" />
		<dsp:oparam name="true">
		<dsp:getvalueof var="wishlistid" param="wishListId"/>
			<span class="cdp-wishlist active-wishlist" data-skuid="${skuId}" data-productid="${productId}" data-coverid="${coverSkuId}" data-dealerid="${dealerId}" data-wishlistid="${wishlistid}">		
				<img src="/img/heartred.png" class="heart" alt="heart icon" tabindex="0"/>	
				<span><fmt:message key="compare.add.wishlit"/></span>
			</span>
		</dsp:oparam>				
		<dsp:oparam name="false">
			<span class="cdp-wishlist" data-skuid="${skuId}" data-productid="${productId}" data-coverid="${coverSkuId}" data-dealerid="${dealerId}" data-wishlistid="${wishlistid}">
				<img src="/img/heart.png" class="heart" alt="heart icon" tabindex="0" />
				<span><fmt:message key="compare.add.wishlit"/></span>
			</span>
		</dsp:oparam>
   </dsp:droplet>
   --%>
					
				<%-- 	<a href='#' onclick='moveToWishList(this)' data-skuid="${skuId}" data-productid="${productId}" data-iteminfo='${json}'>
						<img src="/img/heart.png" alt="heart" />
						<span><fmt:message key="compare.add.wishlit"/></span>
					</a> --%>
					</span>
				</td>
			</c:forEach>
		
	</c:when>
	
	</c:choose>
</dsp:page>