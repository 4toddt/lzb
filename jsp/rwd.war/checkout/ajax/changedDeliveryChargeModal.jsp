<dsp:page>
<layout:ajax>

	<jsp:attribute name="section">modal</jsp:attribute>
	<jsp:attribute name="pageType">changedDeliveryChargeModal</jsp:attribute>

	<jsp:body>
		<div class="change-delivery-charge-modal">
			<div class="modal-header">
				<div class="title-bar">
					<h2 class="title"><fmt:message key="checkout.changedDeliveryChargeModal.title" /></h2>
				</div>
			</div>
			
			<div class="modal-body">
				<dsp:include src="/checkout/includes/changedDeliveryCharge.jsp">
					<dsp:param name="postalCode" param="postalCode" />
 				</dsp:include>
			</div>

		</div>
	</jsp:body>
</layout:ajax>
</dsp:page>