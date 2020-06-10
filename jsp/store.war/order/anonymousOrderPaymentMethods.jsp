<dsp:page>

	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:getvalueof var="paymentGroups" param="anonymousOrders.paymentGroups" />

	<main role="main">


		<section role="region" class="profile-account-content" data-module="profile-validate">
		<dsp:droplet name="ForEach">
			<dsp:param name="array" value="${paymentGroups}" />
			<dsp:param name="elementName" value="paymentGroup" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="pay" param="paymentGroup" />
				<dsp:getvalueof var="payGrpCount" param="count" />
				<dsp:getvalueof var="ccnum" param="paymentGroup.creditCardNumber" />
				<c:set var="cclength" value="${fn:length(ccnum)}" />
				<c:set var="cc" value="${fn:substring(ccnum,cclength-4, cclength)}" />
				<table>
					<tr>
						<td><dsp:valueof value="${pay.creditCardType}"/>&nbsp;${cc}
				     	</td>
						<td><c:choose>

								<c:when test="${payGrpCount eq 1}">
									<fmt:message key="anonymousOrder.deposit" />&nbsp;$<dsp:valueof
										value="${pay.depositAmount}" number="#.00" />
									<br />
									<fmt:message key="anonymousOrder.balance" />&nbsp;$<dsp:valueof
										value="${pay.balanceAmount}" number="#.00" />
									<br />
								</c:when>
								<c:when test="${payGrpCount eq 2}">
									<c:if test="${pay.lzbDebitType eq 'deposit'}">
										<fmt:message key="anonymousOrder.deposit" />&nbsp;$<dsp:valueof
											value="${pay.depositAmount}" number="#.00" />
										<br />
									</c:if>
									<c:if test="${pay.lzbDebitType eq 'balance'}">
										<fmt:message key="anonymousOrder.balance" />&nbsp;$<dsp:valueof
											value="${pay.balanceAmount}" number="#.00" />
										<br />
									</c:if>
								</c:when>
							</c:choose></td>
					</tr>
				</table>
			</dsp:oparam>
		</dsp:droplet>
		</section>
		</main>

</dsp:page>
