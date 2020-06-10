
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/userprofiling/Profile" /> 
	<dsp:getvalueof var="transient" bean="Profile.transient" />
	<dsp:importbean bean="/com/lzb/planner/LZBPlannerIntegrationDroplet" />
	<dsp:page>
<html>
<head id="ctl00_Head1"><title>
	La-Z-Boy 3D Room Planner - Official La-Z-Boy Website
</title>

	<%-- for login http://192.168.164.162:11000/account/gadgets/3DPlannerTest.jsp?type=login
	for currentGalary http://192.168.164.162:11000/account/gadgets/3DPlannerTest.jsp?type=currentgallery&storeId=50859676
	 --%>
	<dsp:getvalueof var="currentStore" bean="Profile.currentStore"/>
			<c:choose>
					<c:when test="${ transient eq 'false' }">
					<dsp:droplet name="LZBPlannerIntegrationDroplet">
					<dsp:param name="type" param="type"  />
					<dsp:param name="storeId" value="${currentStore.repositoryId}"/>
					<dsp:param name="ip" param="ip"/>
					<dsp:param name="latitude" param="latitude"/>
					<dsp:param name="longitude" param="longitude"/>
	
	
					<dsp:oparam name="output">
   						<dsp:valueof param="jsonResponse" />
					</dsp:oparam>
					</dsp:droplet>
					</c:when>						
					<c:otherwise>
						<%-- <span data-module="fb-connect"></span>--%>
						<li data-module="cbox" data-className="sign-in-modal" data-transition="elastic" data-speed="500">
	                       <a href="/modals/signin.jsp" class="modal utility sign-in" data-module="modal-jquery-validation" data-form="signInForm">Sign in</a>
	                       <span class="utility">/</span>
	                       <a href="/modals/create-account.jsp" class="modal utility sign-in">Create Account</a>
	                    </li>
					</c:otherwise>
			</c:choose>
			
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<body>

<div id="iframeContainer">
</div>
<div style="position:relative; top: -10px; padding-left: 1em;" class="disclaimer">Product image may differ from actual furniture item. La-Z-Boy products are hand crafted and variations from standard dimensions and appearance can occur. Construction differences in upholstery covering (cloth and leather) can cause variances in dimensions.</div>


<script type="text/javascript">

	var axel = Math.random() + "";
	var a = axel * 10000000000000;
	var plannerUrl = 'http://lazboy-ip-eus-test.azurewebsites.net';
	var queryString = '';
	
	if (queryString.length > 0)
		queryString += "&rand=" + a;
	else
		queryString += "?rand=" + a;
	
	$("#iframeContainer").append("<iframe id='if3D' frameBorder='0' scrolling='no' src='" + plannerUrl + queryString + "' width='100%' height='800'></iframe>");

	loginHook = function (pFryID, pUsername, pFirstname, pLastname) {
		var iframe = document.getElementById('if3D');
		var data = { "message": "sessionDetails", "pipelineSessionID": readCookie_Hart(PipelineCookieName), "fryID": pFryID, "username": pUsername, "firstname": pFirstname, "lastname": pLastname };
		//update locale variables
		fryID = pFryID; username = pUsername; firstname = pFirstname; lastname = pLastname;
		iframe.contentWindow.postMessage(JSON.stringify(data), plannerUrl);
		window.console && console.log("Sending sessionDetails Message");
		//window.console && console.log(data);
	}

	visibleModalHook = function () {
		var iframe = document.getElementById('if3D');
		var data = { "message": "modalVisible"};
		iframe.contentWindow.postMessage(JSON.stringify(data), plannerUrl);
	}

	hiddenModalHook = function () {
		var iframe = document.getElementById('if3D');
		var data = { "message": "modalHidden" };
		iframe.contentWindow.postMessage(JSON.stringify(data), plannerUrl);
	}

	$(window).bind('message', function (event) {

		var oEvent = event.originalEvent; //because jQuery supercharge the DOM event you need to look at event.originalEvent
		if (oEvent.origin != plannerUrl) { // This is for SECURITY NEVER REMOVE THIS
			return false;
		}

		var data = JSON.parse(oEvent.data);
		window.console && console.log(data);
		if (data.message) {
			if (data.message == "ready") {

				//	got the ready signal, send the current session

				var iframe = document.getElementById('if3D');
				var data = { "message": "sessionDetails", "pipelineSessionID": readCookie_Hart(PipelineCookieName), "fryID": fryID, "username": username, "firstname": firstname, "lastname": lastname };
				iframe.contentWindow.postMessage(JSON.stringify(data), plannerUrl);
				window.console && console.log("Sending sessionDetails Message");


			}

			if (data.message == "product" && data.prefix && data.suffix) {

				//	got request for product

				$.ajax({
					async: true,
					url: '/Services/VividWorks/product/?prefix=' + data.prefix + '&suffix=' + data.suffix + '&rand=' + ((new Date()).getTime()),
					success: function (data) {

						var iframe = document.getElementById('if3D');
						var data = { "message": "product", "product": data };
						iframe.contentWindow.postMessage(JSON.stringify(data), plannerUrl);

            			return true;
            		}
				});

			}

			if (data.message == "cover" && data.prefix && data.suffix && data.cover) {

				//	got request for cover

				$.ajax({
					async: true,
					url: '/Services/VividWorks/cover/?cover=' + data.cover + '&prefix=' + data.prefix + '&suffix=' + data.suffix + '&rand=' + ((new Date()).getTime()),
					success: function (data) {

						var iframe = document.getElementById('if3D');
						var data = { "message": "cover", "cover": data };
						iframe.contentWindow.postMessage(JSON.stringify(data), plannerUrl);

						return true;
					}
				});

			}

			if (data.message == "currentgallery") {

				//	got request for currentgallery

				$.ajax({
					async: true,
					url: '/Services/VividWorks/currentgallery/?rand=' + ((new Date()).getTime()),
					success: function (data) {

						var iframe = document.getElementById('if3D');
						var data = { "message": "currentgallery", "currentgallery": data };
						iframe.contentWindow.postMessage(JSON.stringify(data), plannerUrl);

						return true;
					}
				});

			}

			if (data.message == "heroimage" && data.category) {

				//	got request for heroimage

				$.ajax({
					async: true,
					url: '/Services/VividWorks/heroimage/?category=' + data.category + '&rand=' + ((new Date()).getTime()),
					success: function (data) {

						var iframe = document.getElementById('if3D');
						var data = { "message": "heroimage", "heroimage": data };
						iframe.contentWindow.postMessage(JSON.stringify(data), plannerUrl);

						return true;
					}
				});

			}

		}

	});

	$(document).ready(function()
	{
		$("#divHelp").load('/Design-Center/Room-Planner-3D-Help/ #divHelp');

		$(document).ready(function () {
			$("#lnkHelp").fancybox({
				'width': 900,
				'height': 620,
				'autoscale': true,
				'type': 'iframe',
				onStart: function () {
					visibleModalHook();
				},
				onClosed: function () {
					hiddenModalHook();
				}
		});
		}
		);

	}
	);
        
</script>
</body>
</html>
</dsp:page>
