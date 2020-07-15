<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/com/lzb/droplet/UmbracoContentDroplet" />
	<dsp:getvalueof var="dealerId" param="dealerId" />
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />

	<c:if test="${not empty contentItem.link }">
		<dsp:droplet name="ActionURLDroplet">
			<dsp:param name="action" value="${contentItem.link}" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="actionURLTitleLink" param="actionURL" />
			</dsp:oparam>
			<dsp:oparam name="empty">
			</dsp:oparam>
		</dsp:droplet>
	</c:if>

	<c:if test="${empty actionURLTitleLink}">
		<c:set var="actionURLTitleLink" value="#" />
	</c:if>
	<c:set var="noMegaMenuClass" value="" />
	<c:if test="${empty contentItem.rows}">
		<c:set var="noMegaMenuClass" value="no-menu" />
	</c:if>
    <li><a href="${actionURLTitleLink}" class="menu-pointer" tabindex="0" aria-label="${contentItem.title}">${contentItem.title}<span class="icon-arrow-down"></span></a>
	<c:if test="${not empty contentItem.rows}">
			<div class="mega-nav">
				<header>
					<div class="title">
				    <h3>${contentItem.title}</h3>
				 		<a href="${actionURLTitleLink}" aria-label="${contentItem.title}" tabindex="0"><fmt:message key="megaNav.viewAll"/><span class="sr-only">${contentItem.title}</span><span class="icon-arrow-right"></span></a>
					</div>
					<c:if test="${not empty contentItem.description}">
						<div class="description">
							<p>${contentItem.description}</p>
					 	</div>
					 </c:if>
				</header>
				<div class="content">
					<c:if test="${not empty contentItem.leftRail}">
			 			<dsp:renderContentItem contentItem="${contentItem.leftRail}"/>
					</c:if>
					<c:if test="${not empty contentItem.rows}">
                   		<c:forEach var="element" items="${contentItem.rows}">
                      		<dsp:renderContentItem contentItem="${element}" />
                   		</c:forEach>
                	</c:if>
				</div>
			</div>
		</c:if>
	</li>
</dsp:page>
