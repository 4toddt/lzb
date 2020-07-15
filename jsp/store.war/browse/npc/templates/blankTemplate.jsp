<dsp:page>
<dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler"/>
	<dsp:getvalueof var="templateItem" param="templateItem" />
	<dsp:getvalueof var="pageItem" param="page" />
	  <c:choose>
        <c:when test="${pageItem.seoName eq 'RoomInspirations'}">
		 <dsp:droplet name="InvokeAssembler">
                 <dsp:param name="includePath" value="/content/Shared/Static/RoomInspirations"/>
                        <dsp:oparam name="output">
                                    <dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" param="contentItem"/>
                        </dsp:oparam>
            </dsp:droplet>
            
            <c:choose>
                        <c:when test="${not empty contentItem}">
                                    <dsp:renderContentItem contentItem="${contentItem}" />
                        </c:when>
                        <c:otherwise>
                                    <b>Content Empty</b>
                        </c:otherwise>
            </c:choose>
	</c:when>
	<c:otherwise>
	
	<section role="region" class="cust-support" data-template-name="blank">	
		<dsp:include page="/browse/npc/pageTitle.jsp">
			<dsp:param name="pageTitle" value="${pageItem.name}"  />
		</dsp:include>			
		<div class="cust-contant"><dsp:valueof value="${templateItem.content}" valueishtml="true"/></div>
	</section>
	</c:otherwise>
	</c:choose>
</dsp:page>