<dsp:page>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:getvalueof param="sectionalPieces" var="sectionalPieces" />
	<dsp:getvalueof param="customOptions" var="customOptions" />

	<p tabindex="0"><fmt:message key="cart.options" /></p>
	<c:choose>
		<c:when test="${ not empty sectionalPieces}">
				<dsp:droplet name="ForEach">
					<dsp:param name="array" value="${sectionalPieces}" />
					<dsp:param name="elementName" value="sectionalPiece" />
					<dsp:oparam name="output">
						<dsp:valueof param="sectionalPiece.auxiliaryData.catalogRef.displayName" />
						<dsp:getvalueof var="optionItemInfo" param="customOption.optionInfo" />
								<p tabindex="0">
								 <dsp:getvalueof param="sectionalPiece.auxiliaryData.catalogRef.id" var="sectionalSkuId" />
									<dsp:droplet name="ForEach">
										<dsp:param name="array" value="${customOptions}" />
										<dsp:param name="elementName" value="customOption" />
										<dsp:oparam name="output">
											<dsp:getvalueof param="customOption.auxiliaryData.catalogRef.id" var="optionSkuId" /> 
											<c:if test="${ (not empty optionSkuId and not empty sectionalSkuId) and fn:startsWith(optionSkuId, sectionalSkuId)}" >
												<p tabindex="0"><dsp:valueof param="customOption.auxiliaryData.catalogRef.displayName" />
													<span style="display:none">(<dsp:valueof param="customOption.auxiliaryData.catalogRef.id" />)</span>
													<dsp:getvalueof var="optionItemInfo" param="customOption.optionInfo" />
													<c:if test="${ not empty optionItemInfo}">
														<dsp:getvalueof var="optionType" value="${optionItemInfo.optionType }" />
														
														<c:if test="${ not empty optionType and optionType eq 'optionCover'}">
															<c:out value="${optionItemInfo.colorName}" />
																(<c:out value="${optionItemInfo.optionValue}" />)
														</c:if>
														<c:if test="${ not empty optionType and optionType eq 'optionValue'}">
																<c:out value="${optionItemInfo.optionValue}" />
														</c:if>
														
													</c:if>
													</p>
												</c:if>
										</dsp:oparam>
									</dsp:droplet>
									</p>
					</dsp:oparam>
				</dsp:droplet>
		</c:when>
		<c:when test="${not empty customOptions}">
				<dsp:droplet name="ForEach">
					<dsp:param name="array" value="${customOptions}" />
					<dsp:param name="elementName" value="customOption" />
					<dsp:oparam name="output">
						<p tabindex="0"><dsp:valueof param="customOption.auxiliaryData.catalogRef.displayName" />
							<span style="display:none">(<dsp:valueof param="customOption.auxiliaryData.catalogRef.id" />)</span>
							<dsp:getvalueof var="optionItemInfo" param="customOption.optionInfo" />
							<c:if test="${ not empty optionItemInfo}">
								<dsp:getvalueof var="optionType" value="${optionItemInfo.optionType }" />
								
								<c:if test="${ not empty optionType and optionType eq 'optionCover'}">
									
									<c:out value="${optionItemInfo.colorName}" />
										(<c:out value="${optionItemInfo.optionValue}" />)
								</c:if>
								<c:if test="${ not empty optionType and optionType eq 'optionValue'}">
										<c:out value="${optionItemInfo.optionValue}" />
								</c:if>
							</c:if>
						</p>
					</dsp:oparam>
				</dsp:droplet>
		</c:when>
	</c:choose>											

</dsp:page>
