<%--
	- File Name: socialShareModal.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This is a product social sharing modal.
	- Required Parameters:
	- Optional Parameters:
--%>

<dsp:page>
	<%-- Imports --%>

	<%-- Page Variables --%>

	<layout:ajax>
		<jsp:attribute name="section">modal</jsp:attribute>
		<jsp:attribute name="pageType">socialShareModal</jsp:attribute>

        <jsp:body>
			<div class="social-share-modal" role="dialog" id="social-share">
				<div class="modal-header">
					<div class="title-bar">
						<h2 class="title">
                            <fmt:message key="modal.heading.socialShare" />
						</h2>
					</div>
				</div>

				<div class="modal-body">
                    <ul>
                        <li>
                            <button class="button primary small social-share-button" data-service="facebook" title="Share Product By Facebook">
                                <span class="icon social-icon-square facebook-square"></span><span><fmt:message key="social.facebook" /></span>
                            </button>
                        </li>
                        <li>
                            <button class="button primary small social-share-button" data-url="https://www.pinterest.com/pin/create/button/" data-service="pinterest" title="Share Product By Pinterest">
                                <span class="icon social-icon-square pinterest-square"></span><span><fmt:message key="social.pinterest" /></span>
                            </button>
                        </li>
                        <li>
                            <button class="button primary small social-share-button" data-url="https://twitter.com/intent/tweet" data-service="twitter" title="Share Product By Twitter">
                                <span class="icon social-icon-square twitter-square"></span><span><fmt:message key="social.twitter" /></span>
                            </button>
                        </li>
                        <li>
                            <button class="button primary small social-share-button" data-url="/mobile/account/shareProductByEmail.jsp" data-service="email" title="Share Product By Email">
                                <span class="icon social-icon-square email-square"></span><span><fmt:message key="social.email" /></span>
                            </button>
                        </li>
                    </ul>
				</div>
				<div class="modal-footer hide">
      			</div>
			</div>
		</jsp:body>
	</layout:ajax>
</dsp:page>