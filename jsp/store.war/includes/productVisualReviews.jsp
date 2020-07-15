<%--
Renders the detailed reviews tab for the given product param.
Parameters:
- product - the product repository item (object) being displayed
--%>

<dsp:page>
	<dsp:getvalueof var="turnToEnabled" bean="/com/lzb/common/LZBTurnToConfiguration.turnToEnabled" />

	<c:choose>
		<c:when test="${turnToEnabled}">
			<div id="TurnToGalleryContent"></div>
		</c:when>
		<c:otherwise>
			<%-- TurnTo not enabled.  No special treatment at this time.  --%>
		</c:otherwise>
	</c:choose>
</dsp:page>
