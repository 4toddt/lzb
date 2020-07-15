<%--
	- File Name: deactivateAccount_view.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This is remove the profile for My Account
	- Parameters:
	-
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	
	<%-- Page Variables --%>
	<dsp:getvalueof bean="ProfileFormHandler.formError" var="formError" />
	
	<section role="region" class="deactivate-account-content">
	
		<%-- <div class="section-title hide-for-small">
			<h1><fmt:message key="deactivate.title"/></h1>
		</div> --%>
		
		<fmt:message  var="reason" key="deactivate.reason"/>
		<div class="account-content standard-border" role="radiogroup" aria-labelledby="${reason}">
			<p><fmt:message key="deactivate.msg"/></p>
			<h2 id="${reason}"><fmt:message key="deactivate.reason"/></h2>
			
			<dsp:form action="#" method="post"  id="deactivateAccount" formid="deactivateAccount" name="deactivateAccount">
				<dsp:input type="hidden" value="yes" bean="ProfileFormHandler.deactivateMap.accountDeactivated"/>
				<div class="field-group custom-radio" role="radio" aria-checked="false" tabindex="0">
					<fmt:message  var="reason1" key="deactivate.emails"/>
					<dsp:input type="radio" bean="ProfileFormHandler.deactivateMap.reason" name="reason" value="${reason1}"/>
					<label for="reason">${reason1}</label>
				</div>
				<div class="field-group custom-radio" role="radio" aria-checked="false" tabindex="-1">
					<fmt:message  var="reason2" key="deactivate.products"/>
					<dsp:input type="radio" bean="ProfileFormHandler.deactivateMap.reason" name="reason" value="${reason2}"/>
					<label for="reason">${reason2}</label>
				</div>
				<div class="field-group custom-radio" role="radio" aria-checked="false" tabindex="-1">
					<fmt:message  var="reason3" key="deactivate.purchase"/>
					<dsp:input type="radio" bean="ProfileFormHandler.deactivateMap.reason" name="reason" value="${reason3}"/>
					<label for="reason">${reason3}</label>
				</div>
				<div class="field-group custom-radio" role="radio" aria-checked="false" tabindex="-1">
					<fmt:message  var="others" key="deactivate.others"/>
					<dsp:input type="radio" bean="ProfileFormHandler.deactivateMap.reason" name="reason" value="${others}"/>
					<label for="reason">${others}</label>
				</div>
				
				<div class="field-group text-area">
		   	  	   <p><fmt:message key="deactivate.reasonBrief"/></p>
				   <dsp:textarea type="text"  rows="15" cols="45" bean="ProfileFormHandler.deactivateMap.description"/>
		   	   </div>
				
			   	<dsp:input type="hidden"  bean="ProfileFormHandler.dactivateErrorURL" value="${contextPath}/account/json/profileError.jsp"/>
			   	<dsp:input type="hidden"  bean="ProfileFormHandler.deactivateSuccessURL" value="${contextPath}/account/json/deactivateAccountSuccess.jsp"/>		
			   	
			   	<dsp:a href="${contextPath}/account/profile.jsp" class="button secondary" title="Cancel"><fmt:message key="profile.cancel"/></dsp:a>					
			   	<dsp:input type="submit" class="button primary" bean="ProfileFormHandler.dectivateAccount" value="Confirm"/>
			   	
			</dsp:form>
		</div>
		
	</section>
</dsp:page>