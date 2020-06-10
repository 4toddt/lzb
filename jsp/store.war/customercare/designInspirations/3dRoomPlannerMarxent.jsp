	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contextPath" value="${originatingRequest.ContextPath}" />	
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:getvalueof var="transient" bean="Profile.transient" />
	<dsp:importbean bean="/com/lzb/planner/LZBPlannerIntegrationDroplet" />
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
	<dsp:importbean var="storeConfig" bean="/atg/store/LZBStoreConfiguration"/>

	<dsp:getvalueof bean="ProfileFormHandler.formError" var="formError" />
	<dsp:getvalueof var="email" bean="Profile.login" />
	<dsp:getvalueof var="optIn" bean="ProfileFormHandler.optInEmail"/>
	
<dsp:page>
			<section role="region" class="cust-support three-dee" data-module="3d-marxent-planner" style="margin-top: -60px;">
			


				<h1>
				<script>
					var __plannerURLFromConfig='${storeConfig.roomPlannerURL}';
				</script>
				
				<c:choose> 

					<c:when test="${ transient eq 'false' }">

					<ul class="sign-in-help">
<%--						<li><a href="http://www.la-z-boy.com/content/roomplanner-3d-help" rel="open-window" data-module="open-window" data-props="'menubar=0,location=0,status=1,scrollbars=0,width=1000,height=600'" data-name="3D Room Planner Help" class="btn-secondary">Help</a></li> --%>
<%--						<li><a href="/productassets/pdf/3D_Planner_Help_Guide_small.pdf" target="_blank" class="btn-secondary">Help</a></li> --%>
					</ul>  
					<div>




						<dsp:form name="plannerlogin" method="post">
							<div>
								<dsp:input type="hidden" id="" bean="ProfileFormHandler.value.firstName" name="firstName" maxlength="20"></dsp:input>
								<dsp:input type="hidden" bean="ProfileFormHandler.value.lastName" name="lastName" maxlength="20"></dsp:input>
								<input type="hidden" value="${email}"/>
							</div>
						</dsp:form>






					</div>

					<fmt:message key="login.signInButton" var="signInButton"/>

						<script>
						   var
							__vividloggedIn = true,
							__vividData = <dsp:droplet name="LZBPlannerIntegrationDroplet">
							<dsp:param name="type" value="login"  />
		
								<dsp:oparam name="output">
   									<dsp:valueof param="jsonResponse" converter="valueishtml" />
								</dsp:oparam>

							</dsp:droplet>,
							__vividGallery = '';
							console.log(__vividData);
							console.log(__vividGallery);
						</script>

					</c:when>

					<c:otherwise>
					<ul class="sign-in-help">
<%--						<li data-module="cbox" data-className="sign-in-modal" data-transition="elastic" data-speed="500"><a href="/modals/signin.jsp" class="modal utility sign-in" data-module="modal-jquery-validation" data-form="signInForm">Sign in</a> </li> --%>
<%--						<li><a href="http://www.la-z-boy.com/content/roomplanner-3d-help" rel="open-window" data-module="open-window" data-props="'menubar=0,location=0,status=1,scrollbars=0,width=1000,height=600'" data-name="3D Room Planner Help" class="btn-secondary">Help</a></li> --%>
<%--						<li><a href="/productassets/pdf/3D_Planner_Help_Guide_small.pdf" target="_blank" class="btn-secondary">Help</a></li>   --%>
					</ul>

								<dsp:getvalueof var="currentStore" bean="Profile.currentStore"/>

						<script>
						    var 
							__vividloggedIn = false,
							__vividGallery = '';

						</script>

					</c:otherwise>
				</c:choose>
				</h1>

				<dsp:getvalueof bean="Profile.email" var="emailProfile"/>
				<dsp:getvalueof bean="Profile.firstName" var="firstNameProfile" />
				
				<dsp:droplet name="/com/lzb/marxent/droplet/MarxentTokenDroplet">
				<dsp:param name="userName" value="${firstNameProfile}" />
				<dsp:param name="email" value="${emailProfile}" />
				<dsp:oparam name="output">
					<dsp:getvalueof var="user_token" param="user_token"/>
					<iframe id="if3D" frameBorder="0" scrolling="no" src="" width="1200" height="800" class="full-width" data-url="${storeConfig.roomPlannerMarxentURL}/?token=${user_token}"></iframe>
				</dsp:oparam>
				<dsp:oparam name="empty">
						<iframe id="if3D" frameBorder="0" scrolling="no" src="" width="1200" height="800" class="full-width" data-url="${storeConfig.roomPlannerMarxentURL}"></iframe>
					</dsp:oparam>
					<dsp:oparam name="error">
						<div style="display: none" id="marxentError"></div>
					</dsp:oparam>
				</dsp:droplet>
<!-- 				<div id="iframeContainer"></div> -->

				<p class="disclaimer">Product image may differ from actual furniture item. La-Z-Boy products are hand crafted and variations from standard dimensions and appearance can occur. Construction differences in upholstery covering (cloth and leather) can cause variances in dimensions.</p>

			</section>

<%--		</main>
	</lzb:pageContainer> --%>
</dsp:page>