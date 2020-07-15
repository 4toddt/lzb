<dsp:page>
	<dsp:importbean bean="/com/lzb/droplet/UmbracoContentDroplet" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />	
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="content"
		vartype="com.endeca.infront.assembler.ContentItem"
		value="${originatingRequest.contentItem}" />
		<dsp:getvalueof bean="Profile.currentStore" var="currentStore" />
		
		<c:choose>
			<c:when test="${not empty currentStore and not empty currentStore.country }">
				<c:set var="userCountry" value="${currentStore.country }" />
			</c:when>
			<c:otherwise>
				<c:set var="userCountry" value="US"/>
			</c:otherwise>
		</c:choose>
		<dsp:getvalueof var="carouselEnabled" value="${content.carouselEnabled}"/>
		<c:set var="countrySpecificHomePageCarouselContentSlot" value="${userCountry }_HomePageCarouselContentSlot" />
<!-- 		userCountry : ${userCountry } , Store Id : ${currentStore.locationId }, Parent Dealer : ${ currentStore.parentDealerNumber}
		countrySpecificHomePageCarouselContentSlot : ${countrySpecificHomePageCarouselContentSlot } , content.name : ${content.name } -->
		<c:if test="${not empty countrySpecificHomePageCarouselContentSlot and  not empty content.name 
		and countrySpecificHomePageCarouselContentSlot eq content.name  and not empty content.contents}">
			<c:choose>	
			<c:when test="${carouselEnabled eq 'y'}">		
				<div id="hero-carousel" class="hero-carousel" data-module="carousel" data-infiniteLoop="false" data-pause="6000">
					<div class="spinner"></div>
					<ul>
					<c:forEach items="${content.contents}" var="element">
						<li>
							<div>
								<dsp:renderContentItem contentItem="${element}" />
							</div>
						</li>
					</c:forEach>
					
				</ul>
				</div><%-- #hero-carousel --%>
			</c:when>
			<c:otherwise>
				<c:forEach items="${content.contents}" var="element">
					<dsp:renderContentItem contentItem="${element}" />
				</c:forEach>
			</c:otherwise>
			</c:choose>			
			<%--</section> section class="hero" started in HomePageCategoryLinkContent.jsp --%>
		</c:if>
	<%-- have to include this here because there isn't a cartridge that wraps both ShopByRoom and ShopByStyle.  ends in HorizontalRecordSpotlight.jsp --%>
</dsp:page>