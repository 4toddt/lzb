<dsp:page>
<dsp:importbean bean="/com/lzb/userprofiling/LZBDealerProfileFormHandler"/>
<dsp:importbean bean="/atg/userprofiling/Profile"/>
<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
<dsp:getvalueof var="success" param="success"/>
<lzb:pageContainer>
<jsp:attribute name="title"><fmt:message key="dealertools.profile.title"/></jsp:attribute>
<jsp:attribute name="pageSpecificCSS"></jsp:attribute>
<jsp:attribute name="pageSpecificJS"></jsp:attribute>

<jsp:body>

<!-- <lzb:breadCrumb pageKey="breadcrumb.MyProfile" divClass="breadcrumb" separator="/"/> -->
<dsp:layeredBundle basename="com.lzb.common.WebAppResources">
		<h2> <fmt:message key="myProfile.myprofiletext"/> </h2>
		<dsp:getvalueof bean="LZBDealerProfileFormHandler.formError" var="formError"/>
			<c:if test="${ formError eq 'true'}">
				<div class="message-container">
				<div class="message-wrapper">
				<dsp:include page="/includes/global/errors.jsp">
					<dsp:param name="formHandler" bean="LZBDealerProfileFormHandler"/>
				</dsp:include>
				</div></div>
			</c:if>


			<c:if test="${success eq 'true'}">
				<h2 style="color:green"><fmt:message key="dealertools.profile.pwdupdate"/></h2>
			</c:if>

		<h3><fmt:message key="dealertools.common.lazboytext"/></h3>

		<strong><dsp:valueof bean="Profile.firstName" />&nbsp;<dsp:valueof bean="Profile.lastName"/></strong><br />
		<dsp:valueof bean="Profile.email" /> <br />
		<dsp:getvalueof bean="Profile.dealer" var="dealer"/>

			<c:if test="${not empty dealer}">
				<dsp:valueof bean="Profile.dealer.dealerName" /><br />
			</c:if>
			<strong><dsp:valueof bean="Profile.login" /></strong> <br />

		<dsp:droplet name="/atg/dynamo/droplet/ForEach">
			<dsp:param name="array" bean="Profile.roles" />
			<dsp:param name="elementName" value="roleItem" />
			<dsp:oparam name="output">
				<dsp:valueof param="roleItem.description"/>
			</dsp:oparam>
		</dsp:droplet><br />

		<c:if test="${not empty dealer}">
			<dsp:valueof bean="Profile.dealer.dealerCode" /><br />
		</c:if>

		<dsp:form name="dealerProfile" method="post" action="${pageContext.request.contextPath}/account/gadgets/dealerProfile.jsp" autocomplete="false">
			<h3><fmt:message key="dealertools.common.changepwd"/></h3>
			<label for="oldpassword"><h4><fmt:message key="myProfile.password"/>*</h4><span class="required"></span></label>
			<dsp:input type="password" bean="LZBDealerProfileFormHandler.value.oldPassword" name="oldPassword" id="old_password" value=""/><br/>

			<label for="new_password"><h4><fmt:message key="myProfile.newPassword"/>*</h4><span class="required"></span></label>
			<dsp:input type="password" name="newPassword" id="new_password" bean="LZBDealerProfileFormHandler.value.password" value=""/><br/>

			<label for="retype_password"><h4><fmt:message key="myProfile.reTypePassword"/>*</h4><span class="required"></span></label>
			<dsp:input type="password" id="retype_password" name="confirmPassword" bean="LZBDealerProfileFormHandler.value.confirmPassword" value=""/>

			<dsp:input type="hidden" bean="LZBDealerProfileFormHandler.changePasswordSuccessURL" value="${pageContext.request.contextPath}/account/gadgets/dealerProfile.jsp?success=true"/>
			<dsp:input type="hidden" bean="LZBDealerProfileFormHandler.changePasswordErrorURL" value="${pageContext.request.contextPath}/account/gadgets/dealerProfile.jsp?success=false"/>
			<dsp:a  bean="LZBDealerProfileFormHandler.cancel" href="${pageContext.request.contextPath}/account/gadgets/dealerProfile.jsp" value="Cancel">Cancel</dsp:a>&nbsp;
			<dsp:input type="submit" bean="LZBDealerProfileFormHandler.changePassword" value="Save Changes" id="changePassword" name="changePassword"/>
		</dsp:form>
	</dsp:layeredBundle>
</jsp:body>
</lzb:pageContainer>

</dsp:page>