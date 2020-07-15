<%--
  This gadget renders a price accordingly to the locale specified.

  Required parameters:
    price
      Price to be formatted.
--%>
<dsp:page>
	<dsp:importbean var="lpProfile"  bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/dynamo/droplet/CurrencyFormatter" />
	
  	<dsp:getvalueof var="price" vartype="java.lang.Double" param="price"/>
  	<dsp:getvalueof var="saveFormattedPrice" param="saveFormattedPrice"/>

  	<%-- Set locale as the "Default price list locale", if not specified --%>
  	<dsp:getvalueof var="locale" vartype="java.lang.String" param="priceListLocale"/>
  	<c:if test="${empty locale}">
    	<c:set var="locale" value="en_US"/>
  	</c:if>
  	

  	<%-- Format price --%>
  	<dsp:droplet name="CurrencyFormatter">
    <dsp:param name="currency" value="${price}"/>
    <dsp:param name="locale" value="${locale}"/>
    <dsp:oparam name="output">
		<c:choose>
        	<c:when test="${saveFormattedPrice}">
          		<dsp:getvalueof var="formattedPrice" scope="request" vartype="java.lang.String" param="formattedCurrency"/>
          		<c:if test="${empty formattedPrice}">
            		<c:set var="formattedPrice" scope="request" value="${price}"/>
          		</c:if>
        	</c:when>
        	<c:otherwise>
         		<dsp:valueof param="formattedCurrency">${price}</dsp:valueof>
        	</c:otherwise>
      	</c:choose>
	</dsp:oparam>
	</dsp:droplet>
</dsp:page>
