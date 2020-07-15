<dsp:page>
  <dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>
  <dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}"/>
   <c:if test="${not empty contentItem }">
   	
  		<c:choose>
				<c:when test="${contentItem.name eq 'HomePageMiddleCorporatePromoBanner'}">
				<section class="homepage-secondary full-width-targeter">
				<dsp:include src="/home/middleCorporatePromoTargeter.jsp"/>
		
				</c:when>
				<c:when test="${contentItem.name eq 'HomePageBottomPromoBanners'}">
				<section class="homepage-secondary">
					<div class="row-3">
						<dsp:include src="/home/bottomPromoTargeters.jsp"/>
					</div>
				</c:when>
		</c:choose>
	 </section>
 	 </c:if>
</dsp:page>