<%--
	- File Name: securityCodeModal.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This modal displays helpful Information for finding credit card secutrty codes.
	- Required Parameters:
	- Optional Parameters:
--%>
<dsp:page>
	<layout:ajax>

		<jsp:attribute name="section">modal</jsp:attribute>
		<jsp:attribute name="pageType">securityCodeModal</jsp:attribute>

		<jsp:body>
			<div class="cc-secCode-modal">
				<div class="modal-header">
					<div class="title-bar">
						<h2 class="title"><fmt:message key="checkout.securityCodeModal.title" /></h2>
					</div>
				</div>

				<div class="modal-body">
					<p><fmt:message key="checkout.securityCodeModal.intro" /></p>
					<div class="cc-example">
						<div class="image">
							<img src="${assetPath}/images/checkout/amex_cvv.jpg" alt="American Express Card"/>
						</div>
						<div class="description">
							<h5><fmt:message key="checkout.securityCodeModal.exampleOneTitle" /></h5>
							<p><fmt:message key="checkout.securityCodeModal.exampleOneDescription" /></p>
						</div>
					</div>
					<div class="cc-example">
						<div class="image">
							<img src="${assetPath}/images/checkout/cvv_creditCard_visa.jpg" alt="Master Card"/>
						</div>
						<div class="description">
							<h5><fmt:message key="checkout.securityCodeModal.exampleTwoTitle" /></h5>
							<p><fmt:message key="checkout.securityCodeModal.exampleTwoDescription" /></p>
						</div>
					</div>
				</div>
			</div>
		</jsp:body>
	</layout:ajax>
</dsp:page>