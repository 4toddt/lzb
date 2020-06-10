<dsp:page>
    <dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
    <dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>

    <dsp:getvalueof var="fromFb" param="fromFb"/>
    <dsp:getvalueof var="fbAppId"value="${storeConfig.fbAppId}"/>
    <dsp:getvalueof var="hostName"value="${storeConfig.hostName}"/>
    <dsp:getvalueof var="fbPermissions" value="${storeConfig.fbScopePermissons}"/>
    <dsp:getvalueof var="fbRedirectUrl" value="${storeConfig.fbRedirectUrl}"/>

    <script type="text/javascript">
        var fbAppID = "${fbAppId}",
            redirectUrl = "${fbRedirectUrl}",
            hostName = "${hostName}",
            fromFb = "${fromFb}";

        function statusChangeCallback(response) {
            console.log('statusChangeCallback');
            console.log(response);
            // The response object is returned with a status field that lets the
            // app know the current login status of the person.
            // Full docs on the response object can be found in the documentation
            // for FB.getLoginStatus().
            if (response.status === 'connected') {
                // Logged into your app and Facebook.
                //alert( fromFb!='true');
                testAPI(escape(response.authResponse.userID));
            } else if (response.status === 'not_authorized') {
                // The person is logged into Facebook, but not your app.
                document.getElementById('status').innerHTML = 'Please log '
                        + 'into this app.';
            } else {
                // The person is not logged into Facebook, so we're not sure if
                // they are logged into this app or not.
                document.getElementById('status').innerHTML = 'Please log '
                        + 'into Facebook.';
            }
        }

        // This function is called when someone finishes with the Login Button.
        // See the onlogin handler attached to it in the sample code below.
        function checkLoginState() {
            FB.getLoginStatus(function(response) {
                statusChangeCallback(response);
            });
        }

        window.fbAsyncInit = function() {
            FB.init({
                appId : fbAppID,
                cookie : true, // enable cookies to allow the server to access
                // the session
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

            /* FB.getLoginStatus(function(response) {
                statusChangeCallback(response);
            }); */
        };

        // Load the SDK asynchronously
        (function(d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id))
                return;
            js = d.createElement(s);
            js.id = id;
            js.src = "https://connect.facebook.net/en_US/sdk.js";
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));

        // Here we run a very simple test of the Graph API after login is
        // successful.  See statusChangeCallback() for when this call is made.
        function testAPI(userId) {
            FB.api('/me', function(response) {
                console.log('Successful login for: ' + response.name);
                document.getElementById('status').innerHTML =
                    'Thanks for logging in, ' + response.name + '!';
                $('#fbLoginForm').find('#facebookFirstName').val(response.first_name);
                $('#fbLoginForm').find('#facebookLastName').val(response.last_name);
                $('#fbLoginForm').find('#fbUserId').val(userId);
                $('#fbLoginForm').submit();
            });
        }
    </script>

    <%--
        Below we include the Login Button social plugin. This button uses
        the JavaScript SDK to present a graphical Login button that triggers
        the FB.login() function when clicked.
    --%>
    <div id="status"></div>
    <dsp:form action="#" method="post" id="fbLoginForm" formid="fbLoginForm" name="fbLoginForm">
        <dsp:input type="hidden" id="facebookFirstName" bean="ProfileFormHandler.facebookFirstName" value=""/>
        <dsp:input type="hidden" id="facebookLastName" bean="ProfileFormHandler.facebookLastName" value=""/>
        <dsp:input type="hidden" id="fbUserId" bean="ProfileFormHandler.fbUserId" value=""/>
        <dsp:input type="hidden"  bean="ProfileFormHandler.faceBookErrorUrl" value=""/>
        <dsp:input type="hidden"  bean="ProfileFormHandler.faceBookSuccessUrl" value=""/>
        <dsp:input type="hidden"  bean="ProfileFormHandler.faceBookConnected" value="faceBookConnected=true"/>
        <dsp:input type="hidden" bean="ProfileFormHandler.faceBookLogin" value="true"/>
    </dsp:form>
</dsp:page>