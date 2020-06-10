<%--
  - File Name: financialStackModal.jsp
  - Author(s): DMI UX Team
  - Copyright Notice:
  - Description: checkout financial stack modal content.
  - Required Parameters:
        - type: modal content type
  - Optional Parameters:
--%>
<layout:ajax>

	<jsp:attribute name="section">modal</jsp:attribute>
	<jsp:attribute name="pageType">financialStackModal</jsp:attribute>

	<jsp:body>
		<%-- Page Variables --%>
		<dsp:getvalueof var="type" param="type" />

		<div class="financial-stack-modal">
			<div class="modal-body">
				<c:choose>
					<c:when test="${type eq 'deposit'}">
						<p><fmt:message key="deposit.tooltip.title"/></p>
						<fmt:message key="deposit.tooltip.content"/>
					</c:when>
					<c:when test="${type eq 'balance'}">
						<p><fmt:message key="balance.tooltip.title"/></p>
						<fmt:message key="balance.tooltip.content"/>
					</c:when>
					<c:when test="${type eq 'recyclingFee'}">
						<p><fmt:message key="recyclingFee.tooltip.title"/></p>
						<fmt:message key="recyclingFee.tooltip.content"/>
					</c:when>
				</c:choose>
			</div>

		</div>
	</jsp:body>
</layout:ajax>
