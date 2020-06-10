<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="dsp" uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_1" %>

<dsp:page>
	<dsp:importbean bean="/com/lzb/droplet/UmbracoContentDroplet" />
	<div>
		<dsp:droplet name="UmbracoContentDroplet">
			<dsp:param name="contentType" value="StoreHours" />
			<dsp:param name="dealerId" value="50860275" />			
			<dsp:oparam name="output">
				<dsp:getvalueof var="storeHours" vartype="String" param="response" />			
	
	          	<c:out value="${storeHours}" />	        
			</dsp:oparam>
			<dsp:oparam name="error">
				Error out <!-- Do something here -->        
			</dsp:oparam>
			<dsp:oparam name="empty">
				Empty empty <!-- Do something here -->        
			</dsp:oparam>
		</dsp:droplet>
	</div>
	
	<div>
		<dsp:droplet name="UmbracoContentDroplet">
			<dsp:param name="contentType" value="Banner" />
			<dsp:param name="bannerName" value="HomePage" />
			<dsp:param name="dealerId" value="50860275" />			
			<dsp:oparam name="output">
				<dsp:getvalueof var="imageUrl" vartype="String" param="response" />			
				<dsp:getvalueof var="bannerMap" vartype="String" param="bannerMap" />
	          	<a href="${bannerMap.bannerURL}">
			          			<img src="${bannerMap.bannerImage}" width="280" height="415"/>
			          		</a>
	          	<%-- <img src="${imageUrl}" width="280" height="415"/> --%>	        
			</dsp:oparam>
			<dsp:oparam name="error">
				Error out <!-- Do something here -->        
			</dsp:oparam>
			<dsp:oparam name="empty">
				Empty empty <!-- Do something here -->        
			</dsp:oparam>
		</dsp:droplet>
	</div>

	<div>
		<dsp:droplet name="UmbracoContentDroplet">
			<dsp:param name="contentType" value="LandingPage" />
			<dsp:param name="dealerId" value="50852752" />	
			<dsp:param name="contentPart" value="storeSite" />	
			<dsp:oparam name="output">
				<dsp:valueof param="response" valueishtml="true"/>
			</dsp:oparam>
			<dsp:oparam name="error">
				Error out <!-- Do something here -->        
			</dsp:oparam>
			<dsp:oparam name="empty">
				Empty empty <!-- Do something here -->        
			</dsp:oparam>
		</dsp:droplet>
	</div>	
	
	<div>
		<dsp:droplet name="UmbracoContentDroplet">
			<dsp:param name="contentType" value="LandingPage" />
			<dsp:param name="dealerId" value="23461047" />	
			<dsp:param name="contentPart" value="storeHours" />	
			<dsp:oparam name="output">
				<dsp:valueof param="response" valueishtml="true"/>
			</dsp:oparam>
			<dsp:oparam name="error">
				Error out <!-- Do something here -->        
			</dsp:oparam>
			<dsp:oparam name="empty">
				Empty empty <!-- Do something here -->        
			</dsp:oparam>
		</dsp:droplet>
	</div>	
</dsp:page>
