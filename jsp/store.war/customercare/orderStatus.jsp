<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />

	<lzb:pageContainer>
		<dsp:importbean bean="/com/lzb/commerce/customercare/LZBProductRegisterFormHandler" />
		<dsp:importbean bean="/atg/commerce/util/StateListDroplet" />
		<dsp:getvalueof var="cotextPath" value="${originatingRequest.ContextPath}" />
		<dsp:getvalueof bean="LZBProductRegisterFormHandler.formError" var="formError" />

		<jsp:attribute name="bodyClass">npc</jsp:attribute>
		<jsp:attribute name="seoAlternateURL"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL">${originatingRequest.getRequestURI()}</jsp:attribute>

	<c:if test="${formError eq 'true'}">
		<dsp:include page="/global/errors.jsp">
			<dsp:param name="formHandler" bean="LZBProductRegisterFormHandler" />
		</dsp:include>
	</c:if>


		<main role="main"> <dsp:include
			page="/includes/custCareNav.jsp">
			<dsp:param name="selpage" value="PROFILE" />
		</dsp:include> <dsp:layeredBundle basename="com.lzb.common.WebAppResources">
			<section role="region" class="cust-support two-column-support"
				data-module="form-validate">
				<div class="cust-contact">
					<dsp:form action="#" method="post" name="productRegistration"
						id="productRegistration">
					</dsp:form>
						<h1>
							Order Status
						</h1>


				</div>
				<div class="contact-chat">
						<h2>By CHAT</h2>
						<p>
							<strong>Get live help</strong> anytime from one of our f helpful
							customer care specialist
						</p>
						<a href="#" class="btn-primary">Chat Now</a>
						<div class="contact-detls">
							<h3>By Phone</h3>
							<p>For questions about your online orders, call</p>
							<p>
								<strong>1-800-375-6890</strong>
							</p>
							<p>For warranty inquiries, call</p>
							<p>
								<strong>855-80-COMFORT</strong>
							</p>
							<p>
								or<span> <strong>1-855-802-6636</strong></span>
							</p>
							<p>Mon - Sat 8:00am - 8:00 pm EST Sun 9:00 am - 6:00 pm EST</p>
						</div>
					</div>

			</section>
			</main>
		</dsp:layeredBundle>

	</lzb:pageContainer>
</dsp:page>
