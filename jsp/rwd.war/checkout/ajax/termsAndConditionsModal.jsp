<%--
	- File Name: termsAndConditionsModal.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This modal displays information for terms and conditions.
	- Required Parameters:
	- Optional Parameters:
--%>
<dsp:page>
	<layout:ajax>

		<jsp:attribute name="section">modal</jsp:attribute>
		<jsp:attribute name="pageType">termsAndConditionsModal</jsp:attribute>

		<jsp:body>
			<div class="terms-and-conditions-modal">
				<div class="modal-header">
					<div class="title-bar">
						<h2 class="title"><fmt:message key="terms.title" /></h2>
					</div>
				</div>

				<div class="modal-body">
					<p><fmt:message key="terms.lastUpdated"/></p>
					<p><fmt:message key="terms.intro.body"/></p>
					<p><fmt:message key="terms.intro.body.second"/></p>
					<p><fmt:message key="terms.intro.body.third"/></p>
					
					<h3><fmt:message key="terms.returns.header"/></h3>
					
					<p><strong><fmt:message key="terms.returns.residential.furniture.header"/></strong></p>
					<p><fmt:message key="terms.returns.residential.furniture.body"/></p>
					<p><strong><fmt:message key="terms.returns.mattress.header"/></strong></p>
					<p><fmt:message key="terms.returns.mattress.body"/></p>
					<p><strong><fmt:message key="terms.returns.outdoor.furniture.header"/></strong></p>
					<p><fmt:message key="terms.returns.outdoor.furniture.body"/></p>
					<p><strong><fmt:message key="terms.returns.office.furniture.header"/></strong></p>
					<p><fmt:message key="terms.returns.office.furniture.body"/></p>
					<p><strong><fmt:message key="terms.returns.pet.beds.header"/></strong></p>
					<p><fmt:message key="terms.returns.pet.beds.body"/></p>
				
					<h3><fmt:message key="terms.privacy.header"/></h3>
					<c:choose>
						<c:when test="${isMobile}">
							<p><fmt:message key="terms.privacy.body.mobile"/></p>
						</c:when>
						<c:otherwise>
							<p><fmt:message key="terms.privacy.body.desktop"/></p>
						</c:otherwise>
					</c:choose>
					<p><fmt:message key="terms.privacy.body.second"/></p>

					<h3><fmt:message key="terms.sale.header"/></h3>
					<p><fmt:message key="terms.sale.body"/></p>

					<h3><fmt:message key="terms.copyright.header"/></h3>
					<p><fmt:message key="terms.copyright.body"/></p>

					<h3><fmt:message key="terms.trademarks.header"/></h3>
					<p><fmt:message key="terms.trademarks.body"/></p>

					<h3><fmt:message key="terms.acceptance.header"/></h3>
					<p><fmt:message key="terms.acceptance.body"/></p>

					<h3><fmt:message key="terms.onlineOrdersDeposits.header"/></h3>
					<p><fmt:message key="terms.onlineOrdersDeposits.body"/></p>
					<p><fmt:message key="terms.onlineOrdersDeposits.body.second"/></p>

					<h3><fmt:message key="terms.inspectionAcceptance.header"/></h3>
					<p><fmt:message key="terms.inspectionAcceptance.body"/></p>

					<h3><fmt:message key="terms.warranty.header"/></h3>
					<c:choose>
						<c:when test="${isMobile}">
							<p><fmt:message key="terms.warranty.body.mobile"/></p>
						</c:when>
						<c:otherwise>
							<p><fmt:message key="terms.warranty.body.desktop"/></p>
						</c:otherwise>
					</c:choose>
					<p><fmt:message key="terms.warranty.body.second"/></p>

					<h3><fmt:message key="terms.liability.header"/></h3>
					<p><fmt:message key="terms.liability.body"/></p>

					<h3><fmt:message key="terms.priceGuarantee.header"/></h3>
					<p><fmt:message key="terms.priceGuarantee.body"/></p>

					<h3><fmt:message key="terms.disputes.header"/></h3>
					<p><fmt:message key="terms.disputes.body"/></p>

					<h3><fmt:message key="terms.changes.header"/></h3>
					<p><fmt:message key="terms.changes.body"/></p>
					<p><fmt:message key="terms.changes.body.second"/></p>
				</div>
			</div>
		</jsp:body>
	</layout:ajax>
</dsp:page>