<dsp:page>

	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:getvalueof param="sectionalPieces" var="sectionalPieces" />
	<dsp:getvalueof param="customOptions" var="customOptions" />
	<dsp:getvalueof param="page" var="pageName" />
	
	<dsp:droplet name="/com/lzb/droplet/LZBOptionsAndUpgradesDroplet">
		<dsp:param name="location" value="cart"  />
		<dsp:param name="subSkuId" param="skuId"  />
		<dsp:oparam name="output">
			<dsp:getvalueof var="optionLabelMap" param="customOptionLabelMap" />
		</dsp:oparam> 
	</dsp:droplet>	
	
	<c:choose>
		<c:when test="${fn:length(sectionalPieces) > 0}">
			<li>Sectional Pieces:</li>
			<dsp:droplet name="ForEach">
			<dsp:param name="array" value="${sectionalPieces}" />
			<dsp:param name="elementName" value="sectionalPiece" />
			<dsp:oparam name="output">
				
				<li><dsp:valueof param="sectionalPiece.auxiliaryData.catalogRef.displayName" /></li>
					
				<dsp:getvalueof var="optionItemInfo" param="customOption.optionInfo" />
	
				<dsp:getvalueof param="sectionalPiece.auxiliaryData.catalogRef.id" var="sectionalSkuId" />
					
				<dsp:droplet name="ForEach">
				<dsp:param name="array" value="${customOptions}" />
				<dsp:param name="elementName" value="customOption" />
				<dsp:oparam name="outputStart">
					<ul class="sectional">
				</dsp:oparam>
				<dsp:oparam name="output">
					<dsp:getvalueof param="customOption.auxiliaryData.catalogRef.id" var="optionSkuId" /> 
						
					<c:if test="${(not empty optionSkuId and not empty sectionalSkuId) and fn:startsWith(optionSkuId, sectionalSkuId)}">
						<li><dsp:valueof param="customOption.auxiliaryData.catalogRef.displayName" /></li>
															
						<dsp:getvalueof var="optionItemInfo" param="customOption.optionInfo" />
						
						<c:if test="${not empty optionItemInfo}">
							<dsp:getvalueof var="optionType" value="${optionItemInfo.optionType }" />
																	
							<c:if test="${not empty optionType and optionType eq 'optionCover'}">
								<li>
									<c:out value="${optionItemInfo.colorName}" />
									(<c:out value="${optionItemInfo.optionValue}" />)
								</li>
							</c:if>
							<c:if test="${not empty optionType and optionType eq 'optionValue'}">
								<li>
									<c:out value="${optionItemInfo.optionValue}" />
								</li>
							</c:if>
						</c:if>
					</c:if>
				</dsp:oparam>
				<dsp:oparam name="outputEnd">
					</ul>
				</dsp:oparam>
				</dsp:droplet>
			</dsp:oparam>
			</dsp:droplet>
		</c:when>
		<c:when test="${not empty customOptions}">
			<dsp:droplet name="ForEach">
			<dsp:param name="array" value="${customOptions}" />
			<dsp:param name="elementName" value="customOption" />
			<dsp:oparam name="output">
				<li>
					<dsp:getvalueof var="cutomOptionDisplayNameSelected" param="customOption.auxiliaryData.catalogRef.displayName" />
					<c:forEach items="${optionLabelMap}" var="label">
						<c:if test="${not empty cutomOptionDisplayNameSelected and cutomOptionDisplayNameSelected eq label.key}">
							${label.value}: ${cutomOptionDisplayNameSelected}
							
							<dsp:getvalueof var="optionItemInfo" param="customOption.optionInfo" />

							<c:if test="${not empty optionItemInfo}">
								<dsp:getvalueof var="optionType" value="${optionItemInfo.optionType}" />
								<c:if test="${not empty optionType and optionType eq 'optionCover'}">
									&#150; <c:out value="${optionItemInfo.colorName}" />
									(<c:out value="${optionItemInfo.optionValue}" />)
								</c:if>
								<c:if test="${not empty optionType and optionType eq 'optionValue'}">
									&#150; <c:out value="${optionItemInfo.optionValue}" />
								</c:if>
							</c:if>
						</c:if>
					</c:forEach>
				</li>
			</dsp:oparam>
			</dsp:droplet>
		</c:when>
	</c:choose>		
</dsp:page>
