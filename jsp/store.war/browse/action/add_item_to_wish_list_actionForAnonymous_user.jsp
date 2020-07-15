<%@ page contentType="application/json" %>
<dsp:page>

	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
	<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
	<dsp:importbean bean="/com/lzb/droplet/LZBWishListContainDroplet" />
	<dsp:importbean bean="/atg/dynamo/droplet/Switch" />
	<dsp:importbean bean="/com/lzb/service/SessionBean"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ErrorMessageForEach"/>
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:getvalueof var="securityStatus" bean="Profile.securityStatus" /> 
	<dsp:getvalueof var="jsonString" bean="SessionBean.jsonStringForAjaxCall" /> 
	<dsp:importbean bean="/com/lzb/service/SessionBean" var="SessionBeanvar"/>
							
	<json:object prettyPrint="true">
		<c:choose>
		<c:when test="${securityStatus >3}">
		<json:property name="loginUser" value="${true}" />
		<dsp:droplet name="Switch">
			<dsp:param name="value" param="GiftlistFormHandler.formError"/>
			<dsp:oparam name="false">
			       	<dsp:droplet name="LZBWishListContainDroplet">
	    			 <dsp:param name="profile" bean="/atg/userprofiling/Profile" />
	    			  <dsp:param name="iteminfo" value="${jsonString}" />
						<dsp:oparam name="true">
							<json:property name="success" value="${true}" />
							<json:property name="successMessage" value="${SessionBeanvar.moveItemDisplayName} has been added to your Wishlist" />
							<dsp:getvalueof var="wishlistid" param="wishListId"/>
							<json:property name="giftItemId" value="${wishlistid}" />
							<json:property name="iteminGiftList" value="${true}" />
						</dsp:oparam>				
						<dsp:oparam name="false">
							<json:property name="success" value="${false}" />
							<json:array name="errors">
							<json:object>
								<json:property name="message">
									<dsp:valueof value="Item is not added in wishlist sucessfully" valueishtml="true"/>
								</json:property>
							</json:object>
							</json:array>
							<json:property name="iteminGiftList" value="${false}" />
						</dsp:oparam>
					</dsp:droplet>		
			</dsp:oparam>
		<dsp:oparam name="true">
				<json:property name="success" value="${false}" />
				<json:array name="errors">
					<dsp:droplet name="ErrorMessageForEach">
						<dsp:param name="exceptions" bean="GiftlistFormHandler.formExceptions"/>
						<dsp:oparam name="output">
							<json:object>
								<json:property name="message">
									<dsp:valueof param="message" valueishtml="true"/>
								</json:property>
							</json:object>
						</dsp:oparam>
					</dsp:droplet>
				</json:array>
			</dsp:oparam>
		</dsp:droplet>
			</c:when>
			<c:otherwise>
			<json:property name="loginUser" value="${false}"/>	
			<dsp:droplet name="Switch">
			<dsp:param name="value" param="ProfileFormHandler.formError"/>
			<dsp:oparam name="true">
				<json:property name="success" value="${false}" />
				<json:array name="errors">
					<dsp:droplet name="ErrorMessageForEach">
						<dsp:param name="exceptions" bean="ProfileFormHandler.formExceptions"/>
						<dsp:oparam name="output">
							<json:object>
								<json:property name="message">
									<dsp:valueof param="message" valueishtml="true"/>
								</json:property>
							</json:object>
						</dsp:oparam>
					</dsp:droplet>
				</json:array>
			</dsp:oparam>
			</dsp:droplet>
			</c:otherwise>		
		</c:choose>
</json:object>
</dsp:page>