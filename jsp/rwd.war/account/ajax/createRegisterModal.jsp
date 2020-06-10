<%--
  - File Name: createRegisterModal.jsp
  - Author(s): DMI UX Team
  - Copyright Notice:
  - Description: This is the register page for create an account
  --%>

<layout:ajax>

	<jsp:attribute name="section">modal</jsp:attribute>
	<jsp:attribute name="pageType">createRegisterModal</jsp:attribute>

	<jsp:body>
		<div class="register-modal" role="dialog" id="registerModal">

			<div class="modal-header">
				<div class="title-bar">
					<h2 class="title"><fmt:message key="register.create" /></h2>
				</div>
			</div>

			<div class="modal-body">
				<!--  Sign up benefits -->
				<div class="signup-benefits-section">
					<dsp:include src="${contextPath}/account/includes/signUpBenefits.jsp"></dsp:include>
				</div>
				
				<!--  Sign up form -->
				<div class="signup-form-section">
					<dsp:include src="${contextPath}/account/includes/registerForm.jsp"></dsp:include>
				</div>
			</div>

		</div>
	</jsp:body>
</layout:ajax>
