<dsp:page>
    <dsp:getvalueof var="templateItem" param="templateItem" />
    <dsp:getvalueof var="pageItem" param="page" />

    <section role="region" class="cust-support" data-template-name="fullBlank">
       <dsp:include page="/browse/npc/pageTitle.jsp">
           <dsp:param name="pageTitle" value="${pageItem.name}"  />
       </dsp:include>	
       <dsp:valueof value="${templateItem.content}" valueishtml="true"/>
		 
       <c:choose>
        <c:when test="${pageItem.seoName eq 'delivery-options'}">
			 <dsp:include src="/global/includes/selectedStoreDetails.jsp" />
	     </c:when>
	   </c:choose>
		 
	</section>
</dsp:page>