<dsp:page>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	<dsp:getvalueof var="order" param="order"/>
	<dsp:getvalueof var="showPrice" param="showPrice"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBDisplayCartItemsDroplet" />
		<!-- Description -->
            <table class="fullWidth" width="600" cellpadding="0" cellspacing="0" border="0" bgcolor="#f7f7f4">
              <tr>
                <td>
                  <table class="fullWidth" width="250" align="left" cellpadding="0" cellspacing="0" border="0" bgcolor="#f7f7f4">
                    <tr>
                      <td class="contentPadding20" style="padding:10px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:14px; font-weight:bold; line-height:12px; text-align:left; color:#4c4c4c;"><font face="'Open Sans', Helvetica, Arial, sans-serif">Description</font></td>
                    </tr>
                  </table>
                  <c:if test="${not empty showPrice && showPrice == 'true' }">
	                  <table width="260" align="right" cellpadding="0" cellspacing="0" border="0" bgcolor="#f7f7f4">
	                    <tr>
	                     <td>
	                       <table width="80" align="left" cellpadding="0" cellspacing="0" border="0">
	                         <tr>
	                      <td style="padding:10px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:14px; font-weight:bold; line-height:12px; text-align:left; color:#4c4c4c;"><font face="'Open Sans', Helvetica, Arial, sans-serif">Price</font></td>
	                         </tr>
	                       </table>
	                       <table width="55" align="left" cellpadding="0" cellspacing="0" border="0">
	                         <tr>
	                      <td style="padding:10px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:14px; font-weight:bold; line-height:12px; text-align:left; color:#4c4c4c;"><font face="'Open Sans', Helvetica, Arial, sans-serif">QTY</font></td>
	                         </tr>
	                       </table>
	                       <table align="left" cellpadding="0" cellspacing="0" border="0">
	                         <tr>
	                      <td style="padding:10px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:14px; font-weight:bold; line-height:12px; text-align:left; color:#4c4c4c;"><font face="'Open Sans', Helvetica, Arial, sans-serif">Total</font></td>
	                         </tr>
	                       </table>
	                     </td>
	                    </tr>
	                  </table>
                  </c:if>
                </td>
              </tr>
            </table>
              <!-- Description END -->             
            <!-- Cart -->
            <!-- Item 1 -->
            <table class="fullWidth" width="600" cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
	            <dsp:droplet name="LZBDisplayCartItemsDroplet">
					<dsp:param name="order" value="${order}"/>
					<dsp:param name="cart" value="false"/>
					<dsp:oparam name="output">
						<dsp:getvalueof var="cartItems" param="cartItems" />
						<dsp:droplet name="ForEach">
							<dsp:param name="array" param="cartItems" />
			 				<dsp:param name="elementName" value="cartItem" />
							<dsp:oparam name="output">
								<dsp:getvalueof var="cartItem" param="cartItem" />
								<dsp:getvalueof var="commerceItemId" param="cartItem.commerceItem.id"/>
					              <tr>
					                <td style="padding:20px 0; border-bottom:1px solid #cccccc;">
					                  <table width="80" class="fullWidth email-img" align="left" cellpadding="0" cellspacing="0" border="0">
					                    <tr>
					                      <td>
					                      	<dsp:include page="/global/gadgets/cartItemImage.jsp">
												<dsp:param name="cartItem" param="cartItem" />
												<dsp:param name="isEmail" value="true"/>
											</dsp:include>
										  </td>
					                    </tr>
					                  </table>
					                  <table class="fullWidth" width="475" align="left" cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
					                    <tr>
					                      <td class="paddingLeft10 paddingTop15" style="padding-left:15px;">
					                        <table align="left" width="230" cellpadding="0" cellspacing="0" border="0">
					                          <tr>
					                            <td class="copy13" style="padding-bottom:5px;font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:14px; font-weight:bold; mso-line-height-rule:exactly; line-height:16px; text-align:left; color:#444444;">
					                            	<font face="'Open Sans', Helvetica, Arial, sans-serif">
					                            		<dsp:valueof param="cartItem.commerceItem.auxiliaryData.catalogRef.displayName"/>
														<c:if test="${not empty showPrice && showPrice == 'false' }">
															<br>
															QTY <dsp:valueof param='cartItem.commerceItem.quantity'/>
														</c:if>
													</font>
					                            </td>
					                          </tr>
					                          <c:if test="${not cartItem.licensedProduct}">
                                                <tr>
                                                    <td class="copy13" style="padding-bottom:5px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; mso-line-height-rule:exactly; line-height:12px; text-align:left; color:#444444;">
                                                        <font face="'Open Sans', Helvetica, Arial, sans-serif">
                                                            Product Cover: [<dsp:valueof param="cartItem.coverItem.auxiliaryData.catalogRef.displayName"/> <dsp:valueof param="cartItem.coverItem.auxiliaryData.catalogRef.id"/>]
                                                        </font>
                                                    </td>
                                                </tr>
                                              </c:if>
					                          <dsp:getvalueof var="pillowItem" param="cartItem.pillowItem"/>
											  <c:if test="${ not empty pillowItem }">
						                          <tr>
						                            <td class="copy13" style="padding-bottom:5px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; mso-line-height-rule:exactly; line-height:12px; text-align:left; color:#444444;">
						                            	<font face="'Open Sans', Helvetica, Arial, sans-serif">
						                            		Pillow Cover: [<dsp:valueof param="cartItem.pillowItem.optionInfo.colorName"/> <dsp:valueof param="cartItem.pillowItem.optionInfo.optionValue"/>]
						                            	</font>
						                            </td>
						                          </tr>
					                          </c:if>
					                          <dsp:getvalueof var="finishOption" param="cartItem.finishOption"/>
											  <c:if test="${ not empty finishOption }">
						                          <tr>
						                            <td class="copy13" style="padding-bottom:5px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; mso-line-height-rule:exactly; line-height:12px; text-align:left; color:#444444;">
						                            	<font face="'Open Sans', Helvetica, Arial, sans-serif">
															Finish: [<dsp:valueof param="cartItem.finishOption.auxiliaryData.catalogRef.displayName"/>]
														</font>
						                            </td>
						                          </tr>
					                          </c:if>
					                          <dsp:getvalueof var="customOptions" param="cartItem.customOptions"/>
											  <c:if test="${ not empty customOptions }">
						                          <tr>
						                            <td class="copy13" style="padding-bottom:5px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; mso-line-height-rule:exactly; line-height:12px; text-align:left; color:#444444;">
						                            	<font face="'Open Sans', Helvetica, Arial, sans-serif">
															Options:<br>
															<dsp:droplet name="ForEach">
																<dsp:param name="array" param="cartItem.customOptions" />
																<dsp:param name="elementName" value="customOption" />
																<dsp:oparam name="output">
																	<table cellpadding="0" cellspacing="0" border="0">
																	   <tr>
																	      <td style="font-family:'Open Sans', Helvetica, Arial, sans-serif; color:#444444; font-size:12px;">
																	      	<font face="'Open Sans', Helvetica, Arial, sans-serif">
																	      		<dsp:valueof param="customOption.auxiliaryData.catalogRef.displayName"/>
																	      	</font>
																	      </td>
																	   </tr>
																	</table>
																</dsp:oparam>
															</dsp:droplet>
						                            	</font>
						                            </td>
						                          </tr>
						                      </c:if>
					                        </table>
					                         <c:set var="protectionPlanCost" value="0.0"/>
					                           	 <dsp:getvalueof var="protectionPlan" param="cartItem.protectionPlan"/>
							     				 <dsp:getvalueof var="hasTreatment" param="cartItem.hasTreatment"/>
							     				 <c:if test="${hasTreatment eq 'true' && not empty protectionPlan}">
							     						<dsp:getvalueof var="planListPrice" param='cartItem.protectionPlan.priceInfo.listPrice'/>
							     						<dsp:getvalueof var="planSalePrice" param='cartItem.protectionPlan.priceInfo.salePrice'/>
							     							<c:choose>
												   <c:when test="${empty planSalePrice || planSalePrice <= 0.0}">
												    <c:set var="protectionPlanCost" value="${planListPrice}"/>
												   </c:when>
												   <c:otherwise>
												    <c:set var="protectionPlanCost" value="${planSalePrice}"/>
												   </c:otherwise>
												  </c:choose>
					                             </c:if>
	                             			
					                        <c:if test="${not empty showPrice && showPrice == 'true' }">
						                        <table class="mobileAlignLeft" width="205" align="right" cellpadding="0" cellspacing="0" border="0">
						                          <tr>
						                           <td>
						                            <!--[if (gte mso 9)|(IE)]> 
						                            <table cellpadding="0" cellspacing="0" border="0">
						                            <tr>
						                            <td>
						                            <![endif]-->
						                             <table width="85" align="left" cellpadding="0" cellspacing="0" border="0">
						                               <tr>
						                                <td class="copy13" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:14px; font-weight:normal; mso-line-height-rule:exactly; line-height:16px; text-align:left; color:#444444;">
						                                	<font face="'Open Sans', Helvetica, Arial, sans-serif">
						                                		<!-- Price -->
												     			<dsp:getvalueof var="listPrice" param="cartItem.listPrice"/>
												     			<dsp:getvalueof var="salePrice" param="cartItem.salePrice"/>
												     			<c:choose>
																   <c:when test="${empty salePrice || salePrice <= 0.0}">
																     <span> 
																     <dsp:include page="/global/includes/formattedPrice.jsp">
																		<dsp:param name="price" value="${listPrice - protectionPlanCost}" />
																	 </dsp:include>
																	 </span>
																   </c:when>
																   <c:otherwise>
													   					<span> 
													   					 <font style="text-decoration: line-through;">
													   					  <dsp:include page="/global/includes/formattedPrice.jsp">
																				<dsp:param name="price" value="${listPrice - protectionPlanCost}" />
																		  </dsp:include>
													   					 </font> 
														   				  <dsp:include page="/global/includes/formattedPrice.jsp">
																			<dsp:param name="price" value="${salePrice - protectionPlanCost}" />
																		  </dsp:include>
													   					 </span>
																   </c:otherwise>
																  </c:choose>
						                                	</font>
						                                </td>
						                               </tr>
						                             </table>
						                              <!--[if (gte mso 9)|(IE)]> 
						                              </td>
						                              <td>
						                              <![endif]-->
						                             <table width="51" align="left" cellpadding="0" cellspacing="0" border="0">
						                               <tr>
						                                <td class="copy13" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:14px; font-weight:normal; mso-line-height-rule:exactly; line-height:16px; text-align:left; color:#444444;">
						                                	<font face="'Open Sans', Helvetica, Arial, sans-serif">
						                                		<!-- Quantity -->
												     			<dsp:valueof param='cartItem.commerceItem.quantity'/>
						                                	</font>
						                                </td>
						                               </tr>
						                             </table>
						                              <!--[if (gte mso 9)|(IE)]> 
						                              </td>
						                              <td>
						                              <![endif]-->
						                             <table align="left" width="60" cellpadding="0" cellspacing="0" border="0">
						                               <tr>
						                                <td class="copy13" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:14px; font-weight:bold; mso-line-height-rule:exactly; line-height:16px; text-align:right; color:#444444;">
						                                	<font face="'Open Sans', Helvetica, Arial, sans-serif">
																<dsp:include page="/global/includes/formattedPrice.jsp">
																	<dsp:param name="price"param="cartItem.itemTotal"/>
																</dsp:include>
						                                	</font>
						                                </td>
						                               </tr>
						                             </table>
						                            <!--[if (gte mso 9)|(IE)]> 
						                            </td>
						                            </tr>
						                            </table>
						                            <![endif]-->
						                            </td>
						                          </tr>
						                        </table>
					                        </c:if>
					                      </td>
					                    </tr>
					                    <tr>
					                      <td class="paddingLeft10 paddingTop15" style="padding-left:15px;">
					                        <table width="100%" align="right" cellpadding="0" cellspacing="0" border="0">
					                          <tr>
					                           <td>
					                           	 <dsp:getvalueof var="protectionPlan" param="cartItem.protectionPlan"/>
							     				 <dsp:getvalueof var="hasTreatment" param="cartItem.hasTreatment"/>
							     			
							     				 <c:if test="${hasTreatment eq 'true' && not empty protectionPlan}">
									     				<dsp:getvalueof var="protectionPlan" param="cartItem.protectionPlan"/>
							     						<dsp:getvalueof var="planName" param="cartItem.protectionPlan.auxiliaryData.catalogRef.displayName"/>
							     						<dsp:getvalueof var="skuId" param="cartItem.protectionPlan.id"/>
							     						<dsp:getvalueof var="totalPrice" param='cartItem.protectionPlan.priceInfo.amount'/>
							     						<dsp:getvalueof var="planListPrice" param='cartItem.protectionPlan.priceInfo.listPrice'/>
							     						<dsp:getvalueof var="planSalePrice" param='cartItem.protectionPlan.priceInfo.salePrice'/>
							     						<dsp:getvalueof var="qty" param="cartItem.protectionPlan.quantity"/>
							                             <table class="fullWidth" align="left" cellpadding="0" cellspacing="0" border="0">
							                               <tr>
							                                <td class="copy13 paddingBottom5" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; mso-line-height-rule:exactly; line-height:12px; text-align:left; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif">Add-Ons: [${planName}]</font></td>
							                               </tr>
							                             </table>
					                             </c:if>
					                             <c:if test="${not empty showPrice && showPrice == 'true' }">
						                            <table class="mobileAlignLeft" width="205" align="right" cellpadding="0" cellspacing="0" border="0">
						                              <tr>
						                               <td>
						                                <!--[if (gte mso 9)|(IE)]> 
						                                <table cellpadding="0" cellspacing="0" border="0">
						                                <tr>
						                                <td>
						                                <![endif]-->
						                                
						                                 <table width="85" align="left" cellpadding="0" cellspacing="0" border="0">
						                                   <tr>
						                                    <td class="copy13" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; mso-line-height-rule:exactly; line-height:12px; text-align:left; color:#444444;">
						                                    	<font face="'Open Sans', Helvetica, Arial, sans-serif">
																	<!-- protection plan sale price -->
																	<c:if test="${hasTreatment eq 'true' && not empty protectionPlan}">
																		<dsp:include page="/global/includes/formattedPrice.jsp">
																			<dsp:param name="price" value="${protectionPlanCost}" />
																	  	</dsp:include>
																	</c:if>
																</font>
															</td>
						                                   </tr>
						                                 </table>
						                                <!--[if (gte mso 9)|(IE)]> 
						                                </td>
						                                <td>
						                                <![endif]-->
						                                 <table width="51" align="left" cellpadding="0" cellspacing="0" border="0">
						                                   <tr>
						                                    <td class="copy13" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; mso-line-height-rule:exactly; line-height:12px; text-align:left; color:#444444;">
						                                    	<font face="'Open Sans', Helvetica, Arial, sans-serif">
						                                    		<!-- protection plan sale price -->
													     			<c:if test="${hasTreatment eq 'true' && not empty protectionPlan}">
													     				${qty}
													     			</c:if>
						                                    	</font>
						                                    </td>
						                                   </tr>
						                                 </table>
						                                <!--[if (gte mso 9)|(IE)]> 
						                                </td>
						                                <td>
						                                <![endif]-->
						                                 <table align="left" width="55" cellpadding="0" cellspacing="0" border="0">
						                                   <tr>
						                                    <td class="copy13" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:bold; mso-line-height-rule:exactly; line-height:12px; text-align:right; color:#444444;">
						                                    	<font face="'Open Sans', Helvetica, Arial, sans-serif">
																	<!-- protection plan Total -->
																	<c:if test="${hasTreatment eq 'true' && not empty protectionPlan}">
																		<dsp:include page="/global/includes/formattedPrice.jsp">
																			<dsp:param name="price" value="${totalPrice}" />
																		</dsp:include>
																	</c:if>
																</font>
															</td>
						                                   </tr>
						                                 </table>
						                                <!--[if (gte mso 9)|(IE)]> 
						                                </td>
						                                </tr>
						                                </table>
						                                <![endif]-->
						                               </td>
						                              </tr>
						                            </table>
					                            </c:if>
					                           </td>
					                          </tr>
					                        </table>
					                      </td>
					                    </tr>
					                  </table>
					                </td>
					              </tr>
						    </dsp:oparam>
						</dsp:droplet>
					</dsp:oparam>
				</dsp:droplet>
            </table>
            <!-- Item 1 END -->
</dsp:page>