<%--
  - File Name: storeLocatorListModal.jsp
  - Author(s): jjensen
  - Copyright Notice:
  - Description: display searching Nearest Stores list
  - Parameters:
  --%>

<layout:ajax>

	<jsp:attribute name="section">modal</jsp:attribute>
	<jsp:attribute name="pageType">storeLocatorModal</jsp:attribute>

	<jsp:body>
		<div class="store-locator-list-modal" role="dialog" id="storeLocatorModal"> 

			<div class="modal-header hide">
				<div class="title-bar">
					<h2 class="title"></h2>
				</div>
			</div>

			<div class="modal-body">
				<!--  store locator results list -->
				<div class="store-location-results">
					<dsp:include src="${contextPath}/account/includes/storeResults.jsp"></dsp:include>
				</div>
			</div>

		</div>
	</jsp:body>
</layout:ajax>
