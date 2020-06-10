<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet"/>
	<dsp:getvalueof var="currentStore" bean="Profile.currentStore"/>
	<dsp:getvalueof var="preferredStore" bean="Profile.preferredStore"/>
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}"/>

	<c:choose>
		<c:when test="${not empty preferredStore}">
			<dsp:getvalueof var="storeId" value="${preferredStore.repositoryId}"/>
		</c:when>
		<c:otherwise>
			<dsp:getvalueof var="storeId" value="${currentStore.repositoryId}"/>
		</c:otherwise>
	</c:choose>

	<c:if test="${not empty storeId }">
		<dsp:getvalueof var="designServicesLink" value="http://www.la-z-boystore.com/designer-of-the-period/?id=${storeId}&redirect=true" scope="page"/>
	</c:if>

	<div class="half-page-promo clearfix" tabindex="0">
		<p>${contentItem.paragraphTitle}</p>
		<h3>${contentItem.heading3}</h3>
		<div class="content">
			<div class="promo-col col-1">
				<h4>${contentItem.heading4}</h4>
				<p>${contentItem.paragraph}</p>

				<c:choose>
					<c:when test="${contentItem.useDesignServicesLinkTextOverride}">
						<c:if test="${not empty designServicesLink }">
							<c:set var="actionURLTextLink" value="${designServicesLink}"/>
						</c:if>
					</c:when>
					<c:otherwise>
						<c:if test="${not empty contentItem.textLink}">
							<dsp:droplet name="ActionURLDroplet">
								<dsp:param name="action" value="${contentItem.textLink}"/>
								<dsp:oparam name="output">
									<dsp:getvalueof var="actionURLTextLink" param="actionURL"/>
									<%-- Text Link Parsed --%>
								</dsp:oparam>
								<dsp:oparam name="empty"></dsp:oparam>
							</dsp:droplet>
						</c:if>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${contentItem.useDesignServicesLinkButtonOverride}">
						<c:set var="actionURLCTALink" value="${designServicesLink}"/>
					</c:when>
					<c:otherwise>
						<c:if test="${not empty contentItem.CTALink}">
							<dsp:droplet name="ActionURLDroplet">
								<dsp:param name="action" value="${contentItem.CTALink}"/>
								<dsp:oparam name="output">
									<dsp:getvalueof var="actionURLCTALink" param="actionURL"/>
									<%-- CTA Link Parsed --%>
								</dsp:oparam>
								<dsp:oparam name="empty"></dsp:oparam>
							</dsp:droplet>
						</c:if>
					</c:otherwise>
				</c:choose>

				<c:if test="${not empty actionURLTextLink}">
					<a href="${contextLinkPath}${actionURLTextLink}" aria-label="${contentItem.textLinkTitle}" tabindex="0">${contentItem.textLinkTitle}</a>
				</c:if>
				<c:if test="${not empty actionURLCTALink}">
					<a href="${actionURLCTALink}" class="button secondary small" aria-label="${contentItem.CTAButtonText}" tabindex="0">${contentItem.CTAButtonText}</a>
				</c:if>
			</div>
			<div class="promo-col col-2">
				<img src="${contentItem.imageUrl}" alt="${contentItem.heading4}"/>
			</div>
		</div>
	</div>

</dsp:page>
