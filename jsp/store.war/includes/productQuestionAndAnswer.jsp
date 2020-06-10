<%--
Renders the detailed Q&A tab for the given product param.
Parameters:
- product - the product repository item (object) being displayed
--%>
<dsp:page>
	<dsp:getvalueof var="turnToEnabled"	bean="/com/lzb/common/LZBTurnToConfiguration.turnToEnabled" />

	<c:choose>
		<c:when test="${turnToEnabled}">
			<div id="TurnToContent">
				<div id="tt-instant-answers-widget"></div>
				<div id="tt-qa-list"></div>
			</div>	
		</c:when>
		<c:otherwise>
			<%-- TurnTo not enabled.  No special treatment at this time.  --%>
		</c:otherwise>
	</c:choose>
</dsp:page>