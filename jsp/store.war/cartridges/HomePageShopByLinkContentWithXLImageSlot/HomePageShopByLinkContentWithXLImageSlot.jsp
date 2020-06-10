<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />

	<dsp:getvalueof var="content"
		vartype="com.endeca.infront.assembler.ContentItem"
		value="${originatingRequest.contentItem}" />

	<c:set var="linkUrl" value="${contentItem.imageLink}" />

	<c:if test="${not empty linkUrl }">
		<dsp:droplet name="ActionURLDroplet">
			<dsp:param name="action" value="${linkUrl}" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="actionURLTitleLink" param="actionURL"/>
			</dsp:oparam>
			<dsp:oparam name="empty">
			</dsp:oparam>
		</dsp:droplet>
	</c:if>

<%-- 
rowSize: ${ contentItem.rowSize  }
title : ${ contentItem.title  }
imageURL : ${ contentItem.imageURL  }
imageLink : ${ contentItem.imageLink  } 
alt : ${ contentItem.alt  } 
--%>

<section class="homepage-secondary">
	<div class="primary-image">
		<%-- <h2></h2> --%>
		<a href="${ actionURLTitleLink}" aria-label="${ contentItem.title  }">
			<img src="${ contentItem.imageURL  }" title="${ contentItem.title  }" alt="${ contentItem.alt  }" />
		</a>
		<%-- <h3></h3> --%>
	</div><%-- .primary-image --%>


   <c:if test="${not empty contentItem }">
  		<c:choose>
				<c:when test="${contentItem.rowSize eq 3}">
						
				<c:if test="${not empty content.smallImageWithLinks}">
					<div class="row-3">
						<%--  =================== small images 1 ============= --%>
						<c:forEach items="${content.smallImageWithLinks}" var="element">
							<dsp:renderContentItem contentItem="${element}" >
								<dsp:param name="rowSize" value="${contentItem.rowSize}"/>
							</dsp:renderContentItem>
						</c:forEach>
					</div>
				</c:if>
								
				</c:when>
				<c:when test="${contentItem.rowSize eq 2}">
					<c:if test="${not empty content.smallImageWithLinks}">
						<div class="row-2">
						<%-- =================== small images 2 ============= --%>
							<c:forEach items="${content.smallImageWithLinks}" var="element">
								<dsp:renderContentItem contentItem="${element}" >
									<dsp:param name="rowSize" value="${contentItem.rowSize}"/>
								</dsp:renderContentItem>
							</c:forEach>
						</div>
					</c:if>
				</c:when>
			</c:choose>
 	 </c:if>
</section><%-- .homepage-secondary --%>
</dsp:page>