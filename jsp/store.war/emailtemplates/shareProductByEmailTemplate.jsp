<dsp:page>
<dsp:importbean bean="/com/lzb/droplet/LZBShareProductDetailDroplet"/>
<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet"/>
<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>

<dsp:importbean bean="/atg/commerce/catalog/ProductLookup"/>
<dsp:importbean bean="/atg/commerce/catalog/SKULookup"/>

<dsp:getvalueof var="hostName" value="${storeConfig.hostName}"/>
<dsp:getvalueof var="catalogImage" value="${storeConfig.npcCatalogHeroBannerPath}"/>
<dsp:getvalueof  var="PDPURL" param="URL"/>
<dsp:getvalueof var="name" param="firstName"/>
<dsp:getvalueof var="itemDetail" param="wishListItems"/>
<dsp:getvalueof param="coverSkuId" var="coverId"/>
<dsp:getvalueof param="productId" var="productId"/>
<dsp:getvalueof param="productName" var="productName"/>
<dsp:getvalueof param="skuNo" var="skuNo"/>
<!-- include here header from endeca  -->
 <dsp:include page="${pageContext.request.contextPath}/cartridges/LZBEmailTemplateHeader/LZBEmailTemplateHeader.jsp">
 	<dsp:param name="image_name" value="product-register"/>
 </dsp:include>

	<dsp:droplet name="ProductLookup">
		<dsp:param name="id" value="${productId}" />
		<dsp:param name="elementName" value="product" />
		<dsp:oparam name="output">
			<dsp:getvalueof var="product" param="product"/>
		</dsp:oparam>
	</dsp:droplet>
	<dsp:droplet name="SKULookup">
		<dsp:param name="id" value="${skuNo}" />
		<dsp:setvalue param="sku" paramvalue="element" />
		<dsp:oparam name="output">
			<dsp:getvalueof var="sku" param="sku"/>
		</dsp:oparam>
		<dsp:oparam name="wrongCatalog">
			<dsp:getvalueof var="sku" param="sku"/>
    	</dsp:oparam>
	</dsp:droplet>
	<%-- Marxent fallback image --%>
	<c:set var="contentHostName" value="${pageContext.request.scheme}://${storeConfig.contentHostName}"/>
	<c:set var="storeConfigHostName" value="${contentHostName}"/>
	<c:set var="imagePath" value="${storeConfig.imagePath}"/>
	<c:choose>
		<c:when test="${not empty product.type && product.type eq 'sectional'}">
			<c:set var="cdpImage" value="${product.cdpImage}"/>
		</c:when>
		<c:otherwise>
			<c:set var="cdpImage" value="${sku.cdpDefaultImage}"/>
		</c:otherwise>
	</c:choose>
	<c:set var="marxentImageURL" value="${storeConfigHostName}${imagePath}${cdpImage}"/>

	<!-- display product details  -->
	<dsp:droplet name="LZBShareProductDetailDroplet">
	<dsp:param name="productId" value="${productId}"/>
	<dsp:param name="productName" value="${productName}"/>
	<dsp:param name="skuNo" value="${skuNo}"/>
	<dsp:oparam name="output">
		<dsp:getvalueof var="productInfo" param="productItem"/><br/>
		<c:if test="${pageContext.request.contextPath eq '/mobile'}">
			<c:set var="mobileSite" value="true"/>
		</c:if>

		<!--   get pdpURl-->
			 <dsp:droplet name="LZBPDPURLDroplet">
	     				<dsp:param name="productId" value="${productId}" />
	     				<dsp:param name="prodName" value="${productName}" />
	     				<dsp:param name="fromCDP" value="true" />
	     				<dsp:param name="isMobile" value="${mobileSite}"/>
						<dsp:param name="elementName" value="url" />
						<dsp:oparam name="output">
							<dsp:getvalueof var="pdpurl" param="url"/>




	<!-- Main Image -->
            <table class="fullWidth" width="600" align="center" bgcolor="#ffffff" cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;border-bottom:1px solid #cccccc;">
              <tr>
    <td style="padding:30px 0;">
   			 <table>
		               <tr>
		                    <td style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-weight:bold; font-size:25px; color:#444444;">
		                  	  <dsp:valueof value="${name}"/>
		                  	  <fmt:message key="shareProduct.pdpShareProduct"/><br/>
		                    </td>
		     		  </tr>
		       		 <tr>
		                    <td class="contentPadding20 mobileAlignLeft" align="center" style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-weight:normal; text-align:left;font-size:16px; mso-line-height-rule:exactly; line-height:22px; color:#444444; padding:5px 0;">
		                    	<font face="'Open Sans', Helvetica, Arial, sans-serif">
		                    		<fmt:message key="sharedProduct.comfortMsg"/>
		                    		<fmt:message key="shareProduct.contemproryMsg"/>
		                    		<fmt:message key="sharedProduct.shareTraditionalMsg"/>
		                    		you'll find it all at the
		                    		<a href="www.la-z-boy.com?WT.mc_id=Email-System-Share-Product">La-Z-Boy.com</a>.
		                    	</font>
		                    </td>
		      		 </tr>
              </table>
                </td>
                <td>
                  <img class="fullWidth" src="${hostName}/img/hero.jpg" alt="Living Room Set" width="350px" border="0" style="display:block;">
                </td>
              </tr>
            </table>
            <!-- Main Image END -->

            <!-- Insert Body Content -->
       <table class="fullWidth" width="600" align="center" bgcolor="#ffffff" cellspacing="20">
             <tr>
                <td style="padding:0px 20px 0px 0px; vertical-align:middle;">
                   <img class="fullWidth" src="${marxentImageURL}" alt="Product image" width="150" height="150" border="0" style="display:block;"/>
                 </td>

    	 <td>
     	 	<table cellspacing="20">
                   <tr>
                       <td style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-weight:bold; font-size:18px; color:#444444; text-transform:uppercase;" width="200"><font face="'Open Sans', Helvetica, Arial, sans-serif">${productName}</font></td>
                       <td style="font-family:'Open Sans', Helvetica, Arial, sans-serif;color:#444444;" align="right"><font face="'Open Sans', Helvetica, Arial, sans-serif"><a href="${hostName}${pdpurl}?WT.mc_id=Email-System-Share-Product" style="text-decoration:none"><img src="${hostName}/img/view-all.png" alt="View All Details"/></a></font></td>
        		 </tr>
          		<tr>
                       <td style="font-family:'Open Sans', Helvetica, Arial, sans-serif;color:#444444;" width="200">
                      	  <p style="margin:0px; font-size:16px; font-weight:bold;">Product Dimensions:</p>
                       	 <p style="margin:0px;font-size:14px;line-height:20px;"><dsp:valueof param="dimensions"/></p>
                       </td>
                       <td style="font-family:'Open Sans', Helvetica, Arial, sans-serif;color:#444444; margin-top:10px;" align="right"><font face="'Open Sans', Helvetica, Arial, sans-serif"><a href="${hostName}/storeLocator/storeLocator.jsp?WT.mc_id=Email-System-Share-Product" style="text-decoration:none"><img src="${hostName}/img/find-store.png" alt="Find in Store"/></a></font></td>
        		 </tr>
          		<tr>
                       <td style="font-family:'Open Sans', Helvetica, Arial, sans-serif;color:#444444;" colspan="2">
                       	 <p style="margin:0px; font-weight:bold;font-size:16px;">Description:</p>
                        	<p style="margin:0px;font-size:14px;line-height:20px;"><dsp:valueof param="skuDescription"/></p>
                       </td>
        		 </tr>
      	 </table>
                 </td>

              </tr>
			<c:if test="${not empty coverId}">
		              <tr>
		                    <td style="font-family:'Open Sans', Helvetica, Arial, sans-serif;color:#444444;" colspan="2">
		                    	 <p style="margin:0px; font-weight:bold; font-size:16px;">Fabric Number:</p>
		                    	 <p style="margin:0px; font-size:14px; line-height:20px;">${coverId}</p>
		                    </td>
		    		 </tr>
		      		<tr>
		                    <td style="font-family:'Open Sans', Helvetica, Arial, sans-serif;color:#444444;" colspan="2">
		                    	 <p style="margin:0px; font-weight:bold; font-size:16px;">Pillow Fabric Number:</p>
		                    	 <p style="margin:0px;font-size:14px; line-height:20px;">${coverId}</p>
		                    </td>
		     		</tr>
     		</c:if>

   	</table>

		<table class="fullWidth" cellspacing="20" width="600" align="center" bgcolor="#ffffff" border="0" style="background:url('${hostName}/img/promo-bg-strip.png');border-top:1px solid #cccccc;">
             <tr>
             	 <td width="215"><img class="fullWidth" src="${hostName}${catalogImage}" alt="promo image" width="200" height="150" border="0" style="display:block;"/></td>
             	 <td style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:18px; font-weight:bold;">Get the Latest Catalogs and Brochures</br><a href="${hostName}/content/CustomerCare/catalogs/?WT.mc_id=Email-System-Share-Product" style="display:block; font-weight:normal; color:#2685bb; text-decoration:underline; font-size:16px;">View online or order a printed copy.</a></td>
             </tr>
        </table>
				</dsp:oparam>
	   		</dsp:droplet>
		</dsp:oparam>
	</dsp:droplet>
	<!--  include footer here from  endeca  -->
	<dsp:getvalueof var="store" param="store" />
	<dsp:getvalueof var="profile" param="profile" />
	 <table class="fullWidth" width="600" align="center">
			<dsp:include page="${pageContext.request.contextPath}/global/includes/emailFooter.jsp">
				<dsp:param name="storePhoneNumber" value="${store.phoneNumber}"/>
				<dsp:param name="currentDealerId" value="${profile.currentDealerId}"/>
			</dsp:include>
			<dsp:include page="${pageContext.request.contextPath}/cartridges/LZBEmailTemplateFooter/LZBEmailTemplateFooter.jsp"/>
	</table>
</dsp:page>