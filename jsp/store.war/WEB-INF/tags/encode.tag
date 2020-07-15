<%@ include file="/global/includes/taglibs.jspf" %>
<%@ tag language="java" %>
<%@ attribute name="value" %>
<dsp:getvalueof id="decodedString" value="${value}" idtype="java.lang.String">
	<%
		String encodedString = "";
		try {encodedString = java.net.URLEncoder.encode(decodedString.toString(), "UTF-8");}
		catch (Exception e) {}
	%>
	<%= encodedString %>
</dsp:getvalueof>
