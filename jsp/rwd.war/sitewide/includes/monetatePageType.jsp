<dsp:page>
	<dsp:getvalueof var="pageTypeVar" param="pageType" />
	<c:if test="${(not empty pageTypeVar)}">
	<script>
	<%-- Set page type for monetate --%>
		window.monetateQ.push(["setPageType", "${pageTypeVar}"]);		
	</script>
	</c:if>	
</dsp:page>