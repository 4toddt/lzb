<dsp:page>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:getvalueof var="customerCare"value="${storeConfig.customerCare}"/>
	<li>

		<p class="title"><fmt:message key="customerCare.customerCareText"/></p>

		<ul>
			<li>
				<dsp:a href="${pageContext.request.contextPath}/content/CustomerCare">Customer Service</dsp:a>
			</li>
			<li>
				<dsp:a href="${pageContext.request.contextPath}/content/CustomerCare/contactus">Contact Us</dsp:a>
			</li>
			<li><dsp:a href="${pageContext.request.contextPath}/content/CustomerCare/FAQS"><fmt:message key="customerCare.faqsText"/></dsp:a></li>
		</ul>
		<p><strong><fmt:message key="customerCare.liveHelpText"/></strong></p>
		<a href="tel:<fmt:message key="customerCare.callNumber"/>"><fmt:message key="customerCare.callNumber"/></a>
	</li>
</dsp:page>