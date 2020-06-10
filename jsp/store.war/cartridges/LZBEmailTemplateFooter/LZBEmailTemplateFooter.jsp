<dsp:page>
	<dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler" />
	<dsp:droplet name="InvokeAssembler">
		<dsp:param name="contentCollection"
			value="/content/Shared/Email Template/Footer" />
		<dsp:param name="includePath" value="" />
		<dsp:oparam name="output">
			<dsp:getvalueof var="element" vartype="com.endeca.infront.assembler.ContentItem" param="contentItem" />
			<dsp:renderContentItem contentItem="${element}" />
		</dsp:oparam>
		<dsp:oparam name="error">
		</dsp:oparam>
	</dsp:droplet>
</dsp:page>
			
			<!-- Have Questions -->
            <!-- <table class="fullWidth" width="600" cellpadding="0" cellspacing="0" border="0">
             <tr>
               <td style="padding:15px 0;">
                  <table class="fullWidth" width="600" cellpadding="0" cellspacing="0" border="0" bgcolor="#f7f7f4">
                   <tr>
                     <td class="paddingBottom10">
                      Arrow
                      <table class="fullWidth" align="left" width="241" cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
                        <tr>
                          <td class="fullWidth" style="background-color:#0070af"><img src="http://media.la-z-boy-mail.com/4942/Shared/Transactional/question.gif" width="217" height="60" alt="Have a question?" border="0" style="display:block;"></td>
                          <td class="mobileHide"><img src="http://media.la-z-boy-mail.com/4942/Shared/Transactional/arrow.gif" width="24" height="60" alt="Have a question?" border="0" style="display:block;"></td>
                        </tr>
                      </table>
                      Arrow END
                      <table class="fullWidth" align="right" width="335" cellpadding="0" cellspacing="0" border="0" bgcolor="#f7f7f4" style="border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
                        <tr>
                          <td class="fullWidth paddingTop10 contentPadding20">
                           Phone
                            <table class="fullWidth" align="left" cellpadding="0" cellspacing="0" border="0">
                             <tr>
                               <td class="paddingTop5 paddingBottom5 heightAuto copy16" height="60" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-weight:normal; font-size:16px; mso-line-height-rule:exactly; line-height:18px; text-align:left; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><span class="darkLinks"><fmt:message key="accountEmail.customerCareNo"/></span></font></td>
                              </tr>
                            </table>
                            Hours
                            <table class="fullWidth heightAuto" align="right" height="60" cellpadding="0" cellspacing="0" border="0">
                             <tr>
                              <td class="paddingTop5" valign="top" style="padding:12px 10px 0 0;">
                                <table>
                                  <tr>
                                    <td class="copy12" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-weight:normal; font-size:12px; mso-line-height-rule:exactly; line-height:14px; text-align:left; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><span class="darkLinks"><fmt:message key="accountEmail.monSatWorkHour"/></span></font></td>
                                  </tr>
                                  <tr>
                                    <td class="copy12" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-weight:normal; font-size:12px; mso-line-height-rule:exactly; line-height:14px; text-align:left; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><span class="darkLinks"><fmt:message key="accountEmail.sunWorkHour"/></span></font></td>
                                  </tr>
                                </table>
                              </td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                      </table>
                      Phone and Hours END
                     </td>
                   </tr>
                 </table>
               </td>
              </tr>
            </table>
            Have Questions END
            Footer Nav
            <table class="footerNav fullWidth" width="600" cellpadding="0" cellspacing="0" border="0">
              <tr>
                <td class="paddingNone" align="center" style="padding:5px 0 5px; border-top:6px solid #7297a8;">
                  <table class="fullWidth" width="600" align="center" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                      <td class="copy14" align="center" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:13px"><a href="#" title="Connect With Us" target="_blank" style="color:#0070af; text-decoration:none; display:inline-block; white-space:nowrap; padding:15px; border:1px solid #ffffff; box-sizing: border-box; -moz-box-sizing: border-box; -webkit-box-sizing: border-box;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><strong style="font-weight:normal;">Connect With Us &raquo;</strong></font></a><a href="#" title="Product Registration" target="_blank" style="color:#0070af; text-decoration:none; display:inline-block; white-space:nowrap; padding:12px; border:1px solid #ffffff; box-sizing: border-box; -moz-box-sizing: border-box; -webkit-box-sizing: border-box;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><strong style="font-weight:normal;">Product Registration &raquo;</strong></font></a> <a href="#" title="Warranty" target="_blank" style="color:#0070af; text-decoration:none; display:inline-block; white-space:nowrap; padding:15px; border:1px solid #ffffff; box-sizing: border-box; -moz-box-sizing: border-box; -webkit-box-sizing: border-box;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><strong style="font-weight:normal;">Warranty &raquo;</strong></font></a> <a href="#" title="Meet Our Makers" target="_blank" style="color:#0070af; text-decoration:none; display:inline-block; white-space:nowrap; padding:15px; border:1px solid #ffffff; box-sizing: border-box; -moz-box-sizing: border-box; -webkit-box-sizing: border-box;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><strong style="font-weight:normal;">Meet Our Makers &raquo;</strong></font></a></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
            Footer Nav END
            
            Footer
            <table class="fullWidth" width="600" cellpadding="0" cellspacing="0" border="0">
             <tr>
               <td style="padding:10px 0 25px 0; border-top:1px solid #b7b7b7;">
                <table class="fullWidth" width="600" align="center" bgcolor="#ffffff" cellpadding="0" cellspacing="0" border="0">
                  <tr>
                    <td class="paddingTop30 paddingBottom30" style="padding:15px 0;" align="center">
                      <table class="mobileAlignCenter" align="center" bgcolor="#ffffff" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                          <td class="paddingRight15" style="padding-right:4px;"><a href="https://www.facebook.com/lazboy" title="Facebook" target="_blank"><img class="socialIcon" src="http://media.la-z-boy-mail.com/4942/Shared/2014/BrowseAbandon/Facebook.gif" width="23" height="23" border="0" style="display:block;"></a> </td>
                          <td class="paddingRight15" style="padding-right:4px;"><a href="https://twitter.com/lazboy" title="Twitter" target="_blank"><img class="socialIcon" src="http://media.la-z-boy-mail.com/4942/Shared/2014/BrowseAbandon/twitter.gif" width="23" height="23" border="0" style="display:block;"></a> </td>
                          <td class="paddingRight15" style="padding-right:4px;"><a href="https://www.youtube.com/lazboy" title="YouTube" target="_blank"><img class="socialIcon" src="http://media.la-z-boy-mail.com/4942/Shared/2014/BrowseAbandon/YouTube.gif" width="21" height="21" border="0" style="display:block;"></a> </td>
                          <td><a href="http://www.pinterest.com/lazboy/" title="Pinterest" target="_blank"><img class="socialIcon" src="http://media.la-z-boy-mail.com/4942/Shared/2014/BrowseAbandon/pinterest.gif" width="23" height="23" border="0" style="display:block;"></a> </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
                <table class="fullWidth" width="600" align="center" bgcolor="#ffffff" cellpadding="0" cellspacing="0" border="0">
                  <tr>
                    <td align="center">
                      <table class="fullWidth" width="600" align="center" bgcolor="#ffffff" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                          <td class="preheaderFooter footer paddingBottom0" style="font-family: Arial, Helvetica, sans-serif; font-size:10px; line-height:10px; text-align:center; color:#4c4c4c;">You are receiving this message due to a recent <span style="white-space:nowrap;">La-Z-boy</span> transaction. We respect your right to privacy. <span style="white-space:nowrap;">View our <a class="footerCapitalize" href="#" title="Privacy Policy" target="_blank" style="color:#4c4c4c;"><strong style="font-weight: normal;">privacy policy</strong></a></span><span class="mobileHide">.</span><br>
                            <br>
                            La-Z-Boy Incorporated<span class="mobileHide"> &nbsp;|&nbsp;</span> <span style="white-space:nowrap;">One La-Z-Boy Drive, Monroe, MI 48162</span><br>
                            <br>
                          </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
               </td>
              </tr>
            </table> -->
            <!-- Footer END -->