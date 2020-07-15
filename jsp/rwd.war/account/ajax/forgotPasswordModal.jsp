<%--
  - File Name: forgotPasswordModal.jsp
  - Author(s): DMI UX Team
  - Copyright Notice:
  - Description: This is the page for reset the password
  --%>

<layout:ajax>

	<jsp:attribute name="section">modal</jsp:attribute>
	<jsp:attribute name="pageType">forgotPasswordModal</jsp:attribute>

	<jsp:body>
		<fmt:message  var="forgotTitle" key="forgot.title"/>
		<div class="forgot-password-modal" role="dialog" id="forgotPasswordModal">

			<div class="modal-header">
				<div class="title-bar">
					<h2 class="title">${forgotTitle}</h2>
				</div>
			</div>

			<div class="modal-body">
				<dsp:include src="${contextPath}/account/includes/forgot-password.jsp" />
			</div>

		</div>
	</jsp:body>
</layout:ajax>
