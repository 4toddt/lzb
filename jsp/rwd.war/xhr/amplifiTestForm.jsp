<dsp:page>
  <dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
  <dsp:importbean var="originatingRequest" bean="/OriginatingRequest"/>
  <dsp:getvalueof var="currentLocale" vartype="java.lang.String" bean="/atg/dynamo/servlet/RequestLocale.localeString"/>

<!DOCTYPE html>
<html class="no-js">

	<head>

		<meta charset="utf-8"/>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>

		<title>La-Z-Boy</title>

		<meta name="description" content=""/>
		<meta name="viewport" content="width=device-width"/>


		<style>
			.amp-error {
				display:none;
			}
			.amp-loading {
			    filter: alpha(opacity = 40);
			    opacity: 0.4;
			}
		</style>

	</head>

	<!--[if IE 8]>         <body class="lt-ie9"> <![endif]-->
	<!--[if IE 9]>         <body class="ie9"> <![endif]-->
	<!--[if gt IE 9]><!--> <body id="login"> <!--<![endif]-->

		<main class="modal-1">

			<header>

				<h1>ADD TO CART</h1>

			</header>

			<p id="addToCartError" class="amp-error"></p>

			<form action="/xhr/amplifiSubmit.jsp" method="post" id="addToCartForm" class="amplifi-form" data-error-messaging="#addToCartError">


					<label for="email">Email</label>
					<input type="text" id="email" value="" name=".value.login" class="amplifi-input" />


					<br>

					<label for="password">password</label>
					<input type="text" id="password" value="" name=".value.password" class="amplifi-input" />

					<br>

                	<input type="checkbox" class="amplifi-input" name=".value.rememberMe" id="remember" checked="true"/>
					<label for="remember" class="checkout checkout1">Remember Me
						<a title="This means that we will save your password until you click 'sign out' even if you disconnect from the
	                    internet, close your browser or turn off your computer.  Just to keep you safe, we will automatically
	                    sign you out after 90 days even if you haven't clicked 'sign out'." class="tooltip" href="#">
	                      <div class="triangle-with-shadow"></div>
	                      <div title="" class="tooltip-img"></div>
	                    </a>
					</label>
					<%--l
					<label for="Quantity">Quantity</label>
					<input type="text" id="Quantity" value="1" name=".quantity" class="amplifi-input" />
 --%>
					<br>

					<input type="submit" value="Add to Cart" class="btn btn-addtocart amplifi-submitter" id="amplifi-button" data-error-messaging="#addToCartError" />
					<input type="hidden" name="amplifiHandler" value=".login" class="amplifi-input" />
					<input type="hidden" name="amplifiBean" value="/atg/userprofiling/ProfileFormHandler" class="amplifi-input" />
					<input type="hidden" name="amplifiSuccessUrl" value="${pageContext.request.contextPath}/account/profile.jsp" />
					<%-- OPTIONAL INPUTS
						<input type="hidden" name="amplifiSuccessUrl" value="/checkout/" />
						<input type="hidden" name="amplifiGetData" value="getData.jsp" class="amplifi-input" />
						<input type="hidden" name="amplifiGetHtml" value="getData.jsp" />
					--%>
					<dsp:include page="getAmplifiToken.jsp">
						<dsp:param name="class" value="amplifi-input" />
					</dsp:include>

			</form>

		</main>


		<script src="/js/lib/jquery/dist/jquery.min.js?ver=${assetVersion}"></script>
		<script src="/js/lib/xhr/jquery.amplifi.ajax-form-submit.js?ver=${assetVersion}"></script>

	</body>

</html>






</dsp:page>
