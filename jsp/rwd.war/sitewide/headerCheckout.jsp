<dsp:page>

	<%-- Imports --%>
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />

	<%-- Page Variables --%>
	<dsp:getvalueof id="requestURL" idtype="java.lang.String" bean="/OriginatingRequest.requestURI"/>

	<header class="checkout-header">
		<div class="logo-section">
			<a href="${contextLinkPath}/"><span class="icon icon-lzb-logo"><span class="path1"></span><span class="path2"></span></span><span class="sr-only">Click to return to home page</span></a>
		</div>
		<div class="header-help-section hide-for-medium">
			<a href="javascript:void(0)" class="header-help-link"><fmt:message key="header.help" /></a>
		</div>
		<div class="secure-transaction-section">
			<span class="icon icon-lock"></span><fmt:message key="checkout.secure.transaction" />
		</div>
	</header>
</dsp:page>
