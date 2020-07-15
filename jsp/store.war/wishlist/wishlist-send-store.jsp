<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />

	<lzb:pageContainer>
		<jsp:attribute name="seoAlternateURL"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL">${originatingRequest.getRequestURI()}</jsp:attribute>

        <main role="main">

            <section class="send-to-store-column">

				<h1>Contact a La-Z-Boy Furniture Galleries</h1>

				<p class="error-txt">Need more information?</p>
				<p class="error-txt">Contact your local store with question by submitting the form below.</p>
				<p><sup>*</sup>Required Fields</p>
				<form action="#" method="post">
					<fieldset>
						<legend>Send to Store</legend>
						<fieldset>
							<label for="fName">First Name <sup>*</sup></label><input type="text" id="fName" required="required" />
						</fieldset>
						<fieldset>
							<label for="email">Your Email <sup>*</sup></label><input type="text" id="email" required="required" />
						</fieldset>
						<fieldset>
							<label for="addres">Address</label><input type="text" id="addres" required="required" />
						</fieldset>
						<fieldset>
							<label for="city">City </label><input type="text" id="city" required="required" />
						</fieldset>
						<fieldset>
							<label for="state">State <sup>*</sup></label>
							<select id="state">
								<option>AK</option>
							</select>
						</fieldset>
						<fieldset>
							<label for="zip">ZIP / Postal Code <sup>*</sup></label><input type="text" id="zip" required="required" />
						</fieldset>
						<fieldset>
							<label for="phone">Phone <sup>*</sup></label><input type="text" id="phone" required="required" />
						</fieldset>
						<fieldset>
							<label for="comments">Comments</label><textarea cols="30" rows="5" id="comments"></textarea>
						</fieldset>
<!-- 						<fieldset>
							<label>Verification Image</label>
						</fieldset>
						<fieldset>
							<label for="verficationNum">Enter Verification Number <sup>*</sup></label><input type="text" id="verficationNum" required="required" />
						</fieldset>
						<fieldset>
							<label for="gender">How should we respond to your request?<sup>*</sup></label>
							<input type="radio" name="gender" value="female" id="femalegender"><label for="femalegender" class="short-label">Phone</label>
							<input type="radio" name="gender" value="male" id="malegender"><label for="malegender" class="short-label">Email
						</fieldset>
 -->					</fieldset>
				</form>
            </section>

<!--             <section role="store-options" class="send-to-store-column">

            </section>
 -->
        </main>
	</lzb:pageContainer>
</dsp:page>
