<%-- 
  This page renders login form for returned customers.
  Required parameters:
    None
  Optional parameters:
    None
--%>
<dsp:page>
<style type="text/css">
div.breadCrumb ul {
    display: inline-flex;
    list-style: none outside none;
}
<%--Testing purpose later need to delete this style --%>
.button_example{
border:1px solid #393B3E;-webkit-box-shadow: #737373 0px 1px 5px ;-moz-box-shadow: #737373 0px 1px 5px ; box-shadow: #737373 0px 1px 5px ; -webkit-border-radius: 23px; -moz-border-radius: 23px;border-radius: 23px;font-size:14px;font-family:arial, helvetica, sans-serif; padding: 10px 20px 10px 20px; text-decoration:none; display:inline-block;text-shadow: 0px 1px 0 rgba(10,10,10,0.5);font-weight:bold; color: #8C8C8C;
 background-color: #fcfac0; background-image: -webkit-gradient(linear, left top, left bottom, from(#fcfac0), to(#f6f283));
 background-image: -webkit-linear-gradient(top, #fcfac0, #f6f283);
 background-image: -moz-linear-gradient(top, #fcfac0, #f6f283);
 background-image: -ms-linear-gradient(top, #fcfac0, #f6f283);
 background-image: -o-linear-gradient(top, #fcfac0, #f6f283);
 background-image: linear-gradient(to bottom, #fcfac0, #f6f283);filter:progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr=#fcfac0, endColorstr=#f6f283);
}
</style>
  <dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
  <dsp:importbean bean="/atg/userprofiling/CookieManager"/>
  <dsp:importbean bean="/com/lzb/service/SessionBean"/>
  <dsp:importbean var="originatingRequest" bean="/OriginatingRequest"/>
  <dsp:getvalueof var="currentLocale" vartype="java.lang.String" bean="/atg/dynamo/servlet/RequestLocale.localeString"/>
  <dsp:getvalueof var="fromFb" param="fromFb"/>
  <dsp:getvalueof var="userID" param="userID"/>
  <dsp:getvalueof var="connectedToFaceBook" param="faceBookConnected"/>
    <dsp:getvalueof var="flow" param="flow"/>
   <dsp:layeredBundle basename="com.lzb.common.WebAppResources">
    <dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
    <dsp:getvalueof var="cotextPath" value="${originatingRequest.ContextPath}" />
 <%-- Form title --%>
 	<%-- JIRA DMI-1763 Hide Wishlist UI
    <c:choose>
	<c:when test="${flow eq 'wishlist'}">
		<c:set var="successUrl" value="${cotextPath}/account/wish_list_items.jsp" />
		<c:set var="errorUrl" value="${cotextPath}/cart/wishlistLogin.jsp" />
	</c:when>
		<c:otherwise>
    --%>
		<c:set var="successUrl" value="${cotextPath}/checkout/deliveryAndPayment.jsp" />
		<c:set var="errorUrl" value="${cotextPath}/checkout/checkout.jsp"/>
    <%-- JIRA DMI-1763 Hide Wishlist UI
		</c:otherwise>
	</c:choose>
    --%>
 
 	<c:if test="${not empty connectedToFaceBook}">
 		"Welcome, <dsp:valueof param="fbFirstName"/> <dsp:valueof param="fbLastName"/>" 
 	</c:if>
    <h2>
      Sign In to your La-Z-Boy Account
    </h2>               
        <dsp:getvalueof bean="ProfileFormHandler.formError" var="formError"/>
				<c:if test="${formError eq 'true'}">
					<dsp:include page="/includes/global/errors.jsp">
						<dsp:param name="formHandler" bean="ProfileFormHandler"/>
					</dsp:include>
				</c:if>
     
        <%--
          Check Profile's security status. If user is logged in from cookie,
          display default values, i.e. profile's email address in this case, otherwise 
          do not populate form handler with profile's values.
         --%>
  <table>
       <tr><td>
	<fieldset>
        <dsp:form action="#" method="post" id="loginForm" formid="loginForm" name="loginForm" autocomplete="false">
          <p class="required"><fmt:message key="form.required"/></p> 
        
                	 <fieldset>
				  	<div>
					  <label for="account_login"><fmt:message key="common.loginEmailAddress"/>: <span class="required">*</span></label>
					  <c:choose>
					  	<c:when test="${not empty cookie['rememberMe'].value}">
					  		<dsp:input type="text"  id="email" name="login_email_address" bean="ProfileFormHandler.value.login" value="${cookie['rememberMe'].value}" />
					  	</c:when>
					  	<c:otherwise>
					  		<dsp:input type="text"  id="email" name="login_email_address" bean="ProfileFormHandler.value.login" />
					  	</c:otherwise>
					  </c:choose>
					  
					  <span class="field_error"></span>
				  	</div>
				  </fieldset>
				    <fieldset>
				  	<div>
					  <label for="account_password"><fmt:message key="common.loginPassword"/>: <span class="required">*</span></label>
					  <dsp:input type="password"  name="login_password" id="password" bean="ProfileFormHandler.value.password" maxlength="25" value="" />
					  <span class="field_error"></span>
					 </div>
				  </fieldset>
				  <fieldset>
				  	<div>
				  <dsp:input type="checkbox" bean="ProfileFormHandler.value.rememberMe" checked="false"/>
					  	<label for="chk01" class="checkout checkout1"><fmt:message key="remember.me"/></label>     
									
                     	         	
          <%-- 'Login' button --%>
                <dsp:input type="submit" value="SIGN IN" iclass="btnRed" bean="ProfileFormHandler.login"/><br/>		
					 </div>
				  </fieldset>
			    <dsp:input type="hidden" bean="ProfileFormHandler.loginErrorURL" value="${errorUrl}" />
			    <dsp:input type="hidden" bean="ProfileFormHandler.loginSuccessURL" value="${successUrl}"/>
				<dsp:input type="hidden" bean="ProfileFormHandler.value.resetPwdUrl" value="${pageContext.request.contextPath}/account/resetPassword.jsp"/>
				<fieldset>
				  	<div>
				  	<dsp:a href="${pageContext.request.contextPath}/account/forgotPassword.jsp" title="" iclass="linkCancel push01 sign">	
				  	<fmt:message key="forgot.password"/>	
				  	</dsp:a> &nbsp;&nbsp;
				  	<c:if test="${flow eq 'wishlist'}">
				  	<span class="button_example"><a href="${pageContext.request.contextPath}/cart/register.jsp" title="" ">Create An Account</a></span>
				    </c:if>
				</div>
				  </fieldset>
			 </td>
				 <td> 
				<!-- For face book extension -->
		 	<c:if test="${ fromFb == 'true' }">
					<dsp:input type="hidden" bean="ProfileFormHandler.fromFb" value="${fromFb}" />
					<dsp:input type="hidden" bean="ProfileFormHandler.fbUserId" value="${userID}" />
				</c:if> 
				
			
        </dsp:form>
		</fieldset>
		</td>
		<td>
		<fieldset>
		<c:choose>
			<c:when test="${empty connectedToFaceBook}">
					<dsp:include src="${pageContext.request.contextPath}/account/fbConnect.jsp">
					<dsp:param name="pageName" value="checkout"/>
					</dsp:include>
			</c:when>
			<c:otherwise>
				<!-- no need to load FB -->
			</c:otherwise>
		</c:choose>
		
		</fieldset>
			</td></tr>
			<c:if test="${flow eq 'checkout'}">
			<tr><td colspan="2"><dsp:a href="${cotextPath}/checkout/deliveryAndPayment.jsp">
			 				<fmt:message key="checkout.checkoutguest"/>
			 		</dsp:a></td></tr>			 		
			 	</c:if>	
          </table>
        </dsp:layeredBundle>
    </dsp:page>
<%-- @version $Id: //hosting-blueprint/B2CBlueprint/version/10.2/Storefront/j2ee/store.war/myaccount/gadgets/login.jsp#2 $$Change: 788278 $--%>
