<dsp:page>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
	<dsp:getvalueof var="fromFb" param="fromFb"/>
	<dsp:getvalueof var="fbAppId"value="${storeConfig.fbAppId}"/>
	<dsp:getvalueof var="hostName"value="${storeConfig.hostName}"/>
	<dsp:getvalueof var="fbPermissions" value="${storeConfig.fbScopePermissons}"/>
	<dsp:getvalueof var="fbRedirectUrl" value="${storeConfig.fbRedirectUrl}"/>
	<dsp:getvalueof var="pageName" param="pageName"/>

	<input type="hidden" id="fbAppID" value="${fbAppId}" />
	<input type="hidden" id="redirectUrl" value="${fbRedirectUrl}" />
	<input type="hidden" id="hostName" value="${hostName}" />
	<input type="hidden" id="fromFb" value="${fromFb}" />
	
	<script>
	function fbInit(){
		//var fbAppID = $('#fbAppID').val();
		//var redirectUrl = $('#redirectUrl').val();
		//var hostName = $('#hostName').val();
		//var fromFb = $('#fromFb').val();
		
		var fbAppID = document.getElementById('fbAppID').value;
		var redirectUrl = document.getElementById('redirectUrl').value;
		var hostName = document.getElementById('hostName').value;
		var fromFb = document.getElementById('fromFb').value;
		

		// This is called with the results from from FB.getLoginStatus().
		function statusChangeCallback(response) {
		//console.log('statusChangeCallback');
		//console.log(response);
		// The response object is returned with a status field that lets the
		// app know the current login status of the person.
		// Full docs on the response object can be found in the documentation
		// for FB.getLoginStatus().
		if (response.status === 'connected') {
		// Logged into your app and Facebook.
			testAPI(encodeURI(response.authResponse.userID));
		} else if (response.status === 'not_authorized') {
		// The person is logged into Facebook, but not your app.
		document.getElementById('status').innerHTML = 'Please log ' + 'into this app.';
		} else {
		// The person is not logged into Facebook, so we're not sure if
		// they are logged into this app or not.
			document.getElementById('status').innerHTML = 'Please log ' + 'into Facebook.';
		}
	}

		// This function is called when someone finishes with the Login
		// Button.  See the onlogin handler attached to it in the sample
		// code below.
		window.checkLoginState = function() {
			FB.getLoginStatus(function(response) {
				statusChangeCallback(response);
			});
		};

		window.fbAsyncInit = function() {
			FB.init({
				appId : fbAppID,
				cookie : true, // enable cookies to allow the server to access the session
				xfbml : true, // parse social plugins on this page
				version : 'v2.1' // use version 2.1
			});

			// Now that we've initialized the JavaScript SDK, we call 
			// FB.getLoginStatus().  This function gets the state of the
			// person visiting this page and can return one of three states to
			// the callback you provide.  They can be:
			//
			// 1. Logged into your app ('connected')
			// 2. Logged into Facebook, but not your app ('not_authorized')
			// 3. Not logged into Facebook and can't tell if they are logged into
			//    your app or not.
			//
			// These three cases are handled in the callback function.

			FB.getLoginStatus(function(response) {
				statusChangeCallback(response);
			});
		};

		// Load the SDK asynchronously
		(function(d, s, id) {
			var js, fjs = d.getElementsByTagName(s)[0];
			if (d.getElementById(id)){ return;}
			js = d.createElement(s); js.id = id;
			js.src = '//connect.facebook.net/en_US/sdk.js';
			fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));

		// Here we run a very simple test of the Graph API after login is
		// successful.  See statusChangeCallback() for when this call is made.
		function testAPI(userId) {
			console.log('Welcome!  Fetching your information.... ');
			FB.api('/me', function(response) {
				console.log('Successful login for: ' + response.name);
				$('#fb-connect-section .fbLoginForm').find('status').innerHTML ='Thanks for logging in, ' + response.name + '!';
				$('#fb-connect-section .fbLoginForm').find('#facebookFirstName').val(response.first_name);
			    $('#fb-connect-section .fbLoginForm').find('#facebookLastName').val(response.last_name);
			    $('#fb-connect-section .fbLoginForm').find('#fbUserId').val(userId);
				$('#fb-connect-section .fbLoginForm').submit();
			});
		}
	} /* fbInit() */
	
	fbInit();
	
	
	
	
	</script>

<!--
  Below we include the Login Button social plugin. This button uses
  the JavaScript SDK to present a graphical Login button that triggers
  the FB.login() function when clicked.
-->
	
	<fb:login-button scope="${fbPermissions}" onlogin="checkLoginState();">Connect With Facebook</fb:login-button>
	<div id="status"></div>
	<dsp:form action="#" method="post" iclass="fbLoginForm" id="fbLoginForm" formid="fbLoginForm" name="fbLoginForm">
		<dsp:input type="hidden" id="facebookFirstName" bean="ProfileFormHandler.facebookFirstName" value=""/>
		<dsp:input type="hidden" id="facebookLastName" bean="ProfileFormHandler.facebookLastName" value=""/>
		<dsp:input type="hidden" id="fbUserId" bean="ProfileFormHandler.fbUserId" value=""/>
		<dsp:input type="hidden"  bean="ProfileFormHandler.faceBookErrorUrl" value=""/>
		<dsp:input type="hidden"  bean="ProfileFormHandler.faceBookSuccessUrl" value=""/>
		<dsp:input type="hidden"  bean="ProfileFormHandler.faceBookConnected" value="faceBookConnected=true"/>
		<dsp:input type="hidden" bean="ProfileFormHandler.faceBookLogin" value="true"/>
	</dsp:form>

</body>

</dsp:page>