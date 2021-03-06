<%--
	- File Name: removeWishListItemError.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: Displays remove from wish list error messages (json format).
	- Parameters:
	-
	--%>
<%@ include file="/sitewide/fragments/content-type-json.jspf" %>
<dsp:page>

	<%-- Imports --%>
	<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler"/>
	<dsp:param name="formhandler" bean="GiftlistFormHandler" />

	<json:object>
		<%@ include file="/account/includes/errors/jsonErrors.jspf" %>
	</json:object>

</dsp:page>
