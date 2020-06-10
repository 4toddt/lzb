<dsp:page>
<lzb:pageContainer>
		<jsp:attribute name="bodyClass">npc</jsp:attribute>

		<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
		<dsp:importbean bean="/atg/userprofiling/Profile" />
		<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty" />
		<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />

		<main role="main">
           <dsp:include page="/includes/leftnavigation.jsp"/>
			<dsp:param name="selpage" value="DESIGN_CENTER" />

            <section role="region" class="profile-account-content">
				<h1>My Design Center</h1>

			   <div class="tab-wrapper" role="tabpanel">

	                    <ul class="tabs" data-module="tabs" role="tablist">
	                        <li class="active" data-rel="tab1" role="tab" aria-controls="tab1">Design Help</li>
	                        <li data-rel="tab2" role="tab" aria-controls="tab2">Saved Covers</li>
	                        <li data-rel="tab3" role="tab" aria-controls="tab3">Room Planner</li>
	                    </ul>

	                </div>


					<div class="design-cener tab-content active" id="tab1" data-tab-content="tab1">
					<div class="design-message">We filled the online Design Center with a wealth of information and interactive tools to help you build the rooms of your dreams.</div>
					<div class="design-cell-wrapper">
						<div class="design-cells">
							<div class="cell-image"><a href="#"><img src="http://placehold.it/192x192" alt="My Design Center" /></a></div>
							<div class="cells-header"><a href="#">Save Your Favorite Covers</a></div>
							<div class="cells-txt">Search or browse for the fabrics or leathers you like best. Save them to your list so you can reference them in the future.</div>
						</div>
						<div class="design-cells">
							<div class="cell-image"><a href="#"><img src="http://placehold.it/192x192" alt="My Design Center" /></a></div>
							<div class="cells-header"><a href="#">Room Planner</a></div>
							<div class="cells-txt">Worried about space? Use our room planner to enter your room dimensions and drag and drop pieces into place.</div>
						</div>
						<div class="design-cells">
							<div class="cell-image"><a href="#"><img src="http://placehold.it/192x192" alt="My Design Center" /></a></div>
							<div class="cells-header"><a href="#">Style Finder</a></div>
							<div class="cells-txt">What's your style? Take our quiz to find out!</div>
						</div>
						<div class="design-cells">
								<div class="cell-image"><a href="#"><img src="http://placehold.it/192x192" alt="My Design Center" /></a></div>
							<div class="cells-header"><a href="#">Free In-Home Design</a></div>
							<div class="cells-txt">Leave it to the pros - our La-Z-Boy designers always have your style, comfort and budget in mind.</div>
						</div>
						<div class="design-cells">
							<div class="cell-image"><a href="#"><img src="http://placehold.it/192x192" alt="My Design Center" /></a></div>
							<div class="cells-header"><a href="#">Room Inspirations</a></div>
							<div class="cells-txt">Need a jolt of creativity? Find it in our Room Inspirations.</div>
						</div>
						<div class="design-cells">
							<div class="cell-image"><a href="#"><img src="http://placehold.it/192x192" alt="My Design Center" /></a></div>
							<div class="cells-header"><a href="#">Room Measuring</a></div>
							<div class="cells-txt">Make suer your special piece fits all your need - space, volume and comfort - by following our measuring tips.</div>
						</div>
					</div>
				</div>



				<div class="tab-content" id="tab2" data-tab-content="tab2">


					<!-- No Covers-->

					<!--<div class="no-covers">

						<p class="no-covers-icon">You currently have no covers saved. <a href="#">Continue Shopping</a></p>

						<p>Save your favorite covers while browsing our site so you can easily find, compare, and select them at a later time.</p>

					</div>-->




					<div class="design-coverlist">

						<p>Save your favorite covers while browsing our site so you can easily find, compare, and select them at a later time.</p>
						<table>

							<thead>
							  <tr>
								<th>&nbsp;</th>
								<th class="cover-description">Description</th>
								<th>Fabric Number</th>
								<th>Added On</th>
								<th>&nbsp;</th>
							  </tr>
							</thead>

							<tbody>
								 <tr>
									<td class="cover-img"><img src="http://placehold.it/75x75" alt="plaholder image" /></td>
									<td class="cover-description">
										<a href="#">Tasha Ottoman</a>
										<div>Color: <span>Ecru</span></div>
									</td>
									<td class="cover-fabric-no">B968432</td>
									<td class="cover-add-ons">2014-07-15</td>
									<td class="cover-remove"><a href="#">Remove</a></td>
								  </tr>

								  <tr>
									<td class="cover-img"><img src="http://placehold.it/75x75" alt="plaholder image" /></td>
									<td class="cover-description">
										<a href="#">Tasha Ottoman</a>
										<div>Color: <span>Merlot</span></div>
									</td>
									<td class="cover-fabric-no">B968432</td>
									<td class="cover-add-ons">2014-07-15</td>
									<td class="cover-remove"><a href="#">Remove</a></td>
								  </tr>

								  <tr>
									<td class="cover-img"><img src="http://placehold.it/75x75" alt="plaholder image" /></td>
									<td class="cover-description">
										<a href="#">Tasha Ottoman</a>
										<div>Color: <span>Merlot</span></div>
									</td>
									<td class="cover-fabric-no">B968432</td>
									<td class="cover-add-ons">2014-07-15</td>
									<td class="cover-remove"><a href="#">Remove</a></td>
								  </tr>

							 </tbody>

						</table>

					</div>

				</div>

				<div class="tab-content" id="tab3" data-tab-content="tab3">

					<div class="design-msg">
						<p>Click on the launch room planner button below to enter your room’s dimensions, then drag-and-drop furniture to see what fits best.</p>
						<a href="#" class="btn-primary">launch room planner</a>
					</div>

				</div>


            </section>

        </main>


	</lzb:pageContainer>

</dsp:page>
