<%@ taglib prefix="dsp"	uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_1"%><%-- JSON Rendering Taglib --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<dsp:page>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBGetRelatedOrdersDroplet" />
	<dsp:getvalueof var="hostName"value="${storeConfig.hostName}"/>
	
	<dsp:getvalueof var="lastOrder" param="lastOrder"/>
	<dsp:getvalueof var="profile" param="profile"/>
	<dsp:getvalueof var="store" param="store"/>
	<dsp:getvalueof var="shippingGroup" param="lastOrder.shippingGroups[0]"/>
	<dsp:getvalueof var="paymentGroup" param="lastOrder.paymentGroups[0]"/>
	<dsp:getvalueof var="commerceItems" param="lastOrder.commerceItems"/>
	
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
.email-img img{
	width:80px;
}
.ExternalClass * {
	line-height: 115%;
}
/* Footer Links */
.footer a {
	color: #4c4c4c !important;
}
.darklinks {
  color: #444444;
  text-decoration: none;
}  
.darklinks a {
  color: #444444;
  text-decoration: none;
}
/* Mobile Styles */
@media only screen and (max-width : 480px) {
/********** CUSTOM STYLES ***********/
/****** Add Custom Styles Here ******/
.blackLinks a {
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
.copy11 {
	font-size: 11px !important;
	line-height: 1.5 !important;
  letter-spacing: normal !important;
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
.copy17 {
	font-size: 17px !important;
	line-height: 1.5 !important;
  letter-spacing: normal !important;
}
.copy18 {
	font-size: 18px !important;
	line-height: 1.5 !important;
  letter-spacing: normal !important;
}
.copy20 {
	font-size: 20px !important;
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
	border-bottom: 1px solid #7297a8;
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

<dsp:droplet name="LZBGetRelatedOrdersDroplet" >
	<dsp:param name="order" value="${lastOrder}" />
	<dsp:oparam name="output">
		<dsp:getvalueof var="relatedOrders" param="relatedOrders" />
	</dsp:oparam>
</dsp:droplet>

<table width="100%" bgcolor="#f5f5f5" cellpadding="0" cellspacing="0" border="0" style="table-layout:fixed;">
  <tr>
    <td class="paddingLeft0 paddingRight0" align="center" style="padding:0 10px;">
      <table class="wrapper" bgcolor="#ffffff" width="650" align="center" cellpadding="0" cellspacing="0" border="0">
        <tr>
          <td align="center"> 

					<!-- Preheader -->
						<table class="mobileHide" width="600" align="center" bgcolor="#ffffff" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td class="mobileAlignCenter preheaderFooter borderBottom paddingBottom10" style="font-size:10px; line-height:10px; mso-line-height-rule:exactly; text-align:left; color:#4c4c4c; padding:10px 0 20px;">
									<font face="'Arial', Open Sans, Helvetica,sans-serif">Comfort is just around the corner.</font>
								</td>
							</tr>
						</table>
						<!-- Preheader END -->
						
						

            <!-- Main Message -->
           	<dsp:include page="${pageContext.request.contextPath}/cartridges/LZBEmailTemplateHeader/LZBEmailTemplateHeader.jsp">
           		    <dsp:param name="image_name" value="order-confirmation"/>
           	</dsp:include>
           	
            <!-- Main Message END -->
            
             <!-- Main Message -->
            <table class="fullWidth" width="600" cellpadding="0" cellspacing="0" border="0">
             <tr>
              <td class="fullWidthImg contentPadding20" align="center" style="padding:15px 0 0 0; font-family:Helvetica, Arial, sans-serif; font-size:29px; font-weight:bold; color:#444444;"> THANKS FOR YOUR ORDER!
              </td>
             </tr>
            </table>
            <!-- Main Message END -->

             <table class="fullWidth" width="600" cellpadding="0" cellspacing="0" border="0">
               <tr>
                 <td style="padding:5px 15px; border-bottom:6px solid #7297a8;">
                   <table align="center" cellpadding="0" cellspacing="0" border="0">
                     <tr>
                       <td class="contentPadding20 copy13" align="center" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-weight:normal; font-size:14px; mso-line-height-rule:exactly; line-height:21px; color:#888888; padding:5px 0;"><font face="'Open Sans', Helvetica, Arial, sans-serif">
                       Our team is working to ensure your order arrives as soon as possible, and to your complete satisfaction. Because we are doing all we can to keep you and our employees safe and well, some orders may take longer than usual to arrive.</font></td>
                     </tr>
                   </table>
                 </td>
              </tr>
            </table>

            <!-- Item Details -->
            <table class="fullWidth" width="600" cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
             <tr>
               <td class="contentPadding20 paddingBottom10 paddingTop20" style="padding:20px 0 0 0;">
                 <table align="left" width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr>
                    <td align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:16px; font-weight:bold; line-height:12px; color:#0070af;"><font face="'Open Sans', Helvetica, Arial, sans-serif">Ordered Item Details</font></td>
                  </tr>
                  <tr>
                    <td align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; line-height:12px; color:#444444; padding:15px 0;"><font face="'Open Sans', Helvetica, Arial, sans-serif">Order Date: <span class="darklinks paddingBottom10 paddingTop5">
                          <dsp:getvalueof var="submittedDate" vartype="java.util.Date" value="${lastOrder.submittedDate}" />
							<fmt:formatDate pattern="MM/dd/yyyy" value="${submittedDate}" />
                          </span></font>
                    </td>
                    <td class="mobileAlignLeft paddingBottom10 paddingTop5" align="right" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; line-height:12px; color:#444444; padding:15px 0 15px 10px;"><font face="'Open Sans', Helvetica, Arial, sans-serif">Order Number: #${lastOrder.id}</font></td>
                  </tr>
                 </table>
               </td>
             </tr>
            </table>
            <!-- Item Details END -->
            
            <!-- Description -->
            <!-- items details -->
			<dsp:include page="${pageContext.request.contextPath}/global/gadgets/emailItemsFragment.jsp">
				<dsp:param name="order" value="${lastOrder}"/>
				<dsp:param name="showPrice" value="true"/>
			</dsp:include>
           
              <!-- Description END -->
      
            <!-- Order Summary -->

            <table width="100%" cellpadding="0" cellspacing="0" border="0">
             <tr>
               <td class="contentPadding20" style="padding:15px 40px 0 0;">
                <table class="fullWidth" align="right" width="325" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                     <td class="fullWidth">
                       <table class="mobileAlignCenter" width="100%" cellpadding="0" cellspacing="0" border="0">
                         <tr>
                          <td class="mobileAlignCenter" style="padding-bottom:5px;font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:14px; font-weight:bold; mso-line-height-rule:exactly; line-height:16px; text-align:left; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif">Order Summary</font></td>
                         </tr>
                       </table>
                     </td>
                    </tr>
                </table>
              </td>
              </tr>
              <tr>
              	<dsp:include page="${pageContext.request.contextPath}/global/gadgets/emailOrderSummaryFragment.jsp">
					<dsp:param name="order" value="${lastOrder}"/>
				</dsp:include>
             </tr>
            </table>
            
                        <!-- Billing Shipping -->
            <table class="fullWidth" width="600" cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
             <tr>
               <td class="contentPadding20 paddingBottom10 paddingTop10" style="padding:0px 15px 15px;">
                 <table align="left" width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr>
                    <td align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:16px; font-weight:bold; line-height:21px; color:#0070af;"><font face="'Open Sans', Helvetica, Arial, sans-serif">Your Billing and Shipping Information</font></td>
                  </tr>
                  <tr>
                    <td class="paddingBottom10 paddingTop5" style="padding:15px 0;">
                      
                      <!-- Column 2 -->
                      <table class="fullWidth paddingTop5" width="180" align="left" cellpadding="0" cellspacing="0" border="0">
			                        <tr>
			                          <td class="paddingTop10" align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:14px; font-weight:bold; line-height:20px; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif">Shipping Information</font></td>
			                        </tr>
			                        <tr>
			                          <td align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; line-height:20px; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><span class="darklinks">${shippingGroup.shippingAddress.firstName}&nbsp;
																${shippingGroup.shippingAddress.lastName}</span></font></td>
			                        </tr>
			                        <tr>
			                          <td align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; line-height:20px; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><span class="darklinks">${shippingGroup.shippingAddress.address1}&nbsp;
																${shippingGroup.shippingAddress.address2}</span></font></td>
			                        </tr>
			                        <tr>
			                          <td align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; line-height:20px; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><span class="darklinks">${shippingGroup.shippingAddress.city}&nbsp;
																${shippingGroup.shippingAddress.state}&nbsp;
																${shippingGroup.shippingAddress.postalCode}&nbsp;
																${shippingGroup.shippingAddress.country}<br/>
																<dsp:getvalueof var="shipMethod" value="${shippingGroup.shippingMethod}"/></span></font></td>
			                        </tr>
                      </table>
                      
                      <!-- Column 3 -->
                      <table class="fullWidth paddingTop5" width="180" align="left" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                          <td class="paddingTop10" align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:14px; font-weight:bold; line-height:20px; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif">Billing Information</font></td>
                        </tr>
<%-- 
                        <dsp:droplet name="ForEach">
							<dsp:param name="array" value="${paymentGroups}"/>
							<dsp:param name="elementName" value="paymentGroup"/>
								<dsp:oparam name="output">
--%>
			                        <tr>
			                          <td align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; line-height:20px; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><span class="darklinks">${paymentGroup.billingAddress.firstName}&nbsp;
																${paymentGroup.billingAddress.lastName}</span></font></td>
			                        </tr>
			                        <tr>
			                          <td align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; line-height:20px; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><span class="darklinks">${paymentGroup.billingAddress.address1}&nbsp;
																${paymentGroup.billingAddress.address2}</span></font></td>
			                        </tr>
			                        <tr>
			                          <td align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; line-height:20px; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><span class="darklinks">${paymentGroup.billingAddress.city}&nbsp;
																${paymentGroup.billingAddress.state}&nbsp;
																${paymentGroup.billingAddress.postalCode}<br/>
																${paymentGroup.billingAddress.country}</span></font></td>
			                        </tr>
<%-- 			                        
                        		</dsp:oparam>
							</dsp:droplet>
--%>
                      </table>
                    </td>
                  </tr>
                 </table>
               </td>
             </tr>
            </table>

            <!-- Billing Shipping END -->
            
            
                        <dsp:droplet name="ForEach">
				<dsp:param name="array" value="${relatedOrders}"/>
				<dsp:param name="elementName" value="relOrder"/>
				<dsp:oparam name="output">
					<dsp:getvalueof var="relOrder" param="relOrder"/>
				
            
                        <!-- Item Details -->
            <table class="fullWidth" width="600" cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
             <tr>
               <td class="contentPadding20 paddingBottom10 paddingTop20" style="padding:20px 0 0 0;">
                 <table align="left" width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr>
                    <td align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:16px; font-weight:bold; line-height:12px; color:#0070af;"><font face="'Open Sans', Helvetica, Arial, sans-serif">Ordered Item Details</font></td>
                  </tr>
                  <tr>
                    <td align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; line-height:12px; color:#444444; padding:15px 0;"><font face="'Open Sans', Helvetica, Arial, sans-serif">Order Date: <span class="darklinks paddingBottom10 paddingTop5">
                          <dsp:getvalueof var="submittedDate" vartype="java.util.Date" value="${relOrder.submittedDate}" />
							<fmt:formatDate pattern="MM/dd/yyyy" value="${submittedDate}" />
                          </span></font>
                    </td>
                    <td class="mobileAlignLeft paddingBottom10 paddingTop5" align="right" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; line-height:12px; color:#444444; padding:15px 0 15px 10px;"><font face="'Open Sans', Helvetica, Arial, sans-serif">Order Number: #${relOrder.id}</font></td>
                  </tr>
                 </table>
               </td>
             </tr>
            </table>
            <!-- Item Details END -->
            
            <!-- Description -->
            <!-- items details -->
			<dsp:include page="${pageContext.request.contextPath}/global/gadgets/emailItemsFragment.jsp">
				<dsp:param name="order" value="${relOrder}"/>
				<dsp:param name="showPrice" value="true"/>
			</dsp:include>
           
              <!-- Description END -->
      
            <!-- Order Summary -->

            <table width="100%" cellpadding="0" cellspacing="0" border="0">
             <tr>
               <td class="contentPadding20" style="padding:15px 40px 0 0;">
                <table class="fullWidth" align="right" width="325" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                     <td class="fullWidth">
                       <table class="mobileAlignCenter" width="100%" cellpadding="0" cellspacing="0" border="0">
                         <tr>
                          <td class="mobileAlignCenter" style="padding-bottom:5px;font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:14px; font-weight:bold; mso-line-height-rule:exactly; line-height:16px; text-align:left; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif">Order Summary</font></td>
                         </tr>
                       </table>
                     </td>
                    </tr>
                </table>
              </td>
              </tr>
              <tr>
              	<dsp:include page="${pageContext.request.contextPath}/global/gadgets/emailOrderSummaryFragment.jsp">
					<dsp:param name="order" value="${relOrder}"/>
				</dsp:include>
             </tr>
            </table>
            
            <!-- Order Summary END -->

            <!-- Cart END -->
            
            
            <!-- Order Summary END -->

            <!-- Cart END -->

            <!-- Billing Shipping -->
            <table class="fullWidth" width="600" cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
             <tr>
               <td class="contentPadding20 paddingBottom10 paddingTop10" style="padding:0px 15px 15px;">
                 <table align="left" width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr>
                    <td align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:16px; font-weight:bold; line-height:21px; color:#0070af;"><font face="'Open Sans', Helvetica, Arial, sans-serif">Your Billing and Shipping Information</font></td>
                  </tr>
                  <tr>
                    <td class="paddingBottom10 paddingTop5" style="padding:15px 0;">
                     <!-- Column 1-->
                      <table class="fullWidth paddingTop5" width="180" align="left" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                          <td class="paddingTop10" align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:14px; font-weight:bold; line-height:20px; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif">Local Store</font></td>
                        </tr>
                        <tr>
                          <td align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; line-height:20px; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif">${store.name}</font></td>
                        </tr>
                        <tr>
                          <td align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; line-height:20px; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><span class="darklinks">${store.address1} ${store.address2} ${store.address3}</span></font></td>
                        </tr>
                        <tr>
                          <td align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; line-height:20px; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><span class="darklinks">${store.city}, ${store.stateAddress} ${store.postalCode}</span></font></td>
                        </tr>
                      </table>
                      
                      <!-- Column 2 -->
                      <table class="fullWidth paddingTop5" width="180" align="left" cellpadding="0" cellspacing="0" border="0">
			                        <tr>
			                          <td class="paddingTop10" align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:14px; font-weight:bold; line-height:20px; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif">Shipping Information</font></td>
			                        </tr>
			                        <tr>
			                          <td align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; line-height:20px; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><span class="darklinks">${shippingGroup.shippingAddress.firstName}&nbsp;
																${shippingGroup.shippingAddress.lastName}</span></font></td>
			                        </tr>
			                        <tr>
			                          <td align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; line-height:20px; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><span class="darklinks">${shippingGroup.shippingAddress.address1}&nbsp;
																${shippingGroup.shippingAddress.address2}</span></font></td>
			                        </tr>
			                        <tr>
			                          <td align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; line-height:20px; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><span class="darklinks">${shippingGroup.shippingAddress.city}&nbsp;
																${shippingGroup.shippingAddress.state}&nbsp;
																${shippingGroup.shippingAddress.postalCode}&nbsp;
																${shippingGroup.shippingAddress.country}<br/>
																<dsp:getvalueof var="shipMethod" value="${shippingGroup.shippingMethod}"/></span></font></td>
			                        </tr>
                      </table>
                      
                      <!-- Column 3 -->
                      <table class="fullWidth paddingTop5" width="180" align="left" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                          <td class="paddingTop10" align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:14px; font-weight:bold; line-height:20px; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif">Billing Information</font></td>
                        </tr>
<%-- 
                        <dsp:droplet name="ForEach">
							<dsp:param name="array" value="${paymentGroups}"/>
							<dsp:param name="elementName" value="paymentGroup"/>
								<dsp:oparam name="output">
--%>
			                        <tr>
			                          <td align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; line-height:20px; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><span class="darklinks">${paymentGroup.billingAddress.firstName}&nbsp;
																${paymentGroup.billingAddress.lastName}</span></font></td>
			                        </tr>
			                        <tr>
			                          <td align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; line-height:20px; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><span class="darklinks">${paymentGroup.billingAddress.address1}&nbsp;
																${paymentGroup.billingAddress.address2}</span></font></td>
			                        </tr>
			                        <tr>
			                          <td align="left" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; line-height:20px; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><span class="darklinks">${paymentGroup.billingAddress.city}&nbsp;
																${paymentGroup.billingAddress.state}&nbsp;
																${paymentGroup.billingAddress.postalCode}<br/>
																${paymentGroup.billingAddress.country}</span></font></td>
			                        </tr>
<%-- 			                        
                        		</dsp:oparam>
							</dsp:droplet>
--%>
                      </table>
                    </td>
                  </tr>
                 </table>
               </td>
             </tr>
            </table>

            <!-- Billing Shipping END -->
            
            
            
            
            </dsp:oparam>
            </dsp:droplet>
            
            
            
            
            
            <!-- Change Mind -->
            <table class="fullWidth" width="600" cellpadding="0" cellspacing="0" border="0" bgcolor="#f7f7f4">
              <tr>
                <td class="contentPadding20" style="padding:15px;">
                  <table width="100%" align="left" cellpadding="0" cellspacing="0" border="0" bgcolor="#f7f7f4">
                    <tr>
                      <td style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:16px; font-weight:bold; line-height:16px; text-align:left; color:#ef8e2f;"><font face="'Open Sans', Helvetica, Arial, sans-serif">Change Your Mind?</font></td>
                    </tr>
                    <tr>
                      <td style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-weight:normal; font-size:12px; mso-line-height-rule:exactly; line-height:16px; color:#444444; padding:5px 0;"><font face="'Open Sans', Helvetica, Arial, sans-serif">Need to return or cancel an order, read through our return policy.</font> <a href="${hostName}/content/CustomerCare/ReturnPolicy" title="Learn More" target="_blank" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; mso-line-height-rule:exactly; line-height:16px; text-decoration:none; color:#0070af;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><strong style="font-weight:normal;">Learn More &raquo;</strong></font></a>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
            <!-- Change Mind END -->

             <%-- Spacing Divider --%>
             <table class="fullWidth" width="600" cellpadding="0" cellspacing="0" border="0">
              <tr>
                <td class="contentPadding20" style="padding-top:15px;">&nbsp;</td>
              </tr>
            </table>
            <%-- Spacing Divider END--%>

            <!-- Insert Body Content END -->
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
