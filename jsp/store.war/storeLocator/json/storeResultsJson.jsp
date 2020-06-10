<%@ page contentType="application/json" %>

<dsp:importbean bean="/com/lzb/commerce/storeLocator/handler/LZBStoreLocatorFormHandler" />
<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />


<dsp:page>
	<json:object prettyPrint="true">
	   <json:array name="stores">
			<dsp:droplet name="ForEach">
			<dsp:param name="array" bean="LZBStoreLocatorFormHandler.storeList" />
			<dsp:param name="elementName" value="store"/>
				<dsp:oparam name="output">
				  <json:object>
				    <json:property name="chainNumber"><dsp:valueof param="store.chainNumber" valueishtml="true"/></json:property>
   				    <json:property name="businessTypeDesc"><dsp:valueof param="store.businessTypeDesc" valueishtml="true"/></json:property>
   				    <json:property name="businessType"><dsp:valueof param="store.businessType" valueishtml="true"/></json:property>
   				    <json:property name="slsmNumber"><dsp:valueof param="store.slsmNumber" valueishtml="true"/></json:property>
   				    <json:property name="parentDealerNumber"><dsp:valueof param="store.parentDealerNumber" valueishtml="true"/></json:property>
   				    <json:property name="dealerNumber"><dsp:valueof param="store.dealerNumber" valueishtml="true"/></json:property>
   				    <json:property name="designCenterAllowSwitch"><dsp:valueof param="store.designCenterAllowSwitch" valueishtml="true"/></json:property>
   				    <json:property name="latitude"><dsp:valueof param="store.latitude" valueishtml="true"/></json:property>
   				    <json:property name="longitude"><dsp:valueof param="store.longitude" valueishtml="true"/></json:property>
   				    <json:property name="address1"><dsp:valueof param="store.address1" valueishtml="true"/></json:property>
   				    <json:property name="address2"><dsp:valueof param="store.address2" valueishtml="true"/></json:property>
   				    <json:property name="address3"><dsp:valueof param="store.address3" valueishtml="true"/></json:property>
   				    <json:property name="city"><dsp:valueof param="store.city" valueishtml="true"/></json:property>
   				    <json:property name="stateAddress"><dsp:valueof param="store.stateAddress" valueishtml="true"/></json:property>
   				    <json:property name="postalCode"><dsp:valueof param="store.postalCode" valueishtml="true"/></json:property>
   				    <json:property name="country"><dsp:valueof param="store.country" valueishtml="true"/></json:property>
				  </json:object>
				</dsp:oparam>
			</dsp:droplet>
		</json:array>
	</json:object>
</dsp:page>