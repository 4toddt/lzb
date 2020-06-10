
<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/com/lzb/droplet/UmbracoContentDroplet" />
	<dsp:getvalueof var="dealerId" param="dealerId" />
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
    <dsp:getvalueof var="dealerCountry" bean="Profile.currentStore.country"/>

	<c:choose>
		<c:when test="${dealerCountry eq 'CA' && contentItem.hideForCanada eq true}" >
		</c:when>
		
		<c:otherwise>
	
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

	<li class="${variant} ${contentItem.hideInDefaultHeader eq true ? ' hide-for-default':''} ${contentItem.hideInStickyHeader eq true ? ' hide-for-sticky':''} ${contentItem.displayRightDivider eq true ? ' divider':''}">
	<c:choose>
		<c:when test="${empty contentItem.title2}">		
			<c:set var="title" value="${contentItem.title}" />
			<a href="${actionURLTitleLink}" class="${menuPointerClass}" aria-label="${title}">${title}</a>
		</c:when>
		<c:when test="${not empty contentItem.title2}">
			<c:set var="title" value="${contentItem.title}&nbsp;${contentItem.title2}" />
			<a href="${actionURLTitleLink}" class="${menuPointerClass} two-lines" aria-label="${title}">
				<span>${contentItem.title}</span><span>${contentItem.title2}</span>
			</a>
		</c:when>
	</c:choose>
	<c:if test="${not empty contentItem.rows}">
			<div class="mega-nav">
				<header>
					<div class="title">
				    <h3 class="${alignLeftClass}">${title}</h3>
				 		<c:if test="${actionURLTitleLink ne '#'}">
							<a href="${actionURLTitleLink}" aria-label="${title}"><fmt:message key="megaNav.viewAll"/><span class="sr-only">${title}</span><span class="icon-arrow-right"></span></a>
						</c:if>
					</div>
					<c:if test="${not empty contentItem.description}">
						<div class="description">
							<p>${contentItem.description}</p>
					 	</div>
					 </c:if>
				</header>
				<div class="content">

					<c:if test="${not empty contentItem.rows}">
                   		<c:forEach var="element" items="${contentItem.rows}">
                      		<dsp:renderContentItem contentItem="${element}" />
                   		</c:forEach>
                	</c:if>

				</div>

				<footer>
					<c:if test="${not empty contentItem.bottomPromo}">
			 			<dsp:renderContentItem contentItem="${contentItem.bottomPromo}"/>
					</c:if>
				</footer>
			</div>
		</c:if>
	</li>
	
	</c:otherwise>
	</c:choose>
	
</dsp:page>
