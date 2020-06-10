<dsp:page>
	<dsp:importbean bean="/com/lzb/commerce/storeLocator/handler/LZBStoreLocatorFormHandler" />
	<dsp:getvalueof var="preferredStore" param="preferredStore"/>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:getvalueof var="securityStatus" bean="Profile.securityStatus" />
	<dsp:importbean bean="/com/lzb/droplet/LZBDealerStoreDroplet" />
	<dsp:getvalueof var="currentStore" bean="Profile.currentStore"/>
	<dsp:importbean bean="/com/lzb/service/SessionBean" var="SessionBeanvar" />
	<dsp:importbean bean="/com/lzb/droplet/LZBGoogleMapURLSigner" />

	<dsp:getvalueof var="storeList" bean="LZBStoreLocatorFormHandler.storeList"/>

 	<dsp:include page="/includes/SEOTagData.jsp">
		<dsp:param name="paramKeyForSEOTagData" value="storeLocator"/>
	</dsp:include>

	<lzb:pageContainer>
		<jsp:attribute name="title">
			<c:choose>
				<c:when test="${not empty sEOTagTitle}">
					${sEOTagTitle}
				</c:when>
			</c:choose>
		</jsp:attribute>


		<jsp:attribute name="pageSpecificJS">
		</jsp:attribute>

		<jsp:attribute name="bodyClass">
			two-column-equal npc
		</jsp:attribute>
		<jsp:attribute name="seoAlternateURL">${originatingRequest.getRequestURI()}</jsp:attribute>
		<jsp:attribute name="seoCanonicalURL">${originatingRequest.getRequestURI()}</jsp:attribute>

		<dsp:getvalueof bean="LZBStoreLocatorFormHandler.formError" var="formError" />
		<c:if test="${formError eq 'true'}">
			<dsp:include page="/global/errors.jsp">
				<dsp:param name="formHandler" bean="LZBStoreLocatorFormHandler" />
			</dsp:include>
		</c:if>
		<dsp:layeredBundle basename="com.lzb.common.WebAppResources">
		<lzb:breadCrumb pageKey="breadcrumb.storeLocator" divClass="breadcrumb" />

		<c:choose>
		    <c:when test="${not empty storeList}">
				<main role="main" data-module="store-locator">
			</c:when>
		    <c:otherwise>
				<main role="main">
		    </c:otherwise>
		</c:choose>

			<h1>
				<c:choose>
					<c:when test="${not empty sEODisplayName}">
						${sEODisplayName}
					</c:when>
					<c:otherwise>
						Store Locator
					</c:otherwise>
				</c:choose>
			</h1>

            <section role="region">

				<!-- current store details -->
				<dsp:include page="/storeLocator/currentStore.jsp"/>

				<dsp:form id="storeLocator" iclass="store-locator" name="storeLocator" action="#" method="post" >

					<h4>Search for more stores:</h4>

					<fieldset>

						<legend>Store Locator Form</legend>
						<dsp:getvalueof var="storeList" bean="LZBStoreLocatorFormHandler.storeList"/>
						<c:choose>
							<c:when test="${preferredStore == 'true'}" >
								<dsp:input type="hidden" name="La-Z-Boy Home Furnishings & D�cor" bean="LZBStoreLocatorFormHandler.valueMap.homeFurnishings" value="false" />
								<dsp:input type="hidden" name="La-Z-Boy Furniture Galleries" bean="LZBStoreLocatorFormHandler.valueMap.furnitureGalleries" value="false" />
								<dsp:input type="hidden" name="La-Z-Boy Comfort Studio"  bean="LZBStoreLocatorFormHandler.valueMap.comfortStudio" value="false" />
								<dsp:input type="hidden" name="Other La-Z-Boy Retailers" id="locator" bean="LZBStoreLocatorFormHandler.valueMap.retailers" value="false" />
							</c:when>
							<c:when test="${empty storeList}">
								<fieldset class="store-locator">
									<fieldset>
										<dsp:input id="decor" type="checkbox" name="La-Z-Boy Home Furnishings & D�cor" bean="LZBStoreLocatorFormHandler.valueMap.homeFurnishings"  />
										<label for="decor"><fmt:message key="storeLocator.decor"/></label>

											<div class="galleries hf">

												<a class="tooltip" href="#" title="Find a complete selection of La-Z-Boy products, plus services like our Visual Technology and In-Home Design.">
													<div class="triangle-with-shadow"></div>
													<div class="tooltip-text" title="">What is this?</div>
												</a>

											</div>

									</fieldset>
									<fieldset>
										<dsp:input id="galleries" type="checkbox" name="La-Z-Boy Furniture Galleries" bean="LZBStoreLocatorFormHandler.valueMap.furnitureGalleries" />
										<label for="galleries"><fmt:message key="storeLocator.galler"/></label>

											<div class="galleries fg">

												<a class="tooltip" href="#" title="Check out our products and Design Center.">
													<div class="triangle-with-shadow"></div>
													<div class="tooltip-text" title="">What is this?</div>
												</a>

											</div>

									</fieldset>
									<fieldset>
										<dsp:input id="studio" type="checkbox" name="La-Z-Boy Comfort Studio"  bean="LZBStoreLocatorFormHandler.valueMap.comfortStudio" />
										<label for="studio"><fmt:message key="storeLocator.studio"/> </label>

											<div class="galleries cs">

												<a class="tooltip" href="#" title="Dealers nationwide offer La-Z-Boy products to fit your needs.">
													<div class="triangle-with-shadow"></div>
													<div class="tooltip-text" title="">What is this?</div>
												</a>

											</div>

									</fieldset>
									<fieldset>
										<dsp:input id="retailers" type="checkbox" name="Other La-Z-Boy Retailers" bean="LZBStoreLocatorFormHandler.valueMap.retailers"  />
										<label for="retailers"><fmt:message key="storeLocator.other"/></label>

											<div class="galleries other">

												<a class="tooltip" href="#" title="Find a complete selection of La-Z-Boy products, plus services like our Visual Technology and In-Home Design.">
													<div class="triangle-with-shadow"></div>
													<div class="tooltip-text" title="">What is this?</div>
												</a>

											</div>

									</fieldset>
									<span class="field_error"></span>
									<a href="countryStoreLocator.jsp" class="see-all-stores"><fmt:message key="storeLocator.seeAll"/></a>
								</fieldset>
							</c:when>
						</c:choose>

						<c:if test="${securityStatus > 2 }">
							<fieldset>
								<%-- used to change store-locator.js handler --%>
								<input type="hidden" name="statusHandler"  value="" />
							</fieldset>
						</c:if>

						<fieldset class="search-locations">
							<label for="locator">Enter City, State, or Zip:</label>
							<dsp:input type="text" name="locator" id="locator" iclass="locator" bean="LZBStoreLocatorFormHandler.valueMap.state" beanvalue="LZBStoreLocatorFormHandler.valueMap.state">
							</dsp:input>
							<dsp:input type="submit" value="FIND" name="findStore"	id="findStore" bean="LZBStoreLocatorFormHandler.locate" iclass="btn-primary" required="true"/>
						</fieldset>
					</fieldset>
					<dsp:input type="hidden" name="locatorSucccess"  bean="LZBStoreLocatorFormHandler.locateSuccessURL" value="${siteBaseUrl}/storeLocator/storeLocator.jsp" />
					<dsp:input type="hidden" name="locatorError"  bean="LZBStoreLocatorFormHandler.locateErrorURL" value="${siteBaseUrl}/storeLocator/storeLocator.jsp"/>

					<dsp:getvalueof var="storeList" bean="LZBStoreLocatorFormHandler.storeList"/>
					<c:if test="${not empty storeList}">
						<div class="store-reset">
							<a href="${siteBaseUrl}/storeLocator/storeLocator.jsp">Start Over</a> | <span class="reset" tabindex="0">Clear</span>
						</div>
				</c:if>

				</dsp:form>

 				<dsp:getvalueof var="storeList" bean="LZBStoreLocatorFormHandler.storeList"/>
				<form id="storeLocator2" class="store-locator <c:if test="${not empty storeList}">sort</c:if>" name="storeLocator2" action="#" method="post" >

