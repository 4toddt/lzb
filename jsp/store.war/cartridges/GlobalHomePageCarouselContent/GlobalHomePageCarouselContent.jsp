<dsp:page>
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler"/>
	<dsp:getvalueof var="transient" bean="Profile.transient" />
	<dsp:getvalueof var="currentStore" bean="Profile.currentStore"/>
	<dsp:getvalueof var="preferredStore" bean="Profile.preferredStore"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBDealerStoreDroplet" />
	<dsp:getvalueof var="storeId" param="storeId"/>
	<c:choose>
		<c:when test="${not empty preferredStore}">
			<c:set var="country" value="${preferredStore.country}" />
		</c:when>
		<c:otherwise>
			<c:set var="country" value="${currentStore.country}" />
		</c:otherwise>
  	</c:choose>
  	
  	<c:if test="${(empty country)}">
		<c:set var="country" value="US" />
  	</c:if>
  	
  	
  		<dsp:droplet name="InvokeAssembler">
				<dsp:param name="contentCollection"
					value="/content/Shared/Homepage Carousel Hero Banner/${country}" />
				<dsp:param name="ruleLimit"
					value="1" />
				<dsp:oparam name="output">
					<dsp:getvalueof var="contentSlot"
						vartype="com.endeca.infront.assembler.ContentItem"
						param="contentItem" />
				</dsp:oparam>
			</dsp:droplet>
			<c:if test="${not empty contentSlot.contents}">
				<c:forEach items="${contentSlot.contents}" var="element">
					<dsp:renderContentItem contentItem="${element}" />
				</c:forEach>
			</c:if>
</dsp:page>