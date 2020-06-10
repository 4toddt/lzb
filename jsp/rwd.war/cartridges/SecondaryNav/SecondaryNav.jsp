
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
		<c:set var="alignLeftClass" value="align-left" />
	</c:if>
	<c:set var="variant" value="" />
	<c:if test="${contentItem.title eq 'On Sale' or contentItem.title eq 'Sale'}">
		<c:set var="variant" value="mega-variant-sale" />
	</c:if>
	<c:set var="menuPointerClass" value="" />
	<c:if test="${not empty contentItem.rows}">
		<c:set var="menuPointerClass" value="menu-pointer" />
	</c:if>

	<c:choose>
		<c:when test="${headerType eq 'mobile'}">
			<li class="${variant} ${contentItem.hideInDefaultHeader eq true ? ' hide-for-default':''} ${contentItem.hideInStickyHeader eq true ? ' hide-for-sticky':''} ${contentItem.displayRightDivider eq true ? ' divider':''}">
			<c:choose>
				<c:when test="${empty contentItem.title2}">
					<c:set scope="request" var="contentItemTitle" value="${contentItem.title}" />
					<a href="${actionURLTitleLink}" class="secondary-link ${menuPointerClass}" aria-label="${contentItemTitle}">${contentItemTitle}
						<span class="icon icon-arrow-right" aria-hidden="true"></span>
					</a>
				</c:when>
				<c:when test="${not empty contentItem.title2}">
					<c:set scope="request" var="contentItemTitle" value="${contentItem.title}&nbsp;${contentItem.title2}" />
					<a href="${actionURLTitleLink}" class="secondary-link ${menuPointerClass} two-lines" aria-label="${contentItemTitle}">
						<span>${contentItem.title}</span><span> ${contentItem.title2}</span>
						<span class="icon icon-arrow-right" aria-hidden="true"></span>
					</a>
				</c:when>
			</c:choose>
			<c:if test="${not empty contentItem.rows}">
				<ul id="${fn:toLowerCase(fn:replace(contentItem.title, ' ', '-'))}" class="submenu secondary-submenu">
					<c:if test="${not empty contentItem.rows}">
						<c:forEach var="element" items="${contentItem.rows}">
							<dsp:renderContentItem contentItem="${element}" />
						</c:forEach>
					</c:if>
					<c:if test="${not empty contentItem.bottomPromo}">
						<li class="bottomPromo link-group">
							<dsp:renderContentItem contentItem="${contentItem.bottomPromo}"/>
						</li>
					</c:if>
				</ul>
			</c:if>
			</li>
		</c:when>
		<c:otherwise>
			<c:set var="noMegaMenuClass" value="" />
			<c:if test="${empty contentItem.rows}">
				<c:set var="noMegaMenuClass" value="no-menu" />
			</c:if>
		    <li class="primary-nav-item js-primary-nav-item"><a href="${actionURLTitleLink}" class="menu-pointer primary-nav-button js-primary-nav-button" tabindex="0" aria-label="${contentItem.title}">${contentItem.title}<span class="icon-arrow-down"></span></a>
			<c:if test="${not empty contentItem.rows}">
					<div class="mega-nav primary-nav-menu js-primary-nav-menu">
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
									<ul class="row col-3">
		                      			<dsp:renderContentItem contentItem="${element}" />
									</ul>
		                   		</c:forEach>
		                	</c:if>
						</div>
					</div>
				</c:if>
			</li>
		</c:otherwise>
	</c:choose>
</dsp:page>
