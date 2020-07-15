<%@ include file="/sitewide/fragments/content-type-json.jspf" %>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/com/lzb/order/LZBEstimatedDeliveryChargeFormHandler"/>
				
	<json:object>
		<json:property name="success">true</json:property>
		
		<%-- estimated shipping cost --%>
		<dsp:getvalueof var="formResponseMap" bean="LZBEstimatedDeliveryChargeFormHandler.formResponseMap" />
		<c:forEach var="responseProperties" items="${formResponseMap}">
			<json:property name="${responseProperties.key}" value="${responseProperties.value}" />
		</c:forEach>
		
		<%-- <json:array name="variantShippingMethods">
			<json:object>
				<json:property name="date">
					<dsp:valueof value="Wednesday Sept. 28"/>
				</json:property>
				<json:property name="price">
					<dsp:valueof value="$39.34"/>
				</json:property>
				<json:property name="type">
					<dsp:valueof value="One Day Shipping"/>
				</json:property>
			</json:object>
			<json:object>
				<json:property name="date">
					<dsp:valueof value="Friday, Sept. 30"/>
				</json:property>
				<json:property name="price">
					<dsp:valueof value="$15.96"/>
				</json:property>
				<json:property name="type">
					<dsp:valueof value="Two Day Shipping"/>
				</json:property>
			</json:object>
			<json:object>
				<json:property name="date">
					<dsp:valueof value="4-5 Business Days"/>
				</json:property>
				<json:property name="price">
					<dsp:valueof value="FREE"/>
				</json:property>
				<json:property name="type">
					<dsp:valueof value="Standard Shipping"/>
				</json:property>
			</json:object>
		</json:array> --%>
					
	</json:object>
</dsp:page>