<%--
    - File Name: displayPrice.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: Renders a price display as formatted currency
    - Required Parameters:
    - Optional Parameters:
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/atg/dynamo/droplet/CurrencyConversionFormatter"/>

	<dsp:droplet name="CurrencyConversionFormatter">
       <dsp:param name="currency" param="currency"/>
       <dsp:param value="en_US" name="locale"/>
       <dsp:param value="en_US" name="targetLocale"/>
        <dsp:oparam name="output">
         	<dsp:valueof param="formattedCurrency" valueishtml="true">No Price</dsp:valueof>
        </dsp:oparam>
     </dsp:droplet>
</dsp:page>