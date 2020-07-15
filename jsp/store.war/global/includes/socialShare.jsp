<dsp:page>
<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
<dsp:getvalueof var="contextPath" value="${originatingRequest.ContextPath}" />
<a href="https://www.facebook.com/lazboy" title="Facebook"><img width="36" height="35" src="//content.la-z-boy.com/Images/fg/ico_fg_FB.png" alt="Facebook"></a></a></br>
<a  href="https://www.pinterest.com/lazboy/" title="Pinterest"><img width="36" height="35" src="//content.la-z-boy.com/Images/fg/ico_fg_pinit.png" alt="Pinterest"></a></br>
<a href="https://twitter.com/lazboy" title="Twitter"><img width="36" height="35" src="//content.la-z-boy.com/Images/fg/ico_fg_Twit.png" alt="Twitter"></a></br>
<a href="${contextPath}/global/includes/shareThisProduct.jsp"><img width="36" height="35" src="//content.la-z-boy.com/Images/fg/ico_fg_Email.png" alt="Mailing List"></a></br>

</dsp:page>
