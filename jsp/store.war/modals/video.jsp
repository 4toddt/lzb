<dsp:page>

<dsp:getvalueof param="vid" var="video"/>
<dsp:getvalueof param="title" var="title"/>
<dsp:getvalueof param="description" var="description"/>

<!doctype html>
<html class="no-js" lang="en-US">

	<head>

		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<title>Video</title>
		<meta name="description" content="">
		<meta name="viewport" content="width=device-width, initial-scale=1">

	</head>

	<body role="document" class="modal-content">

		<main role="main" class="video">

			<section class="">

				<h1>${fn:escapeXml(title)}</h1>

				<iframe width="600" height="400" src="${fn:escapeXml(video)}" frameborder="0" allowfullscreen></iframe>

				<p>${fn:escapeXml(description)}</p>

<%-- 					<div class="share-icons" data-module="social-share-icons social-share">
                        <ul>
                            <li><a href="#" data-service="pinterest"><img src="/img/icon-share-pint.png" alt="Pinterest icon"></a></li>
                            <li><a href="#" data-service="print"><img src="/img/icon-share-print-pdp.png" alt="Print page" title=""></a></li>
                            <li><img src="/img/icon-share-all-pdp.png" class="social-share-click" alt="Share icon" title=""></li>
                        </ul>

	                    <ul class="social-bubble">
	                        <li>
								<a href="https://www.facebook.com/lazboy" data-service="facebook" title="Facebook"><img width="36" height="35" src="//content.la-z-boy.com/Images/elementsImages/share_fb.png" alt="Like on Facebook"></a>
	                        </li>
	                        <li>
	                            <a href="https://twitter.com/intent/tweet" data-service="twitter" title="Twitter"><img width="36" height="35" src="//content.la-z-boy.com/Images/fg/ico_fg_Twit.png" alt="Twitter"></a>
	                        </li>
	                        <li>
	                            <a href="${contextPath}/global/includes/shareThisProduct.jsp"><img width="36" height="35" src="//content.la-z-boy.com/Images/fg/ico_fg_Email.png" alt="Mailing List"></a>
	                        </li>
	                    </ul>

                    </div> --%>

			</section>

		</main>

		<footer class="video">

			<p>Nearly all of our recliners, sofas and chairs are proudly built in the USA from domestic and imported materials.</p>

		</footer>

	</body>

</html>
 
</dsp:page>