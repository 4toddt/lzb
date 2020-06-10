<dsp:page>

	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="menuContainer" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />


	<main class="site-map" role="main">
	
		<h1>Site Map</h1>

		<div>

			<ul>
			<c:forEach var="menu" items="${menuContainer.linkGroup}">
				<dsp:renderContentItem contentItem="${menu}"/>
			</c:forEach>
			</ul>

		</div>
		
		<div>

			<ul>
				<li class="nav-subarea header"><a href="/content/CustomizeIt" title="Customize It">Customize It</a>	

					<ul>
						<li class="nav-detail"><a href="/content/CustomizeIt/CoverSearch/">Cover Search</a></li>
						<li class="nav-detail"><a href="/content/CustomizeIt/FullAnilineLeather/">Full Aniline Leather</a></li>
						<li class="nav-detail"><a href="/content/CustomizeIt/iClean/">iClean</a></li>
						<li class="nav-detail"><a href="/content/CustomizeIt/Leather/">Leather</a></li>
						<li class="nav-detail"><a href="/content/CustomizeIt/OptionsAndUpgrades/">Options and Upgrades</a></li>
						<li class="nav-detail"><a href="/content/CustomizeIt/performance-fabrics/">Performance Fabrics</a></li>
						<li class="nav-detail"><a href="/content/CustomizeIt/powerlift/">PowerLift</a></li>
						<li class="nav-detail"><a href="/content/CustomizeIt/powerlift-features/">PowerLift Features</a></li>
						<li class="nav-detail"><a href="/content/CustomizeIt/SleeperOptions/">Sleeper Options</a></li>
						<li class="nav-detail"><a href="/content/CustomizeIt/power-options/">Power Options</a></li>
					</ul>	

				</li>
			</ul>

			<ul>
				<li class="nav-subarea header"><a href="/content/DesignInspirations" title="Design Inspirations">Design Inspirations</a>	

					<ul>
						<li class="nav-detail"><a href="/content/DesignInspirations/3DRoomPlanner/">3D Room Planner</a></li>
						<li class="nav-detail"><a href="/content/DesignInspirations/StyleFinder/">Style Finder</a></li>
					</ul>

				</li>
			</ul>
			
			<ul>
				<li class="nav-subarea header"><a href="/content/design-services/" title="Design Services/">Design Services</a>	

					<ul>
						<li class="nav-detail"><a href="/content/design-services/design-stories/">Design Stories</a></li>
					</ul>

				</li>
			</ul>
			
			<ul>
				<li class="nav-subarea header"><a href="/content/diy-network-Ultimate-Retreat/" title="DIY Network Ultimate Retreat/">DIY Network Ultimate Retreat</a>	

					<ul>
						<li class="nav-detail"><a href="/content/diy-network-Ultimate-Retreat/living-room-and-entry-way/">Living Room & Entry Way</a></li>
						<li class="nav-detail"><a href="/content/diy-network-Ultimate-Retreat/den/">Den</a></li>
						<li class="nav-detail"><a href="/content/diy-network-Ultimate-Retreat/bedroom/">Bedroom</a></li>
						<li class="nav-detail"><a href="/content/diy-network-Ultimate-Retreat/dining-room/">Dining Room</a></li>
					</ul>

				</li>
			</ul>
			
			<ul>
				<li class="nav-subarea header"><a href="/content/NowFeaturing/" title="Now Featuring/">Now Featuring</a>	

					<ul>
						<li class="nav-detail"><a href="/content/NowFeaturing/HOMEments/">#HOMEments</a></li>
						<li class="nav-detail"><a href="/content/NowFeaturing/TheMakers/">The Makers</a></li>
						<li class="nav-detail"><a href="/content/NowFeaturing/ViewOurPrintAds/">View Our Print Ads</a></li>
						<li class="nav-detail"><a href="/content/NowFeaturing/ViewOurTVAds/">View Our TV Ads</a></li>
					</ul>

				</li>
			</ul>


			<ul>
				<li class="nav-subarea header"><a href="/content/room-inspirations/" title="Room Inspirations">Room Inspirations</a>	

					<ul>
						<li class="nav-detail"><a href="/content/room-inspirations/comfort-around-clock/">Comfort Around the Clock</a></li>
						<li class="nav-detail"><a href="/content/room-inspirations/leather-without-limits/">Leather Without Limits</a></li>
						<li class="nav-detail"><a href="/content/room-inspirations/style-on-a-budget/">Style on a Budget</a></li>
					</ul>	

				</li>
			</ul>
			
			<ul>
				<li class="nav-subarea header"><a href="/content/design-dash/" title="Design Dash">Design Dash</a>	

					<ul>
						<li class="nav-detail"><a href="/content/design-dash/beneath-my-heart/">Beneath My Heart</a></li>
						<li class="nav-detail"><a href="/content/design-dash/glitter-guide/">Glitter Guide</a></li>
						<li class="nav-detail"><a href="/content/design-dash/miss-mustard-seed/">Miss Mustard Seed</a></li>
						<li class="nav-detail"><a href="/content/design-dash/refresh-restyle/">Refresh Restyle</a></li>
						<li class="nav-detail"><a href="/content/design-dash/remodelaholic/">Remodelaholic</a></li>
						<li class="nav-detail"><a href="/content/design-dash/the-shabby-creek-cottage/">Shabby Creek Cottage</a></li>
						<li class="nav-detail"><a href="/content/design-dash/thrifty-decor-chick/">Thrifty Decor Chick</a></li>
					</ul>	

				</li>
			</ul>
			
			<ul class="account-links">
				<li class="nav-subarea "><a href="/content/Room-Planner-3D/">3D Room Planner</a></li>
				<li class="nav-subarea "><a href="/content/roomplanner-3d-help/">3D Room Planner Help</a></li>
				<li class="nav-subarea "><a href="/content/12-days-of-giving/">12 Days of Giving</a></li>
				<li class="nav-subarea "><a href="/content/4th_of_July/">4th of July</a></li>
				<li class="nav-subarea "><a href="/content/FathersDay/">Father's Day</a></li>
				<li class="nav-subarea "><a href="/content/man_cave/">Man Cave</a></li>
				<li class="nav-subarea "><a href="/content/MemorialDay/">Memorial Day</a></li>
				<li class="nav-subarea "><a href="/content/MothersDay/">Mother's Day</a></li>
				<li class="nav-subarea "><a href="/content/nook/">Nook</a></li>
				<li class="nav-subarea "><a href="/content/performance-fabric-patterns-care/">Performance Fabrics Pattersn and Care</a></li>
				<li class="nav-subarea "><a href="/content/personal-styling-form/">Personal Styling Form</a></li>
				<li class="nav-subarea "><a href="/content/personal-styling-promotion/">Personal Styling Promotion</a></li>
				<li class="nav-subarea "><a href="/content/recliner_for_everybody/">Recliner for Everybody</a></li>
				<li class="nav-subarea "><a href="/content/recliner-fit/">Recliner Fit</a></li>
				<li class="nav-subarea "><a href="/content/resort-casual/">Resort Casual</a></li>
				<li class="nav-subarea "><a href="/content/spring-covers/">Spring Covers</a></li>
				<li class="nav-subarea "><a href="/content/style-fit/">Style Fit</a></li>
			</ul>

		</div>

		<div>

			<ul>
				<li class="nav-subarea header"><a href="/content/CustomerCare" title="Customer Care">Customer Care</a>	

					<ul>
						<li class="nav-detail"><a href="/content/CustomerCare/contactus/">Contact Us</a></li>
						<li class="nav-detail"><a href="/content/CustomerCare/FAQS/">FAQS</a></li>
						<li class="nav-detail"><a href="/content/CustomerCare/customer-care-videos/">Customer Care Videos</a></li>
						<li class="nav-detail"><a href="/content/CustomerCare/ProductRegistration/">Product Registration</a></li>
						<li class="nav-detail"><a href="/content/CustomerCare/productmanuals/">Product Information</a></li>
						<li class="nav-detail"><a href="/content/CustomerCare/WarrantyInformation/">Warranty Information</a></li>
						<li class="nav-detail"><a href="/content/CustomerCare/policies/">Policies</a></li>
						<li class="nav-detail"><a href="/content/CustomerCare/catalogs/">Catalogs</a></li>
						<li class="nav-detail"><a href="/content/CustomerCare/ratings-and-reviews/">Ratings &amp; Reviews</a></li>
						<li class="nav-detail"><a href="/content/CustomerCare/fabric-and-leather-care/">Fabric and Leather Care</a></li>
						<li class="nav-detail"><a href="/content/CustomerCare/iclean-cleaning/">iClean™ Recommended Cleaning Methods</a></li>
						<li class="nav-detail"><a href="/content/CustomerCare/iclean-warranty/">iClean™ Warranty</a></li>
					</ul>	

				</li>
			</ul>

			
			<ul>
				<li class="nav-subarea header"><a href="/content/AboutLaZBoy" title="About La-Z-Boy">About La-Z-Boy</a>
				<ul>
					<li class="nav-detail"><a href="/content/AboutLaZBoy/Careers/">Careers</a></li>
					<li class="nav-detail"><a href="/content/AboutLaZBoy/EnvironmentalInitiatives/">Environmental Initiatives</a></li>
					<li class="nav-detail"><a href="/content/AboutLaZBoy/LZBCares/">La-Z-Boy Cares</a></li>
					<li class="nav-detail"><a href="/content/AboutLaZBoy/made-in-america/">Made in America</a></li>
					<li class="nav-detail"><a href="/content/AboutLaZBoy/NewsRoom/">News Room</a></li>
					<li class="nav-detail"><a href="/content/AboutLaZBoy/OurBrands/">Our Brands</a></li>
					<li class="nav-detail"><a href="/content/AboutLaZBoy/retail-opportunities/">Retail Opportunities</a></li>
					<li class="nav-detail"><a href="/content/AboutLaZBoy/RMHCharities/">Ronald McDonald House Charities®</a></li>
				</ul>	
				</li>
			</ul>
			
			<ul>
				<li class="nav-subarea header"><a href="/content/AboutLaZBoy/InvestorRelations/" title="Investor Relations">Investor Relations</a>
				<ul>
					<li class="nav-detail"><a href="/content/AboutLaZBoy/InvestorRelations/">Investor Overview</a></li>
					<li class="nav-detail"><a href="/content/AboutLaZBoy/InvestorRelations/">Corporate Governance</a></li>
					<li class="nav-detail"><a href="/content/AboutLaZBoy/InvestorRelations/">SEC Filings</a></li>
					<li class="nav-detail"><a href="/content/AboutLaZBoy/InvestorRelations/">Financial Reports</a></li>
					<li class="nav-detail"><a href="/content/AboutLaZBoy/InvestorRelations/">News & Events</a></li>
					<li class="nav-detail"><a href="/content/AboutLaZBoy/InvestorRelations/">Stock Information</a></li>
					<li class="nav-detail"><a href="/content/AboutLaZBoy/InvestorRelations/">Ownership Summary</a></li>
					<li class="nav-detail"><a href="/content/AboutLaZBoy/InvestorRelations/">Analysts</a></li>
					<li class="nav-detail"><a href="/content/AboutLaZBoy/InvestorRelations/">Presentations</a></li>
					<li class="nav-detail"><a href="/content/AboutLaZBoy/InvestorRelations/">Contact Information</a></li>
				</ul>	
				</li>
			</ul>
			
			<ul>
				<li class="nav-subarea header"><a href="/content/Supplier-Requirements/" title="Supplier Requirements">Supplier Requirements</a>
				<ul>
					<li class="nav-detail"><a href="/content/Supplier-Requirements/Branded-Business-Cover-Requirements/">Branded Business Cover Requirements</a></li>
					<li class="nav-detail"><a href="/content/Supplier-Requirements/Casegoods-Specific-Requirements/">Casegoods Specific Requirements</a></li>
					<li class="nav-detail"><a href="/content/Supplier-Requirements/Code-of-Business-Conduct/">Code of Business Conduct & Product Stewardship</a></li>
					<li class="nav-detail"><a href="/content/Supplier-Requirements/Compliance/">Compliane</a></li>
					<li class="nav-detail"><a href="/content/Supplier-Requirements/Delivery/">Delivery</a></li>
					<li class="nav-detail"><a href="/content/Supplier-Requirements/Vision-and-Values/">La-Z-Boy Vision & Values</a></li>
					<li class="nav-detail"><a href="/content/Supplier-Requirements/Purchase-Orders/">Purchase Orders</a></li>
					<li class="nav-detail"><a href="/content/Supplier-Requirements/Quality-System-Requirements/">Quality System Requirements</a></li>
					<li class="nav-detail"><a href="/content/Supplier-Requirements/Special-Trade-Programs/">Special Trade Programs</a></li>
					<li class="nav-detail"><a href="/content/Supplier-Requirements/Supplier-Awards/">Supplier Awards</a></li>
					<li class="nav-detail"><a href="/content/Supplier-Requirements/Supplier-Scorecard/">Supplier Scorecard</a></li>
					<li class="nav-detail"><a href="/content/Supplier-Requirements/Supplier-Selection-and-Approval/">Supplier Selection & Approval</a></li>
					<li class="nav-detail"><a href="/content/Supplier-Requirements/Supplier-Set-Up/">Supplier Set-Up</a></li>
				</ul>	
				</li>
			</ul>
			
			<ul>
				<li class="nav-subarea header"><a href="/content/policies/" title="Policies">Policies</a>
				<ul>
					<li class="nav-detail"><a href="/content/policies/ConflictMineralsPolicy/">Conflict Minerals Policy</a></li>
					<li class="nav-detail"><a href="/content/policies/ctsca/">CTSCA</a></li>
					<li class="nav-detail"><a href="/content/policies/privacy-policy/">Privacy Policy</a></li>
					<li class="nav-detail"><a href="/content/policies/return-policy/">Return Policy</a></li>
				</ul>	
				</li>
			</ul>
			<ul class="account-links">
				<li class="nav-subarea "><a href="/content/compare/">Compare</a></li>
				<li class="nav-subarea "><a href="/content/delivery-options/">Delivery Options</a></li>
				<li class="nav-subarea "><a href="/Financing/">Financing</a></li>
				<li class="nav-subarea "><a href="/content/gift-shop/">Gift Shop</a></li>
				<li class="nav-subarea "><a href="/content/legends/">Legends</a></li>
				<li class="nav-subarea "><a href="/content/second_to_none/">Second to None</a></li>
				<li class="nav-subarea "><a href="/site-map/">Site Map</a></li>
			</ul>
			<br/>
			<ul class="account-links">
				<li class="nav-subarea "><a href="/account/profile.jsp">My Account</a></li>
				<li class="nav-subarea "><a href="/rwd/checkout/cart.jsp">Shopping Cart</a></li>
				<li class="nav-subarea "><a href="/order/anonymousOrders.jsp">Online Order Status</a></li>
				<li class="nav-subarea "><a href="/storeLocator/storeLocator.jsp">Store Locator</a></li>
			</ul>

		</div>

		<div>

			<div class="contact-chat">

				<div class="contact-detls">

					<h3><fmt:message key="contactus.Byphone"/></h3>

					<p><fmt:message key="contactus.questionOnline"/></p>

					<a href="tel:+18003756890"><fmt:message key="accountEmail.customerCareNo"/></a>

					<p><fmt:message key="contactus.warrantyEnquiries"/></p>

					<a href="tel:+18003756890"><fmt:message key="contactus.comfort"/></a>

					<p>or <a href="tel:+18558026636"><fmt:message key="contactus.optionalCallNo"/></a></p>

					<p><fmt:message key="contactus.Timing"/></p>

				</div>

			</div>

		</div>

		</main>

</dsp:page>