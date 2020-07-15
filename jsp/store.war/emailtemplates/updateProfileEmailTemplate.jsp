<%@ taglib prefix="dsp"	uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_1"%><%-- JSON Rendering Taglib --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
<dsp:getvalueof var="hostName"value="${storeConfig.hostName}"/>
<dsp:page>
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
  text-decoration: none !important;
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
.navPadding {${pageContext.request.contextPath}/
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
	line-height: 1.5 !important;
}
.copy21 {
	font-size: 21px !important;
	line-height: 1.5 !important;
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
			<dsp:include page="${pageContext.request.contextPath}/cartridges/LZBEmailTemplateHeader/LZBEmailTemplateHeader.jsp">
				<dsp:param name="image_name" value="profile-change"/>
			</dsp:include>
            <!-- Main Message -->
            <table class="fullWidth" width="600" cellpadding="0" cellspacing="0" border="0">
             <tr>
              <td class="fullWidthImg contentPadding20" align="center" style="padding:15px 0 0 0; font-family:Helvetica, Arial, sans-serif; font-size:29px; font-weight:bold; color:#444444;">   <fmt:message key="accountEmail.successMsg"/>
              </td>
             </tr>
            </table>
            <!-- Main Message END -->

             <table class="fullWidth" width="600" cellpadding="0" cellspacing="0" border="0">
               <tr>
                 <td style="padding:5px 15px; border-bottom:6px solid #7297a8;">
                   <table align="center" cellpadding="0" cellspacing="0" border="0">
                     <tr>
                       <td class="contentPadding20 copy13" align="center" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-weight:normal; font-size:14px; mso-line-height-rule:exactly; line-height:21px; color:#444444; padding:5px 0;"><font face="'Open Sans', Helvetica, Arial, sans-serif">
                       <fmt:message key="accountEmail.onlineRequestMsg"/></font></td>
                     </tr>
                   </table>
                 </td>
              </tr>
            </table>
            <!-- Insert Body Content -->

            <!-- Didn't Request -->
            <table class="fullWidth" width="600" cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
             <tr>
               <td class="contentPadding20 paddingBottom10" style="padding:30px 15px;">
                 <table align="left" width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr>
                    <td align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:16px; font-weight:bold; line-height:21px; color:#0070af;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><fmt:message key="accountEmail.changeRequest"/></font></td>
                  </tr>
                  <tr>
                    <td class="copy13" align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:14px; font-weight:normal; line-height:24px; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif">
                  <font><a style="color:#0070af; text-decoration:none;" target="_blank" title="Contact Us" href="${hostName}/content/CustomerCare/contactus/?WT.mc_id=Email-System-Update-Profile"><strong style="font-weight:normal;"><fmt:message key="accountEmail.contactUs"/></strong></a> <fmt:message key="accountEmail.customerService"/></font></td>
                  </tr>
                 </table>
               </td>
             </tr>
            </table>
            <!-- Didn't Request END -->

            <!-- Insert Body Content END -->
            <dsp:getvalueof var="store" param="store" />
			<dsp:getvalueof var="profile" param="profile" />

			<dsp:include page="${pageContext.request.contextPath}/global/includes/emailFooter.jsp">
				<dsp:param name="storePhoneNumber" value="${store.phoneNumber}"/>
				<dsp:param name="currentDealerId" value="${profile.currentDealerId}"/>
			</dsp:include>
            <dsp:include page="${pageContext.request.contextPath}/cartridges/LZBEmailTemplateFooter/LZBEmailTemplateFooter.jsp"/>

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