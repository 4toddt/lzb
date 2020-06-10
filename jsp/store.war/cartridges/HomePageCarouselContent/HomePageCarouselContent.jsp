<dsp:page>
		<dsp:importbean bean="/com/lzb/endeca/EndecaContentAssemblerDroplet" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:getvalueof value="${storeConfig.endecaMediaURL}" var="mediaURL"/>
	
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
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
		<c:if test ="${not empty content.text}">
				<small>${content.text} </small>
			</c:if> 
		<c:if test ="${not empty content.imageUrl}">
		<a href="${actionURL}">
			<c:if test ="${not empty content.text}">
				<small>${content.text} </small>
			</c:if>
			<c:if test="${empty actionURL}">
				<c:set var="actionURL" value="#" />
			</c:if>
			
			<c:if test ="${not empty content.imageUrl}">
				<img src="${content.imageUrl}" />
			</c:if>
			
		</a>
	</c:if>
	</c:if>
</dsp:page>