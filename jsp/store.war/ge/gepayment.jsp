<dsp:page>
<dsp:importbean bean="/com/lzb/service/ge/Payment" />
<dsp:importbean bean="/com/lzb/service/ge/Configuration" />
<dsp:importbean bean="/com/lzb/service/SessionBean" />
Using this GE Configuration:<br/>
	<hr>
mCredentialUrl=<dsp:valueof bean="Configuration.credentialUrl"/><br/>
mCredentialPort=<dsp:valueof bean="Configuration.credentialPort"/><br/>
mCredentialRealm=<dsp:valueof bean="Configuration.credentialRealm"/><br/>
mMerchantUserId=<dsp:valueof bean="Configuration.merchantUserId"/><br/>
mMerchantPassword=<dsp:valueof bean="Configuration.merchantPassword"/><br/>
mPostMethodLoginUrl=<dsp:valueof bean="Configuration.postMethodLoginUrl"/><br/>
mPostMethodShoppingCartUrl=<dsp:valueof bean="Configuration.postMethodShoppingCartUrl"/><br/>
	<hr>
From Session:ShopperId=<dsp:valueof bean="SessionBean.gEShopperId"/><br/>
From Session:Token=<dsp:valueof bean="SessionBean.gEToken"/><br/>
        <dsp:droplet name="Payment">
        <dsp:oparam name="output">   
           request= <dsp:valueof param="request"/>      
           response= <dsp:valueof param="response" valueishtml="true"/>
        </dsp:oparam>
        <dsp:oparam name="error">
            request= <dsp:valueof param="request"/>
            error
        </dsp:oparam>
        </dsp:droplet>
</dsp:page>    
