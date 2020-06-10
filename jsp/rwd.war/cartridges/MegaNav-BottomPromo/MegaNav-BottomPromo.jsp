<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contentItem"
		vartype="com.endeca.infront.assembler.ContentItem"
		value="${originatingRequest.contentItem}" />
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />

	<dsp:importbean bean="/atg/store/LZBStoreConfiguration"
		var="storeConfig" />
	<dsp:importbean bean="/com/lzb/droplet/LZBComponentExists" />
	<dsp:importbean bean="/com/lzb/droplet/UmbracoContentDroplet" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />

	<c:if test="${not empty contentItem.link }">
		<dsp:droplet name="ActionURLDroplet">
			<dsp:param name="action" value="${contentItem.link}" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="actionURL" param="actionURL" />
			</dsp:oparam>
			<dsp:oparam name="empty">
			</dsp:oparam>
		</dsp:droplet>
	</c:if>

	<dsp:getvalueof value="${contentItem.typeOfPromoBlock}"
		var="typeOfPromoBlock" />

	<div class="dropdown-promo">
		<c:choose>
			<c:when test="${typeOfPromoBlock == 'umbraco'}">
				<%--  Umbaraco--%>
				<dsp:droplet name="UmbracoContentDroplet">
					<dsp:param name="contentType" value="${contentItem.contentType}" />
					<dsp:param name="bannerName" value="${contentItem.contentName}" />
					<dsp:param name="dealerId" bean="Profile.currentStore.repositoryId" />
					<dsp:oparam name="output">
						<dsp:getvalueof var="imageUrl" vartype="String" param="response" />
						<dsp:getvalueof var="bannerMap" vartype="String" param="bannerMap" />
						<c:if test="${not empty bannerMap.bannerImage}">
						<a href="${bannerMap.bannerURL}" class="image-link"
							aria-label="${bannerMap.bannerURL}"> <img
							src="${bannerMap.bannerImage}" class="" alt="" />
						</a>
						</c:if>
					</dsp:oparam>
					<dsp:oparam name="error">
						<!-- Error out Umbraco Content -->
					</dsp:oparam>
				</dsp:droplet>

			</c:when>
			<c:otherwise>
				<%-- Direct image url --%>
				<c:if test="${not empty contentItem.imageUrl}">
				<a href="${actionURL}" class="image-link"><img src="${contentItem.imageUrl}"
					alt="${contentItem.imageAltText}" /></a>
				</c:if>
			</c:otherwise>
		</c:choose>
	</div>
</dsp:page>
