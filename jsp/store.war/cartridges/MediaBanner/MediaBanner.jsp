<dsp:page>
	<dsp:importbean bean="/com/lzb/endeca/EndecaContentAssemblerDroplet" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />
	<dsp:importbean bean="/atg/endeca/ApplicationConfiguration.workbenchURL" var="workbenchURL"/>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:getvalueof value="${storeConfig.endecaMediaURL}" var="mediaURL"/>
	
	<dsp:getvalueof var="content"
		vartype="com.endeca.infront.assembler.ContentItem"
		value="${originatingRequest.contentItem}" />
	<c:if test="${not empty content}">
		<c:if test="${not empty content.link}">
				<%-- Get the URL for the action passed within content item --%>
			<dsp:droplet name="ActionURLDroplet">
				<dsp:param name="action" value="${content.link}" />
				<dsp:oparam name="output">
					<dsp:getvalueof var="actionURL" param="actionURL" />
				</dsp:oparam>
				<dsp:oparam name="empty">
				</dsp:oparam>
			</dsp:droplet>
		</c:if> 
		<c:if test="${empty actionURL}">
			<c:set var="actionURL" value="#" />
		</c:if>
		<a title="" href="${actionURL}">
			<img src="${mediaURL}${content.media.uri}" alt="${content.imageAlt}" height="${content.media.contentHeight}" width="${content.media.contentWidth}" />
		</a>
		<c:if test="${not empty content.thumbnail.uri }">
			Thumbnail Image: <img src="${mediaURL}${content.thumbnail.uri}" />
		</c:if>			
		<c:if test="${not empty content.overlay }">
			Overlay: ${content.overlay }
		</c:if>
		<c:if test="${not empty content.title }">
			title: ${content.title }
		</c:if>
		<c:if test="${not empty content.subTitle }">
			subTitle: ${content.subTitle }
		</c:if>
		<c:if test="${not empty content.description }">
			description: ${content.description }
		</c:if>
		<c:if test="${not empty content.linktext1 }">
			linktext1: ${content.linktext1 }
			<c:if test="${not empty content.link1}">
				<%-- Get the URL for the action passed within content item --%>
				<dsp:droplet name="ActionURLDroplet">
					<dsp:param name="action" value="${content.link1}" />
					<dsp:oparam name="output">
						<dsp:valueof param="actionURL" />
					</dsp:oparam>
					<dsp:oparam name="empty">
						Link Empty
					</dsp:oparam>
				</dsp:droplet>
			</c:if>
		</c:if>
		<c:if test="${not empty content.linktext2 }">
			linktext2: ${content.linktext2 }
			<c:if test="${not empty content.link1}">
				<%-- Get the URL for the action passed within content item --%>
				<dsp:droplet name="ActionURLDroplet">
					<dsp:param name="action" value="${content.link2}" />
					<dsp:oparam name="output">
						<dsp:valueof param="actionURL" />
					</dsp:oparam>
					<dsp:oparam name="empty">
						Link Empty
					</dsp:oparam>
				</dsp:droplet>
			</c:if>
		</c:if>
	</c:if>
</dsp:page>