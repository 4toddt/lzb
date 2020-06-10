<dsp:page>

	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:getvalueof var="image_name" param="image_name"/>	

	<dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler" />
	<dsp:droplet name="InvokeAssembler">
		<dsp:param name="contentCollection"
			value="/content/Shared/Email Template/Header" />
		<dsp:param name="includePath" value="" />
		<dsp:oparam name="output">
			<dsp:getvalueof var="element" vartype="com.endeca.infront.assembler.ContentItem" param="contentItem" />
			<dsp:renderContentItem contentItem="${element}" />
		</dsp:oparam>
		<dsp:oparam name="error">
		</dsp:oparam>
	</dsp:droplet>
	
	<table align="center" bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0" class="fullWidth" style="border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;" width="600">
    <tbody>
    <tr>
            <td style="padding:8px 0 0 0;"><img alt="Living Room Set" border="0" class="fullWidth" height="236" src="http://content.la-z-boy.com/Images/email_hero/${image_name}-hero.jpg" style="display:block;" width="600" /></td>
        </tr>
    </tbody>
	</table>
	
</dsp:page>					
						<!-- Logo And Nav -->
						<!-- <table class="fullWidth" width="600" align="center" bgcolor="#ffffff" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td align="center" style="border-bottom:6px solid #7297a8;">
									<table width="100%" align="center" bgcolor="#ffffff" cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
										<tr>
											<td class="paddingBottom0 paddingTop10" align="center" valign="top" style="padding:20px 0 25px 0;"> <a href="https://www.la-z-boy.com/" title="La-Z-Boy | Live Life Comfortable" target="_blank"><img class="mobileAlignCenter paddingBottom10" src="http://media.la-z-boy-mail.com/4942/Shared/2014/template1a/logo.gif" alt="La-Z-Boy" style="display:block;" border="0" width="181" height="44"></a> </td>
										</tr>
									</table>
									<table class="fullWidth" width="590" align="center" bgcolor="#ffffff" cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
										<tr>
											<td align="center">
											<table align="center" bgcolor="#ffffff" cellpadding="0" cellspacing="0" border="0">
											  <tr>
												  <td bgcolor="#ffffff" class="mobileAlignCenter copy14" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; line-height:12px; text-align:center; color:#4c4c4c;">
                         <a class="navPadding" href="#" title="Recliners" target="_blank" style="color:#4c4c4c; text-decoration:none; padding:8px 15px 8px 0; border:1px solid #ffffff; display:inline-block;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><strong style="font-weight: normal;">Recliners</strong></font></a>
                          </td>
											  </tr>
											</table>
											</td>
											<td class="mobileHide">
											<table align="center" bgcolor="#ffffff" cellpadding="0" cellspacing="0" border="0">
											  <tr>
												  <td bgcolor="#ffffff" class="mobileAlignCenter copy14" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; line-height:12px; text-align:center; color:#4c4c4c;">
															<a class="mobileHide" href="#" title="Chairs" target="_blank" style="color:#4c4c4c; text-decoration:none; padding:8px 15px; border:1px solid #ffffff; display:inline-block;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><strong style="font-weight: normal;">Chairs</strong></font></a>
                          </td>
											  </tr>
											</table>
											</td>
											<td align="center">
											<table align="center" bgcolor="#ffffff" cellpadding="0" cellspacing="0" border="0">
											  <tr>
												  <td bgcolor="#ffffff" class="mobileAlignCenter copy14" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; line-height:12px; text-align:center; color:#4c4c4c;">
															<a class="navPadding" href="#" title="Sofas" target="_blank" style="color:#4c4c4c; text-decoration:none; padding:8px 15px; border:1px solid #ffffff; display:inline-block;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><strong style="font-weight: normal;">Sofas</strong></font></a>
                          </td>
											  </tr>
											</table>
											</td>
											<td align="center">
											<table align="center" bgcolor="#ffffff" cellpadding="0" cellspacing="0" border="0">
											  <tr>
												  <td bgcolor="#ffffff" class="mobileAlignCenter copy14" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; line-height:12px; text-align:center; color:#4c4c4c;">
															<a class="navPadding" href="#" title="Sectionals" target="_blank" style="color:#4c4c4c; text-decoration:none; padding:8px 15px; border:1px solid #ffffff; display:inline-block;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><strong style="font-weight: normal;">Sectionals</strong></font></a>
                          </td>
											  </tr>
											</table>
											</td>
											<td class="mobileHide">
											<table align="center" cellpadding="0" cellspacing="0" border="0">
											  <tr>
												  <td bgcolor="#ffffff" class="mobileAlignCenter copy14" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; line-height:12px; text-align:center; color:#4c4c4c;">
															<a class="mobileHide" href="#" title="Ottomans" target="_blank" style="color:#4c4c4c; text-decoration:none; padding:8px 15px; border:1px solid #ffffff; display:inline-block;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><strong style="font-weight: normal;">Ottomans</strong></font></a>
                          </td>
											  </tr>
											</table>
											</td>
											<td class="mobileHide">
											<table align="center" cellpadding="0" cellspacing="0" border="0">
											  <tr>
												  <td bgcolor="#ffffff" class="mobileAlignCenter copy14" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; line-height:12px; text-align:center; color:#4c4c4c;">
															<a class="mobileHide" href="#" title="Loveseats" target="_blank" style="color:#4c4c4c; text-decoration:none; padding:8px 15px; border:1px solid #ffffff; display:inline-block;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><strong style="font-weight: normal;">Loveseats</strong></font></a>
                          </td>
											  </tr>
											</table>
											</td>
											<td class="mobileHide">
											<table width="105" align="center" bgcolor="#f7f7f4" cellpadding="0" cellspacing="0" border="0">
											  <tr>
                          <td class="navText" align="center" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; line-height:12px; color:#4c4c4c;">
															<a href="#" title="My Account" target="_blank" style="color:#7297a8; text-decoration:none; padding:8px; border:1px solid #f7f7f4; display:inline-block;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><strong>My Account</strong></font></a>
                          </td>
											  </tr>
											</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						Logo and Nav END

						Main Image
            <table class="fullWidth" width="600" align="center" bgcolor="#ffffff" cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
              <tr>
                <td style="padding:8px 0 0 0;">
                  <img class="fullWidth" src="http://media.la-z-boy-mail.com/4942/Shared/Transactional/profilechange.jpg" alt="Living Room Set" width="600" height="236" border="0" style="display:block;">
                </td>
              </tr>
            </table> -->
            <!-- Main Image END -->
