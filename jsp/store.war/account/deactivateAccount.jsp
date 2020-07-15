<dsp:page>
	<lzb:pageContainer>
		<jsp:attribute name="bodyClass">npc</jsp:attribute>

		<lzb:breadCrumb pageKey="breadcrumb.profile" divClass="breadcrumb" />
		<c:if test="${formError eq 'true'}">
			<div class="message-container">
				<div class="message-wrapper">
				<dsp:include page="/global/errors.jsp">
					<dsp:param name="formHandler" bean="ProfileFormHandler" />
				</dsp:include>
			</div></div>
		</c:if>
		<main role="main"> <dsp:include
			page="/includes/leftnavigation.jsp" />

		<section role="region" class="my-account-content">
			<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
			<dsp:importbean bean="/atg/userprofiling/Profile" />
			<dsp:getvalueof var="success" param="success" />
			<c:if test="${success eq 'true' }">
				<h1>
					Your account is successfully deactivated<br> ,to reactivate
					your account<br> please contact customer care service by<br>
					calling 1-800-375-6890 or email us.
				</h1>
			</c:if>
			<dsp:getvalueof bean="ProfileFormHandler.formError" var="formError" />


			<h3>Deactivate Account ?</h3>
			<%--<fmt:message key="profile.deactivateMsg" /> --%>
			<p>
				Keeping your account active allows you to access your Wishlist,
				maintain your address list, save<br> you time on your next
				purchase and keep you up-to-date on promotions and offers.<br>
				Once you deactivate, you will not be able to access any of the
				account information you have<br> saved. If you wish to make a
				purchase again in the future, you will have the option of creating a<br>
				new account.<br>Still want to delete your account? Let us know
				why.
			</p>
			<br>

			<dsp:form action="#" method="post" name="deactivateAccount">
				<dsp:input type="hidden" value="yes"
					bean="ProfileFormHandler.deactivateMap.accountDeactivated" />
				<%--<fmt:message key="profile.deactivateReason" /> --%>
		         Reason for Leaving
		         <div>
			         <dsp:select bean="ProfileFormHandler.deactivateMap.reason"
						name="reason">
						<dsp:option selected="selected">Please select</dsp:option>
						<dsp:option value="Too Many Emails">Too Many Emails</dsp:option>
						<dsp:option value="Not happy with products or service">Not happy with products or service</dsp:option>
						<dsp:option value="Not planning to purchase from La-Z-Boy">Not planning to purchase from La-Z-Boy</dsp:option>
						<dsp:option value="Other (displays a free form filed)">Other (displays a free form filed)</dsp:option>
					</dsp:select>
				</div>
				<br>
				<br>

				<dsp:textarea type="text" rows="15" cols="45"
					bean="ProfileFormHandler.deactivateMap.description" />
				<br>
				<br>

				<dsp:input type="hidden"
					bean="ProfileFormHandler.deactivateSuccessURL"
					value="/" />
				<dsp:input type="hidden"
					bean="ProfileFormHandler.deactivateErrorURL"
					value="deactivateAccount.jsp?success=false" />
				<dsp:a href="${pageContext.request.contextPath}/account/profile.jsp"> Cancel </dsp:a>&nbsp;
				<dsp:input type="submit" bean="ProfileFormHandler.dectivateAccount" iclass="btn-primary"
					value="Confirm" />
			</dsp:form>
		</section>
		</main>

	</lzb:pageContainer>

</dsp:page>
