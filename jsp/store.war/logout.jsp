<dsp:page>
###${pageContext.request.contextPath}##
	<dsp:droplet name="/atg/dynamo/droplet/Redirect">
    	<dsp:param name="url" value="${pageContext.request.contextPath}/index.jsp"/>
  	</dsp:droplet>
</dsp:page>