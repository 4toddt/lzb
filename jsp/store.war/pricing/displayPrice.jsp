<dsp:importbean bean="/atg/dynamo/droplet/CurrencyConversionFormatter"/>

<dsp:page>
	<dsp:droplet name="CurrencyConversionFormatter">
       <dsp:param name="currency" param="currency"/>
       <dsp:param value="en_US" name="locale"/>
       <dsp:param value="en_US" name="targetLocale"/>
        <dsp:oparam name="output">
         	<dsp:valueof  param="formattedCurrency" valueishtml="true">No Price</dsp:valueof>
        </dsp:oparam>
     </dsp:droplet>
</dsp:page>