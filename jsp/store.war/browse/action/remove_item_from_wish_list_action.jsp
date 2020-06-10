<%@ page contentType="application/json" %>
<dsp:page> 
<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
	<dsp:importbean bean="/com/lzb/droplet/LZBWishListContainDroplet" />
	<dsp:importbean bean="/atg/dynamo/droplet/Switch" />
	<dsp:importbean bean="/atg/dynamo/droplet/ErrorMessageForEach"/>
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
	<dsp:param name="ajaxRequest" value="true"/>
	
	<dsp:setvalue bean="GiftlistFormHandler.formError" value="${false}"/>
	<dsp:setvalue bean="GiftlistFormHandler.removeGiftlistItems" value="true"/>
	<json:object prettyPrint="true">
	<json:property name="loginUser" value="${true}" />
			<dsp:droplet name="Switch">
			<dsp:param name="value" bean="GiftlistFormHandler.formError" />
				<dsp:oparam name="false">
				<dsp:droplet name="LZBWishListContainDroplet">
	    			 <dsp:param name="profile" bean="/atg/userprofiling/Profile" />
	    			   <dsp:param name="removeRequest" value="true" />
		s				<dsp:oparam name="true">
						<json:property name="success" value="${false}" />
							<dsp:getvalueof var="wishlistid" param="wishListId"/>
							<json:property name="giftItemId" value="${wishlistid}" />
							<json:property name="iteminGiftList" value="${true}" />
							<json:array name="errors">
							<json:object>
								<json:property name="message">
									<dsp:valueof value="Item is not removed from wishlist sucessfully" valueishtml="true"/>
								</json:property>
							</json:object>
							</json:array>
						</dsp:oparam>				
						<dsp:oparam name="false">
							<dsp:getvalueof var="removeItemIdSucessfully" param="removeItemIdSucessfully"/>
						<json:property name="success" value="${true}" />
							<json:property name="iteminGiftList" value="${false}" />
							<json:property name="removeItemIdSucessfully" value="${removeItemIdSucessfully}"/>
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
	</json:object>
</dsp:page>