<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<dsp:importbean bean="/com/lzb/droplet/UmbracoContentDroplet" />
<dsp:importbean bean="/com/lzb/droplet/LZBParseStoreHoursDroplet" />

<dsp:getvalueof param="storePhoneNumber" var="storePhoneNumber"/>
<dsp:getvalueof param="currentDealerId" var="currentDealerId"/>

<table border="0" cellpadding="0" cellspacing="0" class="fullWidth" width="600">
	<tbody>
		<tr>
			<td style="padding: 15px 0;">
				<table bgcolor="#f7f7f4" border="0" cellpadding="0" cellspacing="0" class="fullWidth" width="600">
					<tbody>
						<tr>
							<td class="paddingBottom10">
								<!-- Arrow -->
								<table align="left" border="0" cellpadding="0" cellspacing="0" class="fullWidth" style="border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt;" width="241">
									<tbody>
										<tr>
											<td class="fullWidth" style="background-color: #0070af">
												<img alt="Have a question?" border="0" height="60" src="https://content.la-z-boy.com/Images/email_hero/question.gif" style="display: block;" width="217" />
											</td>
											<td class="mobileHide">
												<img alt="Have a question?" border="0" height="60" src="https://content.la-z-boy.com/Images/email_hero/arrow.gif" style="display: block;" width="24" />
											</td>
										</tr>
									</tbody>
								</table> <!-- Arrow END -->

								<table align="right" bgcolor="#f7f7f4" border="0"
									cellpadding="0" cellspacing="0" class="fullWidth"
									style="border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt;"
									width="335">
									<tbody>
										<tr>
											<td class="fullWidth paddingTop10 contentPadding20">
												<!-- Phone -->
												<table align="left" border="0" cellpadding="0"
													cellspacing="0" class="fullWidth">
													<tbody>
														<tr>
															<td class="paddingTop5 paddingBottom5 heightAuto copy16" height="60" style="font-family: 'Open Sans', Helvetica, Arial, sans-serif; font-weight: normal; font-size: 16px; mso-line-height-rule: exactly; line-height: 18px; text-align: left; color: #444444;">
																<font face="'Open Sans', Helvetica, Arial, sans-serif">
																	<span class="darkLinks" style="font-family: 'Open Sans', Helvetica, Arial, sans-serif; font-weight: normal; font-size: 16px; mso-line-height-rule: exactly; line-height: 18px; text-align: left; color: #444444;">
																		<a href="tel:+${storePhoneNumber}">${storePhoneNumber}</a>
																	</span>
																</font>
															</td>
														</tr>
													</tbody>
												</table> <!-- Hours -->

												<table align="right" border="0" cellpadding="0"
													cellspacing="0" class="fullWidth heightAuto" height="60">
													<tbody>
														<tr>
															<td class="paddingTop5" style="padding: 12px 10px 0 0;"
																valign="top">
																<table>
																	<tbody>
																		<dsp:droplet name="UmbracoContentDroplet">
																			<dsp:param name="dealerId" value="${currentDealerId}" />
																			<dsp:param name="contentType" value="banner" />
																			<dsp:param name="bannerName" value="Nav" />
																			<dsp:oparam name="output">
																				<dsp:getvalueof var="storeHours" vartype="String" param="response" />
																			</dsp:oparam>
																		</dsp:droplet>
																		
																		<c:if test="${not empty storeHours }">
																			<dsp:droplet name="LZBParseStoreHoursDroplet">
																				<dsp:param name="hours" value="${storeHours}"/>
																				<dsp:oparam name="output">
																					<dsp:getvalueof var="hoursMap" param="hoursMap" />
																					<c:forEach items="${hoursMap}" var="dayHours">
																						<tr>
																							<td class="copy12" style="font-family: 'Open Sans', Helvetica, Arial, sans-serif; font-weight: normal; font-size: 12px; mso-line-height-rule: exactly; line-height: 14px; text-align: left; color: #444444;">
																								<font face="'Open Sans', Helvetica, Arial, sans-serif">
																									<span class="darkLinks" style="font-family: 'Open Sans', Helvetica, Arial, sans-serif; font-weight: normal; font-size: 12px; mso-line-height-rule: exactly; line-height: 14px; text-align: left; color: #444444;">
																										${fn:split(dayHours,'@')[0]} ${fn:split(dayHours,'@')[1]}
																									</span>
																								</font>
																							</td>
																						</tr>
																					</c:forEach>
																				</dsp:oparam>
																			</dsp:droplet>
																		</c:if>
																	</tbody>
																</table>
															</td>
														</tr>
													</tbody>
												</table>
											</td>
										</tr>
									</tbody>
								</table> <!-- Phone and Hours END -->
							</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
	</tbody>
</table>