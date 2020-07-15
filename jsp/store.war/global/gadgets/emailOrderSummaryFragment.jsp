<dsp:page>
<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
<dsp:importbean bean="/com/lzb/droplet/LZBOrderSummaryDroplet" />
<dsp:importbean bean="/com/lzb/droplet/LZBPromotionDisplayDroplet" />
	<dsp:getvalueof var="order" param="order" />
	<dsp:droplet name="LZBOrderSummaryDroplet">
		<dsp:param name="order" value="${order}"/>
	         <dsp:oparam name="output">
	       				<dsp:getvalueof var="commerceItemCount" param="totalNumberOfItems" />
	         			<dsp:getvalueof var="shippingCurrency" param="shippingCharge"/>
	         			<dsp:getvalueof var="taxCost" param="tax"/> 
				 		<dsp:getvalueof var="totalRecycleFee" param="totalRecycleFee"/>
	         			<dsp:getvalueof var="totalItemCosts" param="totalItemCost"/>
	         			<dsp:getvalueof var="coverPlanItems" param="planItems"/>
	         			<dsp:getvalueof var="totalPrice" param="total"/>
	         			<dsp:getvalueof var="surCharge" param="surCharge"/>	
	         			<dsp:getvalueof var="currencyCode" param="currencyCode"/>	
	         </dsp:oparam>
    </dsp:droplet>
	 <td class="contentPadding20" style="padding:0 40px 15px 0;">
                 <table class="fullWidth" align="right" width="325" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                      <td style="padding-bottom:7px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; mso-line-height-rule:exactly; line-height:12px; text-align:left; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><dsp:valueof param="order.totalCommerceItemCount"/> <fmt:message key="orderTotal.itemTotal"/></font></td>
                      <td style="padding-bottom:7px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; mso-line-height-rule:exactly; line-height:12px; text-align:right; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif">[<dsp:include page="/pricing/displayPrice.jsp">
					         				<dsp:param name="currency" value="${totalItemCosts}"/>
					     			 </dsp:include>]</font></td>
                    </tr>
                   <%--  
                     <tr>
                     <dsp:droplet name="ForEach">
										<dsp:param name="array" value="${coverPlanItems}" />
										<dsp:param name="elementName" value="planItem" />
										<dsp:oparam name="output">
                      <td style="padding-bottom:7px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; mso-line-height-rule:exactly; line-height:12px; text-align:left; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><dsp:valueof param="planItem.planItemInfo.displayName"/>(<dsp:valueof param="planItem.quantity"/> &nbsp; items)</font></td>
                      
                      <td style="padding-bottom:7px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; mso-line-height-rule:exactly; line-height:12px; text-align:right; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif">[
      
												<dsp:include page="/pricing/displayPrice.jsp">
													    <dsp:param name="currency" param="planItem.amount"/>
												</dsp:include>									
                      ]</font></td>
                      	</dsp:oparam>
					</dsp:droplet>
                    </tr>
                    --%>
                    <dsp:droplet name="LZBPromotionDisplayDroplet">
										<dsp:param name="order" value="${order}" />
										<dsp:oparam name="output">	
											<dsp:getvalueof var="promoDetailsVO" param="promoDetailsVO"/>
											<c:if test="${not empty promoDetailsVO}">
												<dsp:droplet name="ForEach">
													<dsp:param name="array" value="${promoDetailsVO}" />
													<dsp:param name="elementName" value="promoVO" />
													<dsp:oparam name="output">
														<tr>
															 <td style="padding-bottom:7px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; mso-line-height-rule:exactly; line-height:12px; text-align:left; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><dsp:valueof param="promoVO.couponName" /> ([<dsp:valueof param="promoVO.couponCode" />])</font></td>
                      <td style="padding-bottom:7px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; mso-line-height-rule:exactly; line-height:12px; text-align:right; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif">-[<dsp:valueof param="promoVO.adjustmentAmount" converter="currency" />]</font></td>										
														</tr>
													</dsp:oparam>
												</dsp:droplet>
											</c:if>			  
										</dsp:oparam>
									</dsp:droplet>			
                    <tr>
                      <td style="padding-bottom:7px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; mso-line-height-rule:exactly; line-height:12px; text-align:left; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif">Delivery Charge</font></td>
                      <td style="padding-bottom:7px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; mso-line-height-rule:exactly; line-height:12px; text-align:right; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif">[<dsp:include page="/pricing/displayPrice.jsp">
										<dsp:param name="currency" value="${shippingCurrency}"/>
									</dsp:include>]</font></td>
                    </tr>
                    <c:if test="${not empty surCharge and surCharge ne 0}">
                    <tr>
                      <td style="padding-bottom:7px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; mso-line-height-rule:exactly; line-height:12px; text-align:left; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><fmt:message key="orderTotal.surCharge"/></font></td>
                      <td style="padding-bottom:7px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; mso-line-height-rule:exactly; line-height:12px; text-align:right; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif">[<dsp:include page="/pricing/displayPrice.jsp">
											<dsp:param name="currency" value="${surCharge}"/>
										</dsp:include>]</font></td>
                    </tr>
                    </c:if>
                     <tr>
                      <td style="padding-bottom:7px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; mso-line-height-rule:exactly; line-height:12px; text-align:left; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><fmt:message key="orderTotal.saleTax"/></font></td>
                      <td style="padding-bottom:7px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; mso-line-height-rule:exactly; line-height:12px; text-align:right; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif">
						  [<dsp:include page="/pricing/displayPrice.jsp">
							<dsp:param name="currency" value="${taxCost}"/>
					  	  </dsp:include>]
					  </font></td>
                    </tr>
					<c:if test="${not empty totalRecycleFee}">
						<tr>
							 <td style="padding-bottom:7px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; mso-line-height-rule:exactly; line-height:12px; text-align:left; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><fmt:message key="orderTotal.recyclingFee"/></font></td>
							 <td style="padding-bottom:7px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; mso-line-height-rule:exactly; line-height:12px; text-align:right; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif">
								 [<dsp:include page="/pricing/displayPrice.jsp">
									 <dsp:param name="currency" value="${totalRecycleFee}"/>
								 </dsp:include>]
							 </font></td>
						</tr>
				 	</c:if>
                    <tr>
                      <td style="padding-bottom:7px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; mso-line-height-rule:exactly; line-height:12px; text-align:left; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif">Order total:</font></td>
                      <td style="padding-bottom:7px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; mso-line-height-rule:exactly; line-height:12px; text-align:right; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif">[<dsp:include page="/pricing/displayPrice.jsp">
								     	 <dsp:param name="currency" value="${totalPrice}"/>
									</dsp:include>] ${currencyCode}</font></td>
                    </tr>
                 </table>
               </td>
</dsp:page>
