<dsp:page>

	<!-- START OF THE NAVIGATION -->

	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />

	<%-- Page Variables --%>
	<dsp:getvalueof var="transient" bean="Profile.transient" />
	<dsp:getvalueof var="menuContainer" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<dsp:getvalueof var="siteHostName" value="${storeConfig.hostName}"/>


	<div class="mobile-top-nav mobile-utility-nav drilldown-menu" data-drilldown>
		<ul class="off-canvas-list drilldown-list">
			<li>
				<a href="/mobile/storeLocator/storeLocator.jsp" class="utility-link" aria-label="Stores" tabindex="0"><fmt:message key="utility.stores"/></a>
			</li>
			<c:choose>
				<c:when test="${ transient eq 'false' }">
					<li>
						<dsp:a href="${contextPath}/account/account.jsp" class="utility-link mobile-my-account-link" title=""><fmt:message key="dashboard.account"/></dsp:a>
					</li>
				</c:when>
				<c:otherwise>
					<li>
						<!-- For Guest User -->
						<a href="javascript:void(0);" class="utility-link mobile-sign-in-link"><fmt:message key="header.signIn"/> <span class="icon icon-arrow-right" aria-label="Sign In" aria-hidden="true"></span></a>
						<ul class="submenu mobile-utility-submenu">
							<li class="mobile-sign-in-form">
								<dsp:include src="${contextPath}/account/includes/loginForm.jsp">
									<dsp:param name="pageType" value="loginForm"/>
								</dsp:include>
							</li>
						</ul>
					</li>
				</c:otherwise>
			</c:choose>
			<c:forEach var="menu" items="${menuContainer.menus}">
				<dsp:renderContentItem contentItem="${menu}"/>
			</c:forEach>

			<%-- Currently not supporting languages on mobile site
			<li>
				<a href="#" class="utility-link" id="currLang" >
					<span class="icon icon-globe" aria-hidden="true"></span> English <span class="icon icon-arrow-right" aria-hidden="true"></span>
				</a>
				<ul class="lang-list submenu mobile-utility-submenu" id="langMenu">
				<dsp:include page="/global/includes/language.jsp">
					<dsp:param name="siteHostName" value="${siteHostName}"/>
				</dsp:include>
				</ul>
			</li>--%>
		</ul>
	</div>






	<!-- END OF THE NAVIGATION -->

</dsp:page>
