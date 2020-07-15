<!-- we are not using this jsp same content moved to emailTemplates/  -->

<%@ taglib prefix="dsp"	uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_1"%><%-- JSON Rendering Taglib --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<dsp:page>
<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
<dsp:getvalueof var="hostName"value="${storeConfig.hostName}"/>
<dsp:importbean bean="/atg/userprofiling/Profile" />
<dsp:getvalueof var="resetPasswordUrl" param="resetPasswordUrl" />
<dsp:getvalueof var="encryptedProfileId" param="encryptedProfileId" />
<dsp:getvalueof var="store" param="store" />
<dsp:getvalueof var="profile" param="profile" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,700' rel='stylesheet' type='text/css'>
<style type="text/css">
@import url(http://fonts.googleapis.com/css?family=Open+Sans:400,300,700);  
body {
	width: 100% !important;
	-webkit-text-size-adjust: none;
	-ms-text-size-adjust: none;
	margin: 0;
	padding: 0;
}
.ReadMsgBody {
	width: 100%;
}
.ExternalClass {
	width: 100%;
}
.backgroundTable {
	margin: 0 auto;
	padding: 0;
	width: 100% !important;
}
table td {
	border-collapse: collapse;
}
.ExternalClass * {
	line-height: 115%;
}
/* Footer Links */
.footer a {
	color: #4c4c4c !important;
}
/* Mobile Styles */
@media only screen and (max-width : 480px) {
/********** CUSTOM STYLES ***********/
/****** Add Custom Styles Here ******/
.twoLines {
  display: block !important;
}
.darkLinks a {
  color:#444444 !important;
  text-decoration: none;
}
.navText {
	font-size: 12px !important;
	line-height: 12px !important;
}
.displayBlock {
	display: block;
}
.shopAllSofas {
	height: 186px !important;
	border: 1px solid #cccccc;
}
.shopAllSofas a {
	display: block !important;
	width: 100% !important;
	padding-top: 93px !important;
	padding-bottom: 93px !important;
}
.mobileShop {
	color: #4c4c4c !important;
	text-decoration: underline !important;
}
.mobileNewStyle {
	color: #028aa0 !important;
	text-decoration: underline !important;
}
.nameText {
	font-size: 22px !important;
	line-height: 22px !important;
}
.ctaText {
	font-size: 16px !important;
	line-height: 16px !important;
	color: #028aa0 !important;
}
.findAStoreText {
	font-size: 18px !important;
	line-height: 18px !important;
}
.navPadding {
	padding-right: 15px !important;
	padding-left: 15px !important;
	padding-bottom: 10px !important;
}
.navPadding2 {
	padding-right: 70px !important;
	padding-left: 70px !important;
}
.contentPadding25 {
	padding-right: 25px !important;
	padding-left: 25px !important;
}
.footerCapitalize {
	text-transform: capitalize !important;
	text-decoration: none !important;
}
.socialIcon {
	width: 41px;
	height: auto;
}
/* General Styles */
.wrapper {
	width: 100%;
	overflow: hidden;
}
.mobileHide {
	display: none !important;
}
.fullWidth {
	width: 100%;
	height: auto;
}
.percentWidth70 {
  width: 72% !important;
  height: auto;
}
.floatLeft {
	float: left;
}
.heightAuto {
	height: auto;
}
/* Images */
.width122 {
	width: 122px;
	height: auto;
}
.width200 {
	width: 200px;
	height: auto;
}
.width400 {
	width: 300px;
	height: auto;
}
.fullWidthImg img {
	width: 100%;
	height: auto;
}
.fullImg {
	width: 100%;
}
/* Text */
.mobileAlignCenter {
	text-align: center !important;
	margin: auto;
	float: none;
}
.mobileAlignLeft {
	text-align: left !important;
	float: left;
}
.tableAlignCenter {
	margin: auto;
	float: none;
}
.preheaderFooter {
	font-size: 13px !important;
	line-height: 18px !important;
	color: #4c4c4c !important;
}
.bodyCopy {
	font-size: 14px !important;
	line-height: 18px !important;
}
.productCopy {
	font-size: 16px !important;
	line-height: 22px !important;
}
.headlineCopy {
	font-size: 18px !important;
	line-height: 24px !important;
}
.copy12 {
	font-size: 12px !important;
	line-height: 1.5 !important;
}
.copy13 {
	font-size: 13px !important;
	line-height: 1.5 !important;
}
.copy14 {
	font-size: 14px !important;
	line-height: 1.5 !important;
}
.copy16 {
	font-size: 16px !important;
	line-height: 1.5 !important;
}
.copy20 {
	font-size: 20px !important;
	line-height: 1.25 !important;
}
/* Borders */
.borderTop {
	border-top: 1px solid #cccccc;
}
.borderTopBold {
	border-top: 2px solid #cccccc;
}
.borderBottom {
	border-bottom: 1px solid #bbbbbb;
}
.borderBottomBold {
	border-bottom: 2px solid #cccccc;
}
.borderNone {
	border: 0 none !important;
}
/* Padding */
.contentPadding {
	padding-left: 10px !important;
	padding-right: 10px !important;
}
.contentPadding20 {
	padding-left: 20px !important;
	padding-right: 20px !important;
}
.paddingLeft10 {
  padding-left: 10% !important;
}
.paddingRight10 {
  padding-right: 10px !important;
}
.paddingNone {
	padding: 0 !important;
}
.paddingLeft0 {
	padding-left: 0 !important;
}
.paddingRight0 {
	padding-right: 0 !important;
}
.paddingRight15 {
	padding-right: 15px !important;
}
.paddingTop0 {
	padding-top: 0 !important;
}
.paddingTop3 {
	padding-top: 3px !important;
}
.paddingTop5 {
	padding-top: 5px !important;
}
.paddingTop10 {
	padding-top: 10px !important;
}
.paddingTop15 {
	padding-top: 15px !important;
}
.paddingTop20 {
	padding-top: 20px !important;
}
.paddingTop25 {
	padding-top: 25px !important;
}
.paddingTop30 {
	padding-top: 30px !important;
}
.paddingTop50 {
	padding-top: 50px !important;
}
.paddingBottom0 {
	padding-bottom: 0 !important;
}
.paddingBottom2 {
	padding-bottom: 2px !important;
}
.paddingBottom5 {
	padding-bottom: 5px !important;
}
.paddingBottom10 {
	padding-bottom: 10px !important;
}
.paddingBottom15 {
	padding-bottom: 15px !important;
}
.paddingBottom20 {
	padding-bottom: 20px !important;
}
.paddingBottom25 {
	padding-bottom: 25px !important;
}
.paddingBottom30 {
	padding-bottom: 30px !important;
}
.paddingBottom50 {
	padding-bottom: 50px !important;
}
/*** Footer Nav ***/
.footerNav a {
	display: block !important;
	width: 100%;
	padding: 15px 0 !important;
	border-top: 1px solid #CCCCCC !important;
	border-right: 0 !important;
	border-left: 0 !important;
  text-align: left !important;
}/* Mobile Show */
.mobileShow, .mobileShow tbody, .mobileShow tr, .mobileShow td {
	width: auto !important;
	max-height: inherit !important;
	overflow: visible !important;
	display: block !important;
	float: none !important;
}
.mobileShow img {
	width: 100% !important;
	height: auto !important;
	max-height: inherit !important;
	overflow: visible !important;
	display: block !important;
	float: none !important;
}
.footerNav a strong {
	padding: 15px 20px !important;
}
}
</style>
</head>
<body>
<table width="100%" bgcolor="#f5f5f5" cellpadding="0" cellspacing="0" border="0" style="table-layout:fixed;">
  <tr>
    <td class="paddingLeft0 paddingRight0" align="center" style="padding:0 10px;">
      <table class="wrapper" bgcolor="#ffffff" width="650" align="center" cellpadding="0" cellspacing="0" border="0">
        <tr>
          <td align="center"> 

					<!-- Preheader -->
						<table class="mobileHide" width="600" align="center" bgcolor="#ffffff" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td class="mobileAlignCenter preheaderFooter borderBottom paddingBottom10" style="font-family: Arial, Helvetica, sans-serif; font-size:10px; line-height:10px; mso-line-height-rule:exactly; text-align:left; color:#4c4c4c; padding:10px 0 20px;">Complete your password reset</td>
							</tr>
						</table>
						<!-- Preheader END -->
						
						<dsp:include page="/cartridges/LZBEmailTemplateHeader/LZBEmailTemplateHeader.jsp">
							<dsp:param name="image_name" value="password-reset"/>
						</dsp:include>

						

            <!-- Main Message -->
            <table class="fullWidth" width="600" cellpadding="0" cellspacing="0" border="0">
             <tr>
               <td class="paddingTop5" align="center" style="padding:15px 0 0 0;">
                 <table align="center" cellpadding="0" cellspacing="0" border="0">
                  <tr>
                    <td class="mobileAlignCenter contentPadding20">
                      <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
                        <tr>
                           <td class="fullWidthImg contentPadding20" align="center" style="padding:15px 0 0 0; font-family:Helvetica, Arial, sans-serif; font-size:20px; font-weight:bold; color:#444444;">
                             WE RECEIVED YOUR PASSWORD RESET REQUEST  
                          </td>
                        </tr>
                      </table>
                    </td>
                   </tr>
                 </table>
               </td>
             </tr>
            </table>
            <!-- Main Message END -->

             <table class="fullWidth" width="600" cellpadding="0" cellspacing="0" border="0">
               <tr>
                 <td class="contentPadding20 paddingBottom0" style="padding:10px 15px; border-bottom:6px solid #7297a8;">
                   <table cellpadding="0" cellspacing="0" border="0">
                     <tr>
                       <td class="paddingTop0" align="left" style="padding-top:20px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-weight:normal; font-size:14px; mso-line-height-rule:exactly; line-height:21px; color:#444444; padding:5px 0;"><font face="'Open Sans', Helvetica, Arial, sans-serif">To complete your password update, some additional information is needed for you to log back into your La-Z-Boy account. Please follow these steps to create your <span style="white-space:nowrap;">new password:</span></font></td>
                     </tr>
                     <tr>
                      <td style="padding-top:10px;">
                        <table align="left" cellpadding="0" cellspacing="0" border="0">
                         <tr>
                           <td class="copy13" align="left" style="padding-top:20px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-weight:normal; font-size:14px; mso-line-height-rule:exactly; line-height:21px; color:#444444; padding:5px 0;"><font face="'Open Sans', Helvetica, Arial, sans-serif">1.&emsp;Click on the link below.</font></td>
                          </tr>
                         <tr>
                           <td class="copy13" align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-weight:normal; font-size:14px; mso-line-height-rule:exactly; line-height:21px; color:#444444; padding:5px 0;"><font face="'Open Sans', Helvetica, Arial, sans-serif">2.&emsp;You will be directed to a secure page.</font></td>
                         </tr>
                         <tr>
                           <td class="copy13" align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-weight:normal; font-size:14px; mso-line-height-rule:exactly; line-height:21px; color:#444444; padding:5px 0;"><font face="'Open Sans', Helvetica, Arial, sans-serif">3.&emsp;Enter your new password.</font></td>
                         </tr>
                         <tr>
                           <td class="copy13" align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-weight:normal; font-size:14px; mso-line-height-rule:exactly; line-height:21px; color:#444444; padding:5px 0;"><font face="'Open Sans', Helvetica, Arial, sans-serif">4.&emsp;Confirm your new password.</font></td>
                         </tr>
                        </table>
                      </td>
                     </tr>
                     <tr>
                      <td class="paddingTop15" style="padding:20px 0;">
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                           <td class="copy13" align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-weight:bold; font-size:14px; mso-line-height-rule:exactly; line-height:14px; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif">Reset your password now:</font></td>
                          </tr>
                          <tr>
                           		<td class="copy13 paddingTop5" align="left" style="padding-top:12px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-weight:normal; font-size:14px; mso-line-height-rule:exactly; line-height:14px; color:#444444;">
                           			<font face="'Open Sans', Helvetica, Arial, sans-serif">
                           				<a href="${resetPasswordUrl}" title="Reset Password" target="_blank" style="color:#0070af; text-decoration:none;">CLICK HERE &raquo;</a>
                           			</font>
                           		</td>
                          </tr>
                        </table>
                      </td>
                     </tr>
                   </table>
                 </td>
              </tr>
            </table>
            <!-- Insert Body Content -->

            <!-- Didn't Request -->
         
            <!-- Didn't Request END -->
                        
            <!-- Insert Body Content END -->
            
            <!-- Have Questions -->
         
            <!-- Have Questions END -->
            
            <!-- Footer Nav -->
          
            <!-- Footer Nav END -->
            
            <!-- Footer -->
            <dsp:include page="${pageContext.request.contextPath}/global/includes/emailFooter.jsp">
		    	<dsp:param name="storePhoneNumber" value="${store.phoneNumber}"/>
		    	<dsp:param name="currentDealerId" value="${profile.currentDealerId}"/>
		    </dsp:include>
            <dsp:include page="/cartridges/LZBEmailTemplateFooter/LZBEmailTemplateFooter.jsp"/>
            <!-- Footer END -->
            
				  </td>
        </tr>
      </table>
						
      <!-- Spacer Img for Gmail Android Fix -->
      

      
      <!-- Spacer Img for Gmail Android Fix END -->
      
		</td>
	</tr>
</table>
</body>
</html>
</dsp:page>