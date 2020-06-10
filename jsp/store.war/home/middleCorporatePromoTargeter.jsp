<dsp:droplet name="/atg/targeting/TargetingFirst">
	<dsp:param name="targeter"
		bean="/atg/registry/RepositoryTargeters/GlobalHomePageCorporatePromoImageTargeter" />
	<dsp:oparam name="output">
		<dsp:getvalueof param="element" var="element" />
		<c:if test="${fn:contains(element.itemDescriptor,'promoSlotItem')}">
			<c:if test="${not empty element.linkURL}">
				<a title="${element.image.name}" href="${element.linkURL}"> 
					<img src="${element.image.url}" alt="${element.image.name}" />
				</a>
			</c:if>
		</c:if>
	</dsp:oparam>
</dsp:droplet>