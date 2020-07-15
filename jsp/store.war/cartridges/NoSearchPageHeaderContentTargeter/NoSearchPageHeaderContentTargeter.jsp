<dsp:page>
<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
<dsp:importbean bean="/com/lzb/droplet/LZBComponentExists"/>
<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet"/>
<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
<dsp:getvalueof value="${content.targeterName}" var="targeterName" />
<dsp:droplet name="LZBComponentExists">
	<dsp:param name="path" value="${storeConfig.defaultTargeterPath}${targeterName}"/>
	<dsp:oparam name="true">
	<c:if test="${not empty content}">
		<c:if test="${not empty content.titleLink}">
				<%-- Get the URL for the action passed within content item --%>
			<dsp:droplet name="ActionURLDroplet">
				<dsp:param name="action" value="${content.titleLink}" />
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
	</c:if>
   	<dsp:droplet name="/atg/targeting/TargetingFirst">
	    <dsp:param name="targeter" bean="${storeConfig.defaultTargeterPath}${targeterName}"/>
	  	<dsp:oparam name="output">
			<dsp:getvalueof param="element" var="element" />
			                    <c:if test="${fn:contains(element.itemDescriptor,'promoSlotItem')}" >									
										 <img src="${element.image.url}" alt="${element.image.name}" />									
									</c:if> 
			
		 <!-- 	<c:if test="${fn:contains(element.itemDescriptor,'media-external')}" >
			<a title="${element.name}" href="${actionURL}">
				<img src="${element.url}" alt="${element.name}" />
			</a>
			</c:if>  -->
			<c:if test="${fn:contains(element.itemDescriptor,'media-internal-text')}" >
				<a title="" href="${actionURL}">
				<dsp:valueof param="element.data" valueishtml="true" />
				</a>
			</c:if>
		</dsp:oparam>
		</dsp:droplet>
		</dsp:oparam>
	<dsp:oparam name="false">
	<%-- Targeter does not available --%>
	</dsp:oparam>
	</dsp:droplet> 
</dsp:page>