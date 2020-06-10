<dsp:page>

	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/com/lzb/droplet/LZBCountryStoreDroplet" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/com/lzb/commerce/storeLocator/handler/LZBStoreLocatorFormHandler" />

	<lzb:pageContainer>
		<jsp:attribute name="bodyClass">npc</jsp:attribute>
		<jsp:attribute name="seoAlternateURL"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL">${originatingRequest.getRequestURI()}</jsp:attribute>
		<jsp:body>
			<dsp:layeredBundle basename="com.lzb.common.WebAppResources">
				<dsp:getvalueof var="countryStoreList" bean="LZBStoreLocatorFormHandler.countryStoreList"/>
				<dsp:getvalueof var="currentCountry" bean="LZBStoreLocatorFormHandler.valueMap.country"/>
				<dsp:getvalueof var="query" value="false"/>

				<c:choose>
					<c:when test="${ not empty countryStoreList }">
						<dsp:getvalueof var="query" value="${query}"/>
					</c:when>
					<c:otherwise>
						<dsp:getvalueof var="query" value="true"/>
					</c:otherwise>
				</c:choose>

        <main role="main" class="country-store-locator">

			<h1>Country Store Locator</h1>

			<p>No matter where you are in the world, nothing compares to the comfort of La-Z-Boy&reg;.</p>

				<dsp:form id="countryStoreLocator" iclass="country-store-locator" name="countryStoreLocator" action="#" method="post">

					<fieldset>

						<legend>Locator Form</legend>

						<label for="country_${countNum}">Country:</label>
						<dsp:select id="country_${countNum}" bean="LZBStoreLocatorFormHandler.valueMap.country" >
						<dsp:droplet name="LZBCountryStoreDroplet">
							<dsp:param name="country" value="${searchInput}" />
							<dsp:param name="query" value="${query}" />
								<dsp:oparam name="output">
									<dsp:getvalueof var="countryList" param="countryList"/>
									<dsp:getvalueof var="storesCountry" param="stores"/>
									<dsp:droplet name="ForEach">
										<dsp:param name="array" value="${countryList}" />
										<dsp:param name="elementName" value="country"/>
											<dsp:oparam name="output">
												<dsp:getvalueof var="country" param="country"/>
												<c:choose>
													<c:when test="${ not empty currentCountry && currentCountry == country }">
														<option value="${country}" selected="selected" >${country}</option>
													</c:when>
													<c:otherwise>
														<option value="${country}">${country}</option>
													</c:otherwise>
												</c:choose>
											</dsp:oparam>
									</dsp:droplet>
								</dsp:oparam>
						</dsp:droplet>
				</dsp:select>
				<dsp:input type="submit" value="Search Country store" name="countryStore" iclass="btn-primary" id="countryStore" bean="LZBStoreLocatorFormHandler.countryStores" />
				<dsp:input type="hidden" name="locatorSucccess"  bean="LZBStoreLocatorFormHandler.locateSuccessURL" value="${siteBaseUrl}/storeLocator/countryStoreLocator.jsp" />
				<dsp:input type="hidden" name="locatorError"  bean="LZBStoreLocatorFormHandler.locateErrorURL" value="${siteBaseUrl}/storeLocator/countryStoreLocator.jsp"/>

					</fieldset>

				</dsp:form>

				<c:choose>
					<c:when test="${ not empty countryStoreList }">
						<dsp:getvalueof var="stores" value="${countryStoreList}"/>
					</c:when>
					<c:otherwise>
						<dsp:getvalueof var="stores" value="${storesCountry}"/>
					</c:otherwise>
				</c:choose>

				<c:if test="${not empty stores}">
					<dsp:droplet name="ForEach">
						<dsp:param name="array" value="${stores}" />
						<dsp:param name="elementName" value="store"/>
							<dsp:oparam name="output">
								<dsp:getvalueof var="store" param="store"/>

				<div class="vcard">

					<strong>${store.name}</strong>

					<div class="adr">

						<div class="street-address">${store.address1} ${store.address2} ${store.address3}</div>

						<span class="locality">${store.city}</span>,&nbsp;<span class="region" title="${store.country}">${store.country}</span>

						<c:if test="${ not empty store.phoneNumber}">
						<div class="tel">Phone: <a href="tel:${store.phoneNumber}">${store.phoneNumber}</a></div>
						</c:if>
						<c:if test="${ not empty store.faxNumber }">
						<div class="tel">Fax: <a href="tel:${store.faxNumber}">${store.faxNumber}</a></div>
						</c:if>

					</div>

				</div>

							</dsp:oparam>

					</dsp:droplet>

				</c:if>

				</main>
			</dsp:layeredBundle>
		</jsp:body>
	</lzb:pageContainer>
</dsp:page>
