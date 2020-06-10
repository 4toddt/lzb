<%--
  - File Name: forgotPasswordSuccessModal.jsp
  - Author(s): DMI UX Team
  - Copyright Notice:
  - Description: This is the page for reset the password
  --%>

<layout:ajax>

	<jsp:attribute name="section">modal</jsp:attribute>
	<jsp:attribute name="pageType">forgotPasswordSuccessModal</jsp:attribute>

	<jsp:body>
		<div class="forgot-password-success-modal" role="dialog" id="forgotPasswordSuccessModal">
			<div class="modal-header">
				<div class="title-bar">
					<h2 class="title"><fmt:message key="forgot.msg"/></h2>
				</div>
			</div>

			<div class="modal-body">
				<h3 class="success">
					<fmt:message key="forgotEmail.success"/>
				</h3>
				<p><fmt:message key="forgot.email"/></p>
			</div>

		</div>
	</jsp:body>
</layout:ajax>
