<dsp:page> 
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBComponentExists"/>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/com/lzb/droplet/UmbracoContentDroplet" />
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet"/>
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	
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
		<dsp:getvalueof value="${content.typeOfPromoBlock}" var="typeOfPromoBlock" />

		<c:choose>
			<c:when test="${typeOfPromoBlock eq 1}">
				<%-- BCC targter--%>	
				<dsp:getvalueof value="${content.targeterName}" var="targeterName" />	
				<c:if test="${targeterName ne null && not empty targeterName}"> 
					<dsp:droplet name="LZBComponentExists">
						<dsp:param name="path" value="${storeConfig.defaultTargeterPath}${targeterName}"/>
						<dsp:oparam name="true">
							<dsp:droplet name="/atg/targeting/TargetingFirst">
								<dsp:param name="targeter" bean="${storeConfig.defaultTargeterPath}${targeterName}"/>
								<dsp:oparam name="output">
									<div class="secondary-promo">
										<dsp:getvalueof param="element" var="element" />
										<c:if test="${fn:contains(element.itemDescriptor,'media-external')}" >
											<a title="${element.name}" href="${actionURL}">
												<img src="${element.url}" alt="${element.name}" />
											</a>
										</c:if>
										<c:if test="${fn:contains(element.itemDescriptor,'media-internal-text')}" >
											<a title="${element.name}" href="${actionURL}">
												<dsp:valueof param="element.data" valueishtml="true" />
											</a>
										</c:if>
									</div>
								</dsp:oparam>
							</dsp:droplet>
						</dsp:oparam>
						<dsp:oparam name="false">
							<%-- Targeter does not available --%> 
						</dsp:oparam>
					</dsp:droplet>
				</c:if> 		
			</c:when>
			<c:otherwise>
				<%-- Direct image url --%>
				<div class="secondary-promo">
					<a href="${actionURL}">
						<img src="${content.imageURL}"  alt="${content.imageAltText}"/>
					</a>	
				</div>
			</c:otherwise>
		</c:choose>
	</c:if>
</dsp:page>