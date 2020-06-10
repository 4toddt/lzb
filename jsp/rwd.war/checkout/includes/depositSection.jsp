<dsp:page>
	<dsp:importbean bean="/com/lzb/droplet/LZBCalcOrderDepositBalanceAmountDroplet" />
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	
	<dsp:droplet name="LZBCalcOrderDepositBalanceAmountDroplet">
	<dsp:param name="order" bean="ShoppingCart.current"/>
	<dsp:param name="deliveryAmount" param="deliveryCost"/>
	<dsp:param name="taxAmount" param="taxCost"/>
	<dsp:oparam name="output">
		<dsp:getvalueof var="depositAmount" param="depositAmount"/>
		<dsp:getvalueof var="balanceAmount" param="balanceAmount"/>
	</dsp:oparam>
	</dsp:droplet>
	
	<fmt:message var="depositTooltipTitle" key="deposit.tooltip.title"/>
	<fmt:message var="balanceTooltipTitle" key="balance.tooltip.title"/>
	<fmt:message var="depositTooltipContent" key="deposit.tooltip.content"/>
	<fmt:message var="balanceTooltipContent" key="balance.tooltip.content"/>
		
	<div class="deposit-section">
		<div class="label">
			<span data-tooltip class="has-tip tip-left radius icon icon-info" title="<p>${depositTooltipTitle}</p>${depositTooltipContent}"><span class="sr-only">${depositTooltipTitle}. ${depositTooltipContent}</span></span>
			<fmt:message key="financialstack.label.deposit"/>
		</div>
		<div class="deposit-amount">
			<span class="amount"><dsp:valueof value="${depositAmount}" converter="currency" /></span>
			<a href="${contextPath}/checkout/ajax/financialStackModal.jsp?type=deposit" class="modal-trigger" data-dismiss="modal" data-target="financial-stack-modal" tabindex="0" aria-label="Click to open details about Deposit and Balance"><span class="icon icon-info"></span></a>
		</div>
		<div class="label">
			<span data-tooltip class="has-tip tip-left radius icon icon-info" title="<p>${balanceTooltipTitle}</p>${balanceTooltipContent}"><span class="sr-only">${balanceTooltipTitle}. ${balanceTooltipContent}</span></span>
			<fmt:message key="financialstack.label.balance"/>
		</div>
		<div class="balance-amount">
			<span class="amount"><dsp:valueof value="${balanceAmount}" converter="currency" /></span>
			<a href="${contextPath}/checkout/ajax/financialStackModal.jsp?type=balance" class="modal-trigger" data-dismiss="modal" data-target="financial-stack-modal" tabindex="0" aria-label="Click to open details about Deposit and Balance"><span class="icon icon-info"></span></a>
		</div>
	</div>
	 	
	<div class="modal" id="deposit-modal" tabindex="-1" role="dialog" aria-labelledby="deposit-modal-label" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content" id="modal-content"></div>
		</div>
	</div>
	
</dsp:page>