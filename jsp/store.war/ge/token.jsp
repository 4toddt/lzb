<dsp:page>
<dsp:importbean bean="/com/lzb/service/ge/GetToken" />
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

        <dsp:droplet name="GetToken">
        <dsp:oparam name="output">
        output
        </dsp:oparam>
        <dsp:oparam name="error">
        error
        </dsp:oparam>
        </dsp:droplet>

        
</dsp:page>
~              