<dsp:page>

	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:getvalueof param="sectionalPieces" var="sectionalPieces" />
	<dsp:getvalueof param="customOptions" var="customOptions" />
	<dsp:getvalueof param="page" var="pageName" />
	
<li>
	<fmt:message key="cart.options" />
</li>											
<c:choose>
<c:when test="${ not empty sectionalPieces}">
	<c:if test="${empty pageName}" >
		<li>
	</c:if>

		<ul>
			<dsp:droplet name="ForEach">
				<dsp:param name="array" value="${sectionalPieces}" />
				<dsp:param name="elementName" value="sectionalPiece" />
				<dsp:oparam name="output">
					<li><dsp:valueof param="sectionalPiece.auxiliaryData.catalogRef.displayName" />
					<dsp:getvalueof var="optionItemInfo" param="customOption.optionInfo" />
	
							 <dsp:getvalueof param="sectionalPiece.auxiliaryData.catalogRef.id" var="sectionalSkuId" />
							
	<c:if test="${empty pageName}" >
		<li>
	</c:if>
											<ul>
												<dsp:droplet name="ForEach">
													<dsp:param name="array" value="${customOptions}" />
													<dsp:param name="elementName" value="customOption" />
													<dsp:oparam name="output">
										<dsp:getvalueof param="customOption.auxiliaryData.catalogRef.id" var="optionSkuId" /> 
											<c:if test="${ (not empty optionSkuId and not empty sectionalSkuId) and fn:startsWith(optionSkuId, sectionalSkuId)}" >
															<li><dsp:valueof param="customOption.auxiliaryData.catalogRef.displayName" />
															<span style="display:none">(<dsp:valueof param="customOption.auxiliaryData.catalogRef.id" />)</span>
															
															<dsp:getvalueof var="optionItemInfo" param="customOption.optionInfo" />
																<c:if test="${ not empty optionItemInfo}">
																	<dsp:getvalueof var="optionType" value="${optionItemInfo.optionType }" />
																	<ul>
																	<c:if test="${ not empty optionType and optionType eq 'optionCover'}">
																		<li>
																		<c:out value="${optionItemInfo.colorName}" />
																			(<c:out value="${optionItemInfo.optionValue}" />)
																		</li>
																	</c:if>
																	<c:if test="${ not empty optionType and optionType eq 'optionValue'}">
																		<li>
										
																			<c:out value="${optionItemInfo.optionValue}" />
																		</li>
																	</c:if>
																	</ul>
																</c:if>
															</li>
															</c:if>
													</dsp:oparam>
												</dsp:droplet>
											</ul>
	<c:if test="${empty pageName}" >
		</li>
	</c:if>
							
					</li>
				</dsp:oparam>
				
				
			</dsp:droplet>
		</ul>
	<c:if test="${empty pageName}" >
		</li>
	</c:if>
</c:when>
<c:when test="${not empty customOptions}">
<li>
	<ul>
		<dsp:droplet name="ForEach">
			<dsp:param name="array" value="${customOptions}" />
			<dsp:param name="elementName" value="customOption" />
			<dsp:oparam name="output">
					<li><dsp:valueof param="customOption.auxiliaryData.catalogRef.displayName" />
					<span style="display:none">(<dsp:valueof param="customOption.auxiliaryData.catalogRef.id" />)</span>
					
					<dsp:getvalueof var="optionItemInfo" param="customOption.optionInfo" />

						<c:if test="${ not empty optionItemInfo}">
							<dsp:getvalueof var="optionType" value="${optionItemInfo.optionType }" />
							<ul>
							<c:if test="${ not empty optionType and optionType eq 'optionCover'}">
								<li>
								<c:out value="${optionItemInfo.colorName}" />
									(<c:out value="${optionItemInfo.optionValue}" />)
								</li>
							</c:if>
							<c:if test="${ not empty optionType and optionType eq 'optionValue'}">
								<li>

									<c:out value="${optionItemInfo.optionValue}" />
								</li>
							</c:if>
							</ul>
						</c:if>
					</li>
			</dsp:oparam>
		</dsp:droplet>
	</ul>
</li>
</c:when>
</c:choose>											

</dsp:page>
