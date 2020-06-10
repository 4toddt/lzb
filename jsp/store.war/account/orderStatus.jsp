<dsp:page>
	<lzb:pageContainer>
		<dsp:importbean bean="/atg/userprofiling/Profile" />
		<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
		<dsp:getvalueof bean="ProfileFormHandler.formError" var="formError" />
		<dsp:getvalueof var="email" bean="Profile.login" />
		<dsp:getvalueof var="optIn" bean="ProfileFormHandler.optInEmail" />

		<jsp:attribute name="bodyClass">npc</jsp:attribute>

		<jsp:attribute name="title">Profile</jsp:attribute>

		<lzb:breadCrumb pageKey="breadcrumb.profile" divClass="breadcrumb" />

		<c:if test="${formError eq 'true'}">

			<div class="message-container">
				<div class="message-wrapper">
				<dsp:include page="/global/errors.jsp">
					<dsp:param name="formHandler" bean="ProfileFormHandler" />
				</dsp:include>
			</div></div>
		</c:if>


		<main role="main">

            <h1>Order Status</h1>

            <div class="myorder-status">
				<p><strong>Where’s My Order?</strong></p>
				<ul>
					<li>Enter your online order number (you can find it in your confirmation email)</li>
					<li>Enter the ZIP code you used in your delivery address</li>
					<li>We’ll show you status of all open and completed orders</li>
				</ul>
				<p>If you placed your order in a store, <a href="#">contact the store</a> directly.</p>
				<p>Already have an account? <a href="#">Login</a> to access your order details.</p>
			</div>

			<div class="create-order">
				<p><strong>Don’t have an account?</strong></p>
				<p>Sign up in minutes to creat e a Wishlist, access order status and history and select your communication preferences.</p>
				<button class="btn-primary">Create an Account</button>
			</div>
			<p><sup>*</sup> Required fields</p>

			<div class="order-search-bar">
				<form action="#" method="post" id="order-status">
						<fieldset>
							<label for="orderno">Order Number<sup>*</sup></label>
							<input name="" type="text" id="orderno" required="required">
						</fieldset>
						<fieldset>
							<label for="zipcode">Billing Postal/ZIP Code<sup>*</sup></label>
							<input name="" type="text" id="zipcode" required="required">
						</fieldset>
						<button class="btn-primary" type="submit">Submit</button>
				</form>
			</div>

			<h2>Order No. G4012220</h2>

			<p class="order-contact"><strong>Still need help?</strong> Call or email us at <strong>800.375.6890</strong> or <a href="mailto:websaleshelp@la-z-boy.com">websaleshelp@la-z-boy.com</a></p>

			<div class="cust-order-details">

				<div class="order-details">
					<h3>Your order details</h3>
					<h4 class="style-upercase">Delivery Address</h4>
					<div class="customer-name">John Booth</div>
					<p>9876 Main Street Summerville, AR 99658</p>
				</div>

				<div class="order-details">
					<div class="order-no">Order No.: <span>G4012220</span></div>
					<h4>Special Delivery Instructions</h4>
					<p>Ethical paleo pop-up you probably haven’t heard of them food truck vinyl craft beer meh vegan vhs disrupt meggings skateboard hella distillery lo-fi kickstarter umami synth neutra.</p>
				</div>

				<div class="order-details">
					<div class="order-no">Date: <span>2013-09-10</span></div>
					<h4 class="style-upercase">Billing Address</h4>
					<div class="customer-name">John Booth</div>
					<p>9876 Main Street Summerville, AR 99658</p>
				</div>

				<div class="order-details">
					<div class="order-no">Status: <strong class="style-upercase">In Progress</strong></div>
					<h4 class="style-upercase">Payment Method</h4>
					<div  class="order-paymentcard"><strong class="style-upercase">visa</strong> <span>1234 $3,294.70</span></div>
					<div  class="order-paymentcard"><strong class="style-upercase">amex</strong> <span>5678 $3,294.70</span></div>
				</div>

				<div class="customer-order">

					<h5>Ordered Items</h5>

					<table>

					<thead>
					  <tr>
						<th colspan="2" class="order-description">Description</th>
						<th>Item Price</th>
						<th>Qty</th>
						<th>Item Total</th>
					  </tr>
					</thead>

					<tbody>


					 </tbody>

					 <tfoot>
					 	<tr>
							<td colspan="4">4 Items Total:</td>
							<td>$6,063.00</td>
						</tr>
						<tr>
							<td colspan="4">5 Year Fabric Protection Plan (1 item):</td>
							<td>$80.00</td>
						</tr>
						<tr>
							<td colspan="4">Home Delivery from Local Store:</td>
							<td>$139.00</td>
						</tr>
						<tr>
							<td colspan="4">Sales Tax:</td>
							<td>$307.40</td>
						</tr>
						<tr>
							<td colspan="2">&nbsp;</td>
							<td colspan="2" class="totalprice">TOTAL:</td>
							<td class="totalprice">$6589.40</td>
						</tr>
					 </tfoot>
				</table>


				</div>

			</div>

        </main>
	</lzb:pageContainer>
</dsp:page>
