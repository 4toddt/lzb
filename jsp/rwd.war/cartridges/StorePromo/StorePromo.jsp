<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}"/>
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet"/>
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:getvalueof var="currentStore" bean="Profile.currentStore"/>
	<dsp:getvalueof var="preferredStore" bean="Profile.preferredStore"/>

	<c:set var="heading" value="${contentItem.heading}"/>
	<c:set var="description" value="${contentItem.description}"/>
	<c:set var="imageUrl" value="${contentItem.imageUrl}"/>
	<c:set var="imageLink" value="${contentItem.imageLink}"/>
	<c:set var="CTAButtonText" value="${contentItem.CTAButtonText}"/>
	<c:set var="CTALink" value="${contentItem.CTALink}"/>

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

	<c:choose>
		<c:when test="${contentItem.useDesignServicesImageLinkOverride}">
			<c:if test="${not empty designServicesLink }">
				<c:set var="actionURLImageLink" value="${designServicesLink}"/>
			</c:if>
		</c:when>
		<c:otherwise>
			<c:if test="${not empty imageLink }">
				<dsp:droplet name="ActionURLDroplet">
					<dsp:param name="action" value="${imageLink}"/>
					<dsp:oparam name="output">
						<dsp:getvalueof var="actionURLImageLink" param="actionURL"/>
						<%-- Image Link Parsed --%>
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
			<c:if test="${not empty CTALink}">
				<dsp:droplet name="ActionURLDroplet">
					<dsp:param name="action" value="${CTALink}"/>
					<dsp:oparam name="output">
						<dsp:getvalueof var="actionURLCTALink" param="actionURL"/>
						<%-- CTA Link Parsed --%>
					</dsp:oparam>
					<dsp:oparam name="empty"></dsp:oparam>
				</dsp:droplet>
			</c:if>
		</c:otherwise>
	</c:choose>

	<div class="vertical-promo">
		<c:choose>
			<c:when test="${not empty actionURLImageLink}">
				<a href="${actionURLImageLink}" class="image-link" aria-label="${CTAButtonText}" tabindex="0">
					<img src="${imageUrl}" alt="${heading}"/>
				</a>
			</c:when>
			<c:otherwise>
				<img src="${imageUrl}" alt="${heading}"/>
			</c:otherwise>
		</c:choose>
		<div class="content">
			<h4>${heading}</h4>
			<p class="small">${description}</p>
			<a href="${actionURLCTALink}" class="button secondary medium" aria-label="${CTAButtonText}" tabindex="0">${CTAButtonText}</a>
		</div>
	</div>

</dsp:page>
