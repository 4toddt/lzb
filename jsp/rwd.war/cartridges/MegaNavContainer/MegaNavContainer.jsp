<dsp:page>

	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="menuContainer" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />

	<!-- START OF THE NAVIGATION -->

	<c:choose>
		<c:when test="${headerType eq 'mobile'}">
			<%-- offCanvas heading --%>
			<div class="off-canvas-heading header-menu">
				<a href="javascript:void(0);" class="close-off-canvas-link">
					<span class="icon icon-close" aria-hidden="true"></span>
					<span class="sr-only">close menu</span>
				</a>
			</div>
			<div class="mobile-top-nav mobile-primary-nav drilldown-menu" data-drilldown>
				<ul class="off-canvas-list drilldown-list">
					<c:forEach var="menu" items="${menuContainer.menus}">
						<dsp:renderContentItem contentItem="${menu}"/>
					</c:forEach>
				</ul>
			</div>
		</c:when>
		<c:otherwise>
			<ul class="nav-list">
				<c:forEach var="menu" items="${menuContainer.menus}">
					<dsp:renderContentItem contentItem="${menu}"/>
				</c:forEach>
			</ul>
		</c:otherwise>
	</c:choose>
	<!-- END OF THE NAVIGATION -->




</dsp:page>
