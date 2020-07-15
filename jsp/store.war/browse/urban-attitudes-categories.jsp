<dsp:page>
	<dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler" />
	<fmt:message var="collectionName"
		key="urban.attitudes.category.collection" />
	<dsp:droplet name="InvokeAssembler">
		<dsp:param name="contentCollection" value="${collectionName}" />
		<dsp:param name="includePath" value="" />
		<dsp:oparam name="output">
			<dsp:getvalueof var="element"
				vartype="com.endeca.infront.assembler.ContentItem"
				param="contentItem" />
		</dsp:oparam>
		<dsp:oparam name="error">
		</dsp:oparam>
	</dsp:droplet>

	<c:if test="${not empty element}">
		<dsp:getvalueof var="contentItemList" value="${element.contents}" />
		<c:forEach items="${contentItemList}" var="contentItem">
			${contentItem.title}
			<p>${contentItem.content}</p>
			<c:if test="${not empty contentItem.subLinks}">
				<ul>
					<c:forEach var="link" items="${contentItem.subLinks}">
						<li><dsp:renderContentItem contentItem="${link}" /></li>
					</c:forEach>
				</ul>
			</c:if>
		</c:forEach>
	</c:if>
</dsp:page>