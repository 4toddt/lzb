<%--
  This page renders customer details after login.
  Required parameters:
    None
  Optional parameters:
    None
--%>
<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contextPath" value="${originatingRequest.ContextPath}" />	
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:getvalueof var="transient" bean="Profile.transient" />
	<dsp:importbean bean="/com/lzb/planner/LZBPlannerIntegrationDroplet" />
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
	

	<script>

							var
							__vividloggedIn = true,
							__vividData = 

								
							<dsp:droplet name="LZBPlannerIntegrationDroplet">
							<dsp:param name="type" value="login"  />
		
								<dsp:oparam name="output">
   									<dsp:valueof param="jsonResponse" converter="valueishtml" />
								</dsp:oparam>

							</dsp:droplet>

                                                        window.parent.postMessage(JSON.stringify(__vividData),'https://lazboy-ip-eus-production.azurewebsites.net');

							console.log(__vividData);


						</script>

</dsp:page>
