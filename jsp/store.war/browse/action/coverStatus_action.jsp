<%@ page contentType="application/json" %>
<dsp:page>
	<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
	<dsp:importbean bean="/com/lzb/droplet/LZBWishListContainDroplet" />
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:getvalueof var="securityStatus" bean="Profile.securityStatus" />
	<dsp:getvalueof var="coverId" param="coverId" />
	<json:object prettyPrint="true">
	<c:choose> 
		<c:when test="${securityStatus >1}">
		<json:property name="loginUser" value="${true}" />
		<dsp:droplet name="LZBWishListContainDroplet">
	    	<dsp:param name="configSkuId" value="${coverId}" />
			 <dsp:param name="saveCoverRequest" value="${true}" />
			 <dsp:param name="profile" bean="/atg/userprofiling/Profile" />
			 <dsp:oparam name="true">
				<dsp:getvalueof var="wishlistid" param="wishListId"/>
				<json:property name="favoriteStatus" value="${true}" />
				<json:property name="giftItemId" value="${wishlistid}" />
			</dsp:oparam>				
			<dsp:oparam name="false">
			<json:property name="favoriteStatus" value="${false}" />
			</dsp:oparam>
		</dsp:droplet>
		</c:when>
		<c:otherwise>
			<json:property name="loginUser" value="${false}"/>	
			<json:property name="favoriteStatus" value="${false}" />
		</c:otherwise>		
		</c:choose>
	</json:object>
</dsp:page>