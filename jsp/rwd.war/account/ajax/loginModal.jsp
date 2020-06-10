<%--
  - File Name: loginModal.jsp
  - Author(s): DMI UX Team
  - Copyright Notice:
  - Description: This is the home page
  --%>

<layout:ajax>

	<%-- Page Variables --%>
	<dsp:getvalueof param="pageType" var="pageType"/>
	
	<jsp:attribute name="section">modal</jsp:attribute>
	<jsp:attribute name="pageType">loginModal</jsp:attribute>

	<jsp:body>
		<div class="login-modal" role="dialog" id="loginModal">

			<div class="modal-header">
				<div class="title-bar">
					<h2 class="title">Sign in to your account</h2>
				</div>
			</div>

			<div class="modal-body">
				<dsp:include src="${contextPath}/account/includes/loginForm.jsp">
					<dsp:param name="pageType" value="${pageType}"/>
				</dsp:include>
			</div>

		</div>
	</jsp:body>
</layout:ajax>
