<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:getvalueof var="currentStore" bean="Profile.currentStore"/>
	<dsp:getvalueof var="preferredStore" bean="Profile.preferredStore"/>

	<c:choose>
		<c:when test="${not empty preferredStore}">
			<dsp:getvalueof var="storeId" value="${preferredStore.repositoryId}"/>
		</c:when>
		<c:otherwise>
			<dsp:getvalueof var="storeId" value="${currentStore.repositoryId}"/>
		</c:otherwise>
	</c:choose>
	
	<c:if test="${not empty storeId }">
		<dsp:getvalueof var="actionURLLink" value="http://www.la-z-boystore.com/designer-of-the-period/?id=${storeId}&redirect=true" scope="page" />
	</c:if>
	
	<div class="vertical-promo">
		<a href="${actionURLLink}" class="image-link" aria-label="${contentItem.buttonText}" tabindex="0">
			<img src="${contentItem.imageUrl}" alt="${contentItem.imageAltText}" />
		</a>
		<div class="content">
			<h4>${contentItem.title}</h4>
			<c:if test="${not empty contentItem.description}">
				<p>${contentItem.description}</p>
			</c:if>
			<a href="${actionURLLink}" class="button secondary-btn" aria-label="${contentItem.buttonText}" tabindex="0">${contentItem.buttonText}</a>
		</div>
	</div>

</dsp:page>
