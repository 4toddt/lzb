<dsp:page>
<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
<dsp:getvalueof value="${content.wrapContainer}" var="wrapContainer" />	

<c:if test="${wrapContainer eq 'true'}"> 

<div class="main-targeter-container">

</c:if>

<c:forEach var="element" items="${content.targeter}">
	<dsp:renderContentItem contentItem="${element}" />
</c:forEach>

<c:if test="${wrapContainer eq 'true'}">

</div>
</c:if>
</dsp:page>
