<dsp:page>
  <dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>
  <dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler" />
  <dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}"/>

  <%--<endeca:includeSlot contentItem="${contentItem}">--%>
  <%--  <c:if test="${not empty contentItem.contents }">
    <c:forEach var="element" items="${contentItem.contents}">
      <dsp:renderContentItem contentItem="${element}"/>
    </c:forEach>
   </c:if> --%>
   
   <dsp:droplet name="InvokeAssembler">
	<dsp:param name="contentCollection" value="/content/Shared/Guided Navigation" />
	<dsp:param name="includePath" value="" />
	<dsp:oparam name="output">
		<dsp:getvalueof var="element" vartype="com.endeca.infront.assembler.ContentItem" param="contentItem" />
		<dsp:renderContentItem contentItem="${element}" />
	</dsp:oparam>
	<dsp:oparam name="error">
	</dsp:oparam>
</dsp:droplet>
  <%--</endeca:includeSlot>--%>

</dsp:page>