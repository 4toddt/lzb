<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/com/lzb/commerce/storeLocator/droplet/LZBDisplayPreferredStoreDroplet" />
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBDealerStoreDroplet" />
	<dsp:importbean bean="/com/lzb/service/SessionBean"/>
	<dsp:layeredBundle basename="com.lzb.common.WebAppResources" locale="en_US">

	<dsp:getvalueof var="transient" bean="Profile.transient" />
	<dsp:getvalueof var="currentStore" bean="Profile.currentStore"/>
	<dsp:getvalueof var="preferredStore" bean="Profile.preferredStore"/>
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<dsp:getvalueof var="geoLocatedZipcode" bean="SessionBean.geoLocatedZipcode"/>

	<c:choose>
		<c:when test="${not empty preferredStore}">
			<dsp:getvalueof var="store" value="${preferredStore}"/>
			<dsp:getvalueof var="parentDealerId" value="${preferredStore.parentDealerNumber}"/>
			<dsp:getvalueof var="storeDealerId" value="${preferredStore.dealerNumber}"/>
		</c:when>
		<c:otherwise>
			<dsp:getvalueof var="store" value="${currentStore}"/>
			<dsp:getvalueof var="parentDealerId" value="${currentStore.parentDealerNumber}"/>
			<dsp:getvalueof var="storeDealerId" value="${currentStore.dealerNumber}"/>
		</c:otherwise>
	</c:choose>

	<fmt:message key="preferdStore.storeDetailsFooterStore" var="storeDetails"/>
	<fmt:message key="preferdStore.moreStore" var="moreStore"/>
	<fmt:message key="preferdStore.getDirection" var="getDirection"/>

		<footer role="contentinfo">
				<%--
				PromoImageTextLink.jsp  need to find out if the text is supposed to be there and if it is, what is supposed to be done with it
				there is nothing in the wires or comps that cover the text
				 --%>
			<%-- START Promos --%>
			<div class="promos">
				<%-- START Store Content --%>
				<div class="half-page-promo store-callout">
					<c:choose>
						<%-- Content When Store Exists --%>
						<c:when test="${ store != null }">

							<c:if test="${not empty geoLocatedZipcode}">
								<input type="hidden" id="geoLocatedZipcode" name="${geoLocatedZipcode}"/>
								<input type="hidden" id="prefStoreAddr" name="${store.address1}, ${store.city}, ${store.stateAddress} ${store.postalCode}"/>
							</c:if>

							<p><fmt:message key="preferdStore.yourStoreFooterStore"/></p>
							<h3>${store.name}</h3>
							<div class="content" data-module="store-distance">
								<div class="col-1">
									<h4>${store.city}, ${store.stateAddress}<span id="store-dist"></span></h4>
									<p>${store.address1}${store.address2}${store.address3}</p>

									<c:if test="${not empty parentDealerId }">
										<dsp:droplet name="/com/lzb/droplet/UmbracoContentDroplet">
											<dsp:param name="dealerId" value="${storeDealerId}" />
											<dsp:param name="contentType" value="storeInfo" />
											<%--<dsp:param name="bannerName" value="Nav" /> --%>
											<dsp:oparam name="output">
												<dsp:getvalueof var="storeHours" vartype="String" param="response" />
											</dsp:oparam>
										</dsp:droplet>
									</c:if>

									<c:if test="${not empty storeHours }">
										<c:set var="today" value="<%=new java.util.Date()%>"/>
										<fmt:message key="preferdStore.hoursOpen" var="hoursOpen"/>
										<fmt:formatDate var="day" value="${today}" pattern="E"/>
										<dsp:droplet name="/com/lzb/droplet/LZBParseStoreHoursDroplet">
											<dsp:param name="hours" value="${storeHours}"/>
											<dsp:oparam name="output">
												<dsp:getvalueof var="hoursMap" param="hoursMap" />
												<c:forEach items="${hoursMap}" var="dayHours">
													<c:if test="${fn:startsWith(fn:split(dayHours,'@')[0], day)}">
														<p>${fn:split(dayHours,'@')[1]}</p>
													</c:if>
												</c:forEach>
											</dsp:oparam>
										</dsp:droplet>
									</c:if>


									<dsp:getvalueof var="webUrl" value="${store.storeWebsiteUrl }"/>
									<c:choose>
										<c:when test="${ not empty webUrl}">
											<c:choose>
												<c:when test="${fn:contains(webUrl,'http://') }">
													<dsp:getvalueof var="storeURL" value="${webUrl}"/>
												</c:when>
												<c:otherwise>
													<dsp:getvalueof var="storeURL" value="${webUrl}"/>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<dsp:getvalueof var="storeURL" value="#"/>
										</c:otherwise>
									</c:choose>
									<c:if test="${not empty storeURL}">
										<a href="${storeURL}" class="left" aria-label="${storeDetails}" tabindex="0">${storeDetails}</a>
									</c:if>
									<a href="${pageContext.request.contextPath}/storeLocator/storeLocator.jsp" class="right" aria-label="${moreStore}" tabindex="0">${moreStore}</a>
									<a href="https://www.google.com/maps/dir/Current+Location/${store.address1}${store.address2}${store.address3}+${store.city}+${store.stateAddress}+${store.postalCode}" target="_blank" class="button secondary-btn" aria-label="${getDirection}" tabindex="0">${getDirection}</a>
								</div>
								<div class="col-2">
									<img src="${content.storeImageUrl}" alt="${content.storeImageAlt}" />
								</div>
							</div>
						</c:when>
						<%-- Default Content When No Store Exists --%>
						<c:otherwise>
							<p>${content.visitStoreText}</p>
							<h3>${content.storeDefaultText}</h3>
							<div class="content">
								<div class="col-1">
									<c:if test="${not empty content.link}">
										<dsp:droplet name="ActionURLDroplet">
											<dsp:param name="action" value="${content.link}" />
											<dsp:oparam name="output">
												<dsp:getvalueof var="actionURLink" param="actionURL" /> <%-- Link Parsed --%>
											</dsp:oparam>
											<dsp:oparam name="empty">
											</dsp:oparam>
										</dsp:droplet>
									</c:if>
									<a href="${actionURLink}" class="button secondary-btn" aria-label="${content.CTAText}" tabindex="0">${content.CTAText}</a>
								</div>
								<div class="col-2">
									<img src="${content.storeImageUrl}" alt="${content.storeImageAlt}" />
								</div>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
				<%-- END Store Content --%>
				<%-- START Promo Content --%>
				<c:if test="${not empty content.managedSlotList}">
					<c:forEach items="${content.managedSlotList}" var="managedSlot">
                      		<dsp:renderContentItem contentItem="${managedSlot}" />
					</c:forEach>
				</c:if>
				<%-- END Promo Content --%>
			</div>
			<%-- END Promos --%>

				<div class="utilities">
					<dsp:include src="${pageContext.request.contextPath}/account/SignUpEmail.jsp" />
				</div><%-- .utilities --%>
				<div class="footer-links">
					<ul>

						<dsp:include src="${pageContext.request.contextPath}/global/includes/customerCare.jsp"/>

						<c:if test="${not empty content.customerSupportManagedSlot}">

							<li>
								${content.customerSupportManagedSlot }
							</li>

						</c:if>

						<c:if test="${not empty content.footerLinkGroups}">

							<c:forEach items="${content.footerLinkGroups }" var="footerLinkGroup">

								<dsp:renderContentItem contentItem="${footerLinkGroup}" />

							</c:forEach>

						</c:if>

						<dsp:include src="${pageContext.request.contextPath}/global/includes/partnerSites.jsp"/>

					</ul>

				</div><%-- .footer-links --%>

				<div class="fine-print">
					<c:if test="${not empty content.copyrightInfo}">
						<ul>
						<dsp:renderContentItem contentItem="${content.copyrightInfo}" />
						</ul>
					</c:if>
				</div><%-- .fine-print --%>

	</footer>
	</dsp:layeredBundle>
</dsp:page>