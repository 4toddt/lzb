<%--
	- File Name: wishListError.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: Displays add to wish list error messages (json format).
	- Parameters:
	-
	--%>
<%@ include file="/sitewide/fragments/content-type-json.jspf" %>
<dsp:page>

	<%-- Imports --%>
	<dsp:importbean	bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
	<dsp:param name="formhandler" bean="CartModifierFormHandler" />

	<json:object>
		<%@ include file="/account/includes/errors/jsonErrors.jspf" %>
	</json:object>

</dsp:page>