<%--					<dsp:form id="storeLocator2" iclass="store-locator" name="storeLocator2" action="#" method="post" > --%>

						<h3>Store Results</h3>

						<fieldset>

					 		<legend>Sort results</legend>

							<dsp:getvalueof var="sortBy" bean="LZBStoreLocatorFormHandler.sortOption" />

							<label for="sortList">Sort by:</label>
 							<select name="sortOption" id="sortList">
 								<option value="1">Distance</option>
								<option value="2">Most Services</option>
							</select>

<%--  							<dsp:select bean="LZBStoreLocatorFormHandler.sortOption" name="sortOption" id="sortList">
								<dsp:option value="2" selected="${sortBy==2}" selected="selected">Most Services</dsp:option>
								<dsp:option value="1" selected="${sortBy==1}">Distance</dsp:option>
							</dsp:select>

							<dsp:input type="submit" value="FIND" name="findStore"	id="findStore2" bean="LZBStoreLocatorFormHandler.locate" iclass="btn-primary" required="true"/>

							<dsp:input type="hidden" name="locator" id="locator" iclass="locator" bean="LZBStoreLocatorFormHandler.valueMap.state" beanvalue="LZBStoreLocatorFormHandler.valueMap.state" />
							<dsp:input type="hidden" name="locatorSucccess"  bean="LZBStoreLocatorFormHandler.locateSuccessURL" value="${siteBaseUrl}/storeLocator/storeLocator.jsp" />
							<dsp:input type="hidden" name="locatorError"  bean="LZBStoreLocatorFormHandler.locateErrorURL" value="${siteBaseUrl}/storeLocator/storeLocator.jsp"/> --%>

						</fieldset>

					</form>
