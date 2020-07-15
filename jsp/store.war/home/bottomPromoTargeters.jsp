<dsp:importbean bean="/com/lzb/droplet/UmbracoContentDroplet" />
<dsp:importbean bean="/atg/userprofiling/Profile" />
<dsp:droplet name="/atg/targeting/TargetingFirst">
	<dsp:param name="targeter"
		bean="/atg/registry/RepositoryTargeters/GlobalHomePageBottomService2Promo" />
	<dsp:oparam name="output">
		<dsp:getvalueof param="element" var="element" />
		<c:if test="${fn:contains(element.itemDescriptor,'promoSlotItem')}">
			<c:if test="${not empty element.linkURL}">
				<div>
					<a title="${element.image.name}" href="${element.linkURL}" aria-label="${element.image.name}-link"> 
						<img src="${element.image.url}" alt="${element.image.name}" />
					</a>
					<!--  <h3>${element.title }</h3> -->
				</div>
			</c:if>
		</c:if>
	</dsp:oparam>
</dsp:droplet>

<dsp:droplet name="UmbracoContentDroplet">
	<dsp:param name="contentType" value="Banner" />
	<dsp:param name="bannerName" value="homesmallpromoslot1" />
	<dsp:param name="dealerId" bean="Profile.currentStore.repositoryId" />
	<dsp:oparam name="output">
			<dsp:getvalueof var="imageUrl" vartype="String" param="response" />
			<dsp:getvalueof var="bannerMap" vartype="String" param="bannerMap" />
			<div>
				<a href="${bannerMap.bannerURL}" aria-label="${bannerMap.bannerURL}"> 
					<img src="${bannerMap.bannerImage}" alt="${bannerMap.bannerAltText}"/>
				</a>
				<!--  <h3>&nbsp;&nbsp;&nbsp;</h3> -->
			</div>
	</dsp:oparam>
</dsp:droplet>

<dsp:droplet name="/atg/targeting/TargetingFirst">
	<dsp:param name="targeter"
		bean="/atg/registry/RepositoryTargeters/GlobalHomePageBottomService3Promo" />
	<dsp:oparam name="output">
		<dsp:getvalueof param="element" var="element" />
		<c:if test="${fn:contains(element.itemDescriptor,'promoSlotItem')}">
			<c:if test="${not empty element.linkURL}">
				<div>
					<a title="${element.image.name}" href="${element.linkURL}"> 
						<img src="${element.image.url}" alt="${element.image.name}" />
					</a>
					<!-- <h3>${element.title }</h3> -->
				</div>
			</c:if>
		</c:if>
	</dsp:oparam>
</dsp:droplet>
