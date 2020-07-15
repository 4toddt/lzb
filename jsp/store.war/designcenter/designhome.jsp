<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>

<lzb:pageContainer>

	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty" />

	<c:set var="urlPath" value="${originatingRequest.RequestURIWithQueryString}" />

<%-- 	<dsp:valueof bean="Profile.savedCovers"/>

	<dsp:setvalue beanvalue="Profile.savedCovers" param="savedCovers" />
	<dsp:setvalue paramvalue="savedCovers.giftlistItems" param="savedCoversItem" />

	<dsp:getvalueof var="savedCovers" param="savedCoversItem" /> --%>
			<jsp:attribute name="bodyClass">npc</jsp:attribute>
			<jsp:attribute name="seoAlternateURL"></jsp:attribute>
			<jsp:attribute name="seoCanonicalURL">${originatingRequest.getRequestURI()}</jsp:attribute>
			<lzb:breadCrumb pageKey="breadcrumb.designCenter" divClass="breadcrumb" />
			<main role="main">
				<dsp:include page="/includes/leftnavigation.jsp"/>

				<section role="region" class="my-account-content">
				<h1>My Design Center</h1>
				 <div class="tab-wrapper" role="tabpanel">
	                    <ul class="tabs" data-module="tabs" role="tablist">
	                        <li data-rel="tab1" role="tab" aria-controls="tab1"
	                        	 <c:if test="${fn:contains(urlPath, 'tab=1')}">class="active"</c:if>
	                         >
	                         Design Help</li>
	                        <li data-rel="tab2" role="tab" aria-controls="tab2"
	                        	<c:if test="${fn:contains(urlPath, 'tab=2')}">class="active"</c:if>
	                        >
	                        Saved Covers</li>
	                        <li data-rel="tab3" role="tab" aria-controls="tab3"
	                        	<c:if test="${fn:contains(urlPath, 'tab=3')}">class="active"</c:if>
	                        >
	                        Room Planner
	                        </li>
	                    </ul>
	            </div>
					<div class="tab-content
							<c:if test="${fn:contains(urlPath, 'tab=1')}">active</c:if>
						"
						id="tab1" data-tab-content="tab1">
						<div class="design-cell-wrapper" id="designHelp">
						<div class="design-message">Build the room of your dreams using our Design Center</div>
							<div class="design-cells">
								<div class="cell-image"><a href="#"><img src="/Images/designcenter/savefavourites.jpg"></a></div>
								<div class="cells-header"><a href="#">Save Your Favorite Covers</a></div>
								<div class="cells-txt">Search or browse for the fabrics or leathers you like best. Save them to your list so you can reference them in the future.</div>
							</div>
							<div class="design-cells">
								<div class="cell-image"><a href="#"><img src="/Images/designcenter/roomplanner.png"></a></div>
								<div class="cells-header"><a href="#">Room Planner</a></div>
								<div class="cells-txt">Worried about space? Use our room planner to enter your room dimensions and drag and drop pieces into place.</div>
							</div>
							<div class="design-cells">
								<div class="cell-image"><a href="#"><img src="/Images/designcenter/stylefinder.jpg"></a></div>
								<div class="cells-header"><a href="#">Style Finder</a></div>
								<div class="cells-txt">What's your style? Take our quiz to find out!</div>
							</div>
							<div class="design-cells">
									<div class="cell-image"><a href="#"><img src="/Images/designcenter/freeinhomedesign.jpg"></a></div>
								<div class="cells-header"><a href="#">Free In-Home Design</a></div>
								<div class="cells-txt">Leave it to the pros - our La-Z-Boy designers always have your style, comfort and budget in mind.</div>
							</div>
							<div class="design-cells">
								<div class="cell-image"><a href="#"><img src="/Images/designcenter/roominspirations.png"></a></div>
								<div class="cells-header"><a href="#">Room Inspirations</a></div>
								<div class="cells-txt">Need a jolt of creativity? Find it in our Room Inspirations.</div>
							</div>
							<div class="design-cells">
								<div class="cell-image"><a href="#"><img src="/Images/designcenter/roommeasuring.png"></a></div>
								<div class="cells-header"><a href="#">Room Measuring</a></div>
								<div class="cells-txt">Make sure your special piece fits all your need - space, volume and comfort - by following our measuring tips.</div>
							</div>
						</div>
					</div><%-- #tab1 --%>
					<div class="design-cell-wrapper tab-content
						<c:if test="${fn:contains(urlPath, 'tab=2')}">active</c:if>
						"
						id="tab2" data-tab-content="tab2">
						<dsp:include page="/account/designCenter/saved_covers.jsp"/>
					</div>
					<div class="design-cell-wrapper tab-content
						<c:if test="${fn:contains(urlPath, 'tab=3')}">active</c:if>
						"
						id="tab3" data-tab-content="tab3">
						<dsp:include page="/account/designCenter/roomPlanner.jsp"/>
					</div>

            </section>
			</main>

	</lzb:pageContainer>

</dsp:page>
