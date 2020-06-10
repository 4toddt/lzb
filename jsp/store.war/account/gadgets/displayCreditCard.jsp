<%--
  This page is used to display the details of a credit card.
  These details include:-

    - The last 4 numbers of the credit card.
    - The credit card's billing address first name.
    - The credit card's billing address last name.
    - The credit card's expiration date.

  Required parameters:
    creditCard
       a creditCard repository item to display.

  Optional parameters:
    displayCardHolder
      flag indicating whether to display card holder name.
--%>
<dsp:page>
  <dsp:getvalueof var="displayCardHolder" param="displayCardHolder"/>
  <dsp:getvalueof var="creditCardType" param="creditCard.value.creditCardType"/>
  <dsp:getvalueof var="creditCard" param="creditCard.value.creditCardNumber" />
  <dsp:getvalueof var="count" param="count" />
  <dsp:getvalueof var="addr" param="creditCard.value.billingAddress"/>
		<dsp:getvalueof var="cctype"  param="creditCard.value.creditCardType"/>
		   <c:choose>
		   <c:when test="${cctype eq 'AmericanExpress'}">
		      American Express
		   </c:when>
           <c:when test="${cctype eq 'Visa'}">
		      Visa
		   </c:when>
		  <c:when test="${cctype eq 'MasterCard'}">
		      MasterCard
		   </c:when>
		   <c:when test="${cctype eq 'Discover'}">
		      Discover
		   </c:when>
		    <c:when test="${cctype eq 'LZB Card'}">
		      LZB Card
		    </c:when>
		   </c:choose>

		   	<span>
		   		<span class="ccMaskedNumber-${count}">
		   			<dsp:valueof  param="creditCard.value.creditCardNumber" converter="CreditCard" numcharsunmasked="4" /><br />
		   		</span>
		   		<input type="hidden" id="${count}" class="hdnCCMaskedNo" value='<dsp:valueof param="creditCard.value.creditCardNumber" converter="CreditCard" numcharsunmasked="4" />' />
		   	</span>
		    <span><dsp:valueof  param="creditCard.value.expirationMonth"/> /&nbsp;
		    	<dsp:valueof  param="creditCard.value.expirationYear"/></span>
			  <c:if test="${not empty displayCardHolder}">
		      	</span>${addr.firstName} &nbsp; ${addr.lastName}</span>
		  	  </c:if>
</dsp:page>
<%-- @version $Id: //hosting-blueprint/B2CBlueprint/version/10.2/Storefront/j2ee/store.war/global/util/displayCreditCard.jsp#2 $$Change: 788842 $--%>
