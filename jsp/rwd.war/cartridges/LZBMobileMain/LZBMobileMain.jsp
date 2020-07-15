<dsp:page>

	<%-- Imports --%>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/com/lzb/droplet/UmbracoContentDroplet" />
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet"/>
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	
	<%-- Page Variables --%>
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />

	<section role="main" class="section-row">
		<section>
			<div class="section-content">
				<div class="primary-promo">
					<%--  <img src="/img/mobile/promo_01.png" alt="Placholder promo" /> --%>
					<c:if test="${not empty contentItem.managedContentSlot}">
						<c:forEach var="HeaderTargeterContainer" items="${contentItem.managedContentSlot}">
							<dsp:getvalueof var="headerContentTargeters" value="${HeaderTargeterContainer.targeter}"/>
							<c:if test="${not empty headerContentTargeters}">
								<c:forEach var="headerContentTargeter" items="${headerContentTargeters}">
									<dsp:getvalueof value="${headerContentTargeter.typeOfPromoBlock}" var="typeOfPromoBlock" />
									<c:if test="${typeOfPromoBlock eq 2}">
										<%--  Umbaraco--%>
										<dsp:droplet name="UmbracoContentDroplet">
											<dsp:param name="contentType" value="${headerContentTargeter.contnetType}" />
											<dsp:param name="bannerName" value="${headerContentTargeter.contnetName}" />
											<dsp:param name="dealerId" bean="Profile.currentStore.repositoryId" />
											<dsp:oparam name="output">
												<dsp:getvalueof var="imageUrl" vartype="String" param="response" />
													<dsp:getvalueof var="bannerMap" vartype="String" param="bannerMap" />
													<a href="${bannerMap.bannerURL}">
									          			<img src="${bannerMap.bannerImage}" alt="${bannerMap.bannerAltText}"/>
									          		</a>
											</dsp:oparam>
											<dsp:oparam name="error">
												 <!-- Error out Umbraco Content -->
											</dsp:oparam>
											<dsp:oparam name="empty">
												<!-- Empty out Umbraco Content -->
											</dsp:oparam>
										</dsp:droplet>
									</c:if>
								</c:forEach>
							</c:if>
						</c:forEach>
					</c:if>
				</div>
			</div>
		</section>

		<c:if test="${not empty contentItem.HomePageCarouselContentSlot}">
			<section id="homeCarousel">
				<div class="section-content">
					<dsp:renderContentItem contentItem="${contentItem.HomePageCarouselContentSlot}" />
				</div>
			</section>
		</c:if>

		<c:if test="${not empty  contentItem.MainMenu}">
			<%--Level 1 Nav Link --%>
			<c:forEach var="menu" items="${contentItem.MainMenu}">
				<section>
					<div class="section-content">
						<dsp:renderContentItem contentItem="${menu}" />
					</div>
				</section>
			</c:forEach>
		</c:if>

		<c:if test="${not empty contentItem.managedContentSlot}">
			<section>
				<div class="section-content">
					<div class="categories">
						<c:forEach var="element" items="${contentItem.managedContentSlot}">
							<figcaption><dsp:renderContentItem contentItem="${element}" /></figcaption>
						</c:forEach>
					</div>
				</div>
			</section>
		</c:if>

		<!-- non product content goes here -->
		<section>
			<div class="section-content">
				<nav class="utility hide-for-large" role="navigation" aria-label="utility menu">
					<ul>
						<dsp:include src="${siteBaseUrl}/global/includes/npcList.jsp">
							<dsp:param name="isMenu" value="false"/>
						</dsp:include>
					</ul>
				</nav>
			</div>
		</section>
	</section>
</dsp:page>
