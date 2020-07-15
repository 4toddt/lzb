<dsp:page>
<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
<dsp:importbean bean="/com/lzb/droplet/LZBComponentExists"/>
<dsp:getvalueof param="targeterName" var="targeterName" />
<dsp:droplet name="LZBComponentExists">
	<dsp:param name="path" value="${storeConfig.defaultTargeterPath}${targeterName}"/>
	<dsp:oparam name="true">
   	<dsp:droplet name="/atg/targeting/TargetingFirst">
	    <dsp:param name="targeter" bean="${storeConfig.defaultTargeterPath}${targeterName}"/>
	  	<dsp:oparam name="output">
			<dsp:getvalueof param="element" var="element" />
			
			 <c:if test="${fn:contains(element.itemDescriptor,'promoSlotItem')}" >	
			 								
										 <c:if test="${empty element.linkURL}">
									   <img src="${element.image.url}" alt="${element.image.name}" />	
									  </c:if>
									  
									 
									   <c:if test="${not empty element.linkURL}">
									  <a title="${element.image.name}" href="${element.linkURL}">
									   <img src="${element.image.url}" alt="${element.image.name}" />			
									  </a>	
									  </c:if>	
										 							
	      </c:if>
			
			 <!--  <c:if test="${fn:contains(element.itemDescriptor,'media-external')}" >
				<img src="${element.url}" alt="${element.name}" />
			</c:if> -->
			
			<c:if test="${fn:contains(element.itemDescriptor,'media-internal-text')}" >
				<dsp:valueof param="element.data" valueishtml="true" />
			</c:if>
		</dsp:oparam>
		</dsp:droplet>
		</dsp:oparam>
	<dsp:oparam name="false">
	<%-- Targeter does not available --%>
	</dsp:oparam>
	</dsp:droplet> 
	
</dsp:page>