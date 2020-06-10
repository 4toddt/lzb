<%--
    - File Name: productRatingsAndReviews.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page renders the detailed reviews tab for the given product param.
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
			<div id="TurnToReviewsContentContainer">
				<div id="tt-reviews-summary"></div>
				<div id="tt-reviews-list"></div>
			</div>
		</c:when>
		<c:otherwise>
			<%-- TurnTo not enabled.  No special treatment at this time.  --%>
		</c:otherwise>
	</c:choose>
</dsp:page>
