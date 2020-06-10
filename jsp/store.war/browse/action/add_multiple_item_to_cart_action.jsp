<%@ page contentType="application/json" %>
<dsp:page> 
	<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
	<dsp:importbean bean="/com/lzb/droplet/LZBWishListContainDroplet" />
	<dsp:importbean bean="/atg/dynamo/droplet/Switch" />
	<dsp:importbean bean="/atg/dynamo/droplet/ErrorMessageForEach"/>
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
	<dsp:param name="ajaxRequest" value="true"/>
	<dsp:setvalue bean="GiftlistFormHandler.formError" value="${false}"/>
	<dsp:setvalue bean="CartModifierFormHandler.addAllSelectedWishlistItemToOrder" value="true"/>
	<dsp:getvalueof var="allWishlistItemIdToAddOrder" param="allWishlistItemIdToAddOrder" />
	<json:object prettyPrint="true"> 
			<dsp:droplet name="Switch">
			<dsp:param name="value" bean="GiftlistFormHandler.formError" />
				<dsp:oparam name="false">
				<dsp:droplet name="LZBWishListContainDroplet">
	    			 <dsp:param name="profile" bean="/atg/userprofiling/Profile" />
	    			  <dsp:param name="wishlistItemIdToRemove" value="${allWishlistItemIdToAddOrder}" />
	    			   <dsp:param name="removeRequest" value="true" />
						<dsp:oparam name="true">
						<json:property name="success" value="${false}" />
							<dsp:getvalueof var="wishlistid" param="wishListId"/>
							<json:property name="giftItemId" value="${wishlistid}" />
							<json:property name="iteminGiftList" value="${true}" />
							<json:array name="errors">
							<json:object>
								<json:property name="message">
									<dsp:valueof value="Item is not Added to cart sucessfully" valueishtml="true"/>
								</json:property>
							</json:object>
							</json:array>
						</dsp:oparam>				
						<dsp:oparam name="false">
						<dsp:getvalueof var="removeItemIdSucessfully" param="removeItemIdSucessfully"/>
						<dsp:getvalueof var="removeItemFailureId" param="removeItemFailureId"/>
						<json:property name="success" value="${true}" />
							<json:property name="iteminGiftList" value="${false}" />
							<json:property name="addedItemIdSucessfully" value="${removeItemIdSucessfully}"/>
							<json:property name="failedItemIdSucessfully" value="${removeItemFailureId}"/>
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