<%--					</dsp:form>

 				</c:if> --%>


				<dsp:include src="${originatingRequest.siteBaseUrl}/storeLocator/storeResults.jsp">
				<dsp:param value="true" name="preferredStore" />
				</dsp:include>

			</section>

			<section role="region">

				<dsp:getvalueof var="store" value="${currentStore}"/>
				<dsp:getvalueof bean="Profile.preferredStore" var="preferredStore" />

				<div class="preferred-store-map locator">

					<dsp:getvalueof var="storeList" bean="LZBStoreLocatorFormHandler.storeList"/>
					<c:choose>
						<c:when test="${not empty storeList}">
						<ul class="map-legend">
							<li class="hf">
								<a class="tooltip" href="#" title="Find a complete selection of La-Z-Boy products, plus services like our Visual Technology and In-Home Design.">
									<div class="triangle-with-shadow"></div>
									<div class="tooltip-text" title="">La-Z-Boy Home Furnishings &amp; D&eacute;cor</div>
								</a>
							</li>
							<li class="fg">
								<a class="tooltip" href="#" title="Check out our products and Design Center.">
									<div class="triangle-with-shadow"></div>
									<div class="tooltip-text" title="">La-Z-Boy Furniture Galleries</div>
								</a>
							</li>
							<li class="cs">
								<a class="tooltip" href="#" title="Dealers nationwide offer La-Z-Boy products to fit your needs.">
									<div class="triangle-with-shadow"></div>
									<div class="tooltip-text" title="">La-Z-Boy Comfort Studios</div>
								</a>
							</li>
							<li class="other">
								<a class="tooltip" href="#" title="Find a complete selection of La-Z-Boy products, plus services like our Visual Technology and In-Home Design.">
									<div class="triangle-with-shadow"></div>
									<div class="tooltip-text" title="">Other La-Z-Boy Retailers</div>
								</a>
							</li>
						</ul>
						<div id="map-canvas" class="results-map"></div>
						</c:when>
						<c:otherwise>
							<div class="map">
								<dsp:droplet name="LZBGoogleMapURLSigner">
									<dsp:param name="inputURL" value="https://maps.googleapis.com/maps/api/staticmap?center=${store.latitude},${store.longitude}&zoom=14&size=480x480&markers=icon:https://content.la-z-boy.com/Images/storelocator/galleries_fg.png%7C${store.latitude},${store.longitude}&style=feature:poi%7Cvisibility:off&client=gme-lazboy"/>
									<dsp:oparam name="output">
										<dsp:getvalueof var="signedURL" param="signedURL" />
									</dsp:oparam>
									<dsp:oparam name="empty">
									</dsp:oparam>
								</dsp:droplet>

								<img src="${signedURL}" />
							</div>
						</c:otherwise>
					</c:choose>
				</div>

			</section>

					<dsp:getvalueof var="storeList" bean="LZBStoreLocatorFormHandler.storeList"/>
					<dsp:getvalueof var="store" value="${currentStore}"/>

    				<c:choose>
						<c:when test="${(empty storeList) && (empty currentStore)}">

