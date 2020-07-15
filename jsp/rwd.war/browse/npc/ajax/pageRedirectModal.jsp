<%--
	- File Name: pageRedirectModal.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This is confirmation modal when a user click on link for all static pages.
	- Required Parameters: redirectURL
	- Optional Parameters:
--%>

<dsp:page>
	<%-- Imports --%>

	<%-- Page Variables --%>
	<dsp:getvalueof var="redirectURL" param="redirectURL" />

	<layout:ajax>
		<jsp:attribute name="section">modal</jsp:attribute>
		<jsp:attribute name="pageType">pageRedirectModal</jsp:attribute>

		<jsp:body>
			<div class="page-redirect-modal">
				<p><fmt:message key="staticPage.pageRedirect.msg"/></p>
				<p><a href="${redirectURL}" class="orange-button"><fmt:message key="staticPage.pageRedirect.yes"/></a> 
					<a class="orange-button"><fmt:message key="staticPage.pageRedirect.no"/></a>
				</p>
			</div>
		</jsp:body>
	</layout:ajax>
</dsp:page>