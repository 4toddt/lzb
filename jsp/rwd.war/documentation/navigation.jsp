<%--
  - File Name: presentation.jsp
  - Author(s): DMI UX Team
  - Copyright Notice:
  - Description: This page documents navigation components in the UX framework
  - Parameters:
  -
  --%>
<layout:documentation>
	<jsp:attribute name="pageTitle">UX Framework Documentation</jsp:attribute>
	<jsp:attribute name="metaDescription"></jsp:attribute>
	<jsp:attribute name="metaKeywords"></jsp:attribute>
	<jsp:attribute name="seoCanonicalURL"></jsp:attribute>
	<jsp:attribute name="seoRobots"></jsp:attribute>
	<jsp:attribute name="lastModified"></jsp:attribute>
	<jsp:attribute name="doSessionTimeout">false</jsp:attribute>
	<jsp:attribute name="section">documentation</jsp:attribute>
	<jsp:attribute name="pageType"></jsp:attribute>
	<jsp:attribute name="bodyClass">documentation</jsp:attribute>
	<jsp:body>
		<div class="row doc-wrapper">
			<div class="small-3 columns">
				<c:import url="/documentation/includes/documentationNav.jsp">
					<c:param name="navSection" value="navigation"/>
				</c:import>
			</div>

			<div class="small-9 columns">

				<h1>Navigation Components</h1>

				<c:import url="/documentation/includes/utilityNav.jsp"/>

				<c:import url="/documentation/includes/primaryNav.jsp"/>

				<c:import url="/documentation/includes/drilldown.jsp"/>

				<c:import url="/documentation/includes/facets.jsp"/>

				<c:import url="/documentation/includes/pagination.jsp"/>

			</div>
		</div>
	</jsp:body>
</layout:documentation>

