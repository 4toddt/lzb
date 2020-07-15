<%--
    - File Name: productQuestionAndAnswer.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page renders the detailed Q&A tab for the given product param.
    - Required Parameters:
		- TurnToProductSku: the turnTo product record id
    - Optional Parameters:
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />

	<%-- Page Variables --%>
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