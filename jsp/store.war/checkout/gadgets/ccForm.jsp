<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
    <dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty"/>
	<dsp:getvalueof var="index" param="index"/>

        <dsp:droplet name="ForEach">
        <dsp:param name="array" bean="PaymentGroupFormHandler.creditcardMethodsMap"/>
        <dsp:param name="elementName" value="ccType" />
        <dsp:param name="sortProperties" value="+_key"/>
        <dsp:oparam name="output">
           key=<dsp:valueof param="key"/>&nbsp;value=<dsp:valueof param="ccType"/><br/>
        </dsp:oparam>
        </dsp:droplet>		
</dsp:page>