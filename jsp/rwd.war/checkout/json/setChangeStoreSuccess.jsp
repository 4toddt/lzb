<%@ include file="/sitewide/fragments/content-type-json.jspf" %>
<dsp:page>		
	<json:object>
		<json:property name="success">true</json:property>
		 
		<json:object name="content">
			<json:property name="shippingSummary" escapeXml="false">
				<dsp:include page="/checkout/includes/shippingAddressReview.jsp" />
			</json:property>
		</json:object>

	</json:object>
</dsp:page>