<script>

var __latLong = {
		"lat" : "${SessionBeanvar.lattitude}",
		"long" : "${SessionBeanvar.longitude}"
}

var __locatorResults = [

        				{
        					"map" : [
        						{
        							"storename" : "NA"
        						}
        					],
        					"stores" : [
        						{
        							"storename" : "NA"
        						}
        					]
        				}

        			]

</script>

				</c:when>
				<c:when test="${(empty storeList) && (not empty currentStore)}">

<script>

var __latLong = {
		"lat" : "${SessionBeanvar.lattitude}",
		"long" : "${SessionBeanvar.longitude}"
}

var __locatorResults = [

				{
					"map" : [
					 {
						"storename":"${fn:trim(currentStore.name)}",
						"address1": "${fn:trim(currentStore.address1)}",
						"address2": "${fn:trim(currentStore.address2)}",
						"address3": "${fn:trim(currentStore.address3)}",
						"city":"${currentStore.city}",
						"state":"${currentStore.stateAddress}",
						"zip":"${currentStore.postalCode}",
						"country":"${currentStore.country}",
						"storeID":"${store.locationId}",
						"storetype":"${store.businessType}",
						"longi":"${currentStore.longitude}",
						"lat":"${currentStore.latitude}",
						"phone": "${currentStore.phoneNumber}",
						"website": "${currentStore.storeWebsiteUrl}",
						"index": "0"
					}
 					],
					"stores" : [
						{
							"storename" : "NA"
						}
					]
				}

			]


</script>
</c:when>
</c:choose>
<link rel="preload" href="https://assets.calendly.com/assets/external/widget.css" as="style" onload="this.onload=null;this.rel='stylesheet'">
<script>
    //function to check if jQuery is ready
    function jqIsReady() {
        if (typeof $ === "undefined") {
            //if (!JQREADY)
            return false;
        }
        return true;
    }
    (function jqCheck() {
        if (!jqIsReady()) {
            setTimeout(jqCheck, 10);
            return;
        } else {
            $('.btn-appt').click(function() {
                var thisURL = $(this).attr('href');
                $.getScript('https://assets.calendly.com/assets/external/widget.js')
                    .done(function() {
                        Calendly.initPopupWidget({
                            url: thisURL
                        });
                        gtag('event', 'conversion', {
                            'allow_custom_scripts': true,
                            'send_to': 'DC-1461522/fy17l0/sched0+standard'
                        });
                    })
                    .fail(function() {
                        window.location.href = thisUrl;
                    });
                return false;
            });
        }
    })();
</script>
</main>
		</dsp:layeredBundle>
	</lzb:pageContainer>
</dsp:page>
