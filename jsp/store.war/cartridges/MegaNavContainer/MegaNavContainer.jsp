<dsp:page>

	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="menuContainer" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />

	<!-- START OF THE NAVIGATION -->
	
		<ul class="nav-list">
			<c:forEach var="menu" items="${menuContainer.menus}">
				<dsp:renderContentItem contentItem="${menu}"/>
			</c:forEach>
		</ul>
	<!-- END OF THE NAVIGATION -->

</dsp:page>