<dsp:page>
        <h3 class="help-header"><fmt:message key="cart.help.header" /></h3>
        <div class="help-phone-container">
            <span class="help-phone-text"><fmt:message key="cart.help.phone.text" /></span>
            <span class="help-phone-number"><a class="<c:if test='${not isMobile}'>disabled</c:if>" href="tel:<fmt:message key="cart.help.phone.number" />"><fmt:message key="cart.help.phone.number" /></a></span>
        </div>

        <c:set var="contactUsPageUrl" value="${contextLinkPath}/content/CustomerCare/contactus" />

        <a href="${contactUsPageUrl}" class="button tertiary help-email-button" target="_blank"><fmt:message key="cart.help.emailButton.text" /></a>
</dsp:page>