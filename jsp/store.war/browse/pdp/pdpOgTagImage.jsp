<dsp:page>
<c:if test="${additionalImage ne null and not empty additionalImage and additionalImage.size() > 0  }">
	<c:set var="imageForOGTag" value="${additionalImage[0]}"/>
	<c:if test="${ additionalImage.size() > 1  }">
		<c:set var="imageForOGTag" value="${additionalImage[1]}"/>
	</c:if>

		<c:choose>
			<c:when test ="${ not fn:startsWith(imageForOGTag.largeImage, 'http') }" >
				<c:set var="largeImageURLForOGTag" value="http:${imageForOGTag.largeImage}"  scope="request"/>
			</c:when>
			<c:otherwise>
			 	<c:set var="largeImageURLForOGTag" value="${imageForOGTag.largeImage}"  scope="request"/>
			 </c:otherwise>
		</c:choose>
	   
</c:if>
 </dsp:page>