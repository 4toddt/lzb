<dsp:page>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty" />
	<dsp:getvalueof var="adjustments" vartype="java.lang.Object" param="adjustments" />

	<c:if test="${not empty adjustments}">
		<table id="lzb_store_itemTable" >

				<tbody>
					<dsp:droplet name="ForEach">
						<dsp:param name="array" value="${adjustments}" />
						<dsp:param name="elementName" value="adjustment" />
						<dsp:oparam name="output">
							<dsp:droplet name="IsEmpty">
								<dsp:param name="value" param="adjustment.pricingModel" />
								<dsp:oparam name="false" >
									<tr>
										<td>
											<dsp:valueof param="adjustment.pricingModel.displayName" />
										</td>
										<td>
											<dsp:include page="../../global/includes/formattedPrice.jsp">
												<dsp:param name="price" param="adjustment.totalAdjustment" />
											</dsp:include>
										</td>
									</tr>
								</dsp:oparam>
							</dsp:droplet>
						</dsp:oparam>
					</dsp:droplet>
				</tbody>
		</table>
	</c:if>
</dsp:page>