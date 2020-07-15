<dsp:page>
<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
<dsp:importbean bean="/atg/userprofiling/Profile" />
<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
<dsp:getvalueof var="customizeIt"value="${storeConfig.customizeIt}"/>
<dsp:getvalueof var="designInspirations" value="${storeConfig.designInspirations}"/>
<dsp:getvalueof var="nowFeaturing" value="${storeConfig.nowFeaturing}"/>
<dsp:getvalueof var="transient" bean="Profile.transient" />
<dsp:getvalueof var="content"
	vartype="com.endeca.infront.assembler.ContentItem"
	value="${originatingRequest.contentItem}" />
	
<div class="util-nav">

	<nav role="navigation" data-module="nav-hover-intent" data-hovertarget=".nav-list > li">
		<ul class="nav-list">
			<li><a href="#" class="utility triangle-down">In English</a>
				<div class="lang-menu">
					<ul class="lang-list">
					<a href="/" class="utility triangle-down">In English</a>
					<dsp:include page="${pageContext.request.contextPath}/global/includes/language.jsp" />
					</ul>

				</div></li>
			<li>
                 <dsp:include src="${pageContext.request.contextPath}/global/includes/displayPreferredStoreHeader.jsp" />
            </li>
			<li><a href="#" class="utility triangle-down">Customize it</a>
				<div class="customize-menu">
				<dsp:include src="${pageContext.request.contextPath}/global/includes/renderNPCHeaderContent.jsp" >
					<dsp:param name="catId" value="${customizeIt}"/>
					<dsp:param name="ulClass" value="customize-list" />
				</dsp:include>
				</div></li>
			<li><a href="#" class="utility triangle-down">Design inspirations</a>

				<div class="design-menu">
				<dsp:include src="${pageContext.request.contextPath}/global/includes/renderNPCHeaderContent.jsp" >
					<dsp:param name="catId" value="${designInspirations}"/>
					<dsp:param name="ulClass" value="design-list" />
				</dsp:include>
				</div></li>
			<li><a href="#" class="utility triangle-down">Now Featuring</a>
				<div class="featuring-menu">
				<dsp:include
					src="${pageContext.request.contextPath}/global/includes/renderNPCHeaderContent.jsp">
					<dsp:param name="catId" value="${nowFeaturing} " />
					<dsp:param name="ulClass" value="featuring-list" />
				</dsp:include>
				</div>
			</li>
			<c:choose>
					<c:when test="${ transient eq 'false' }">
						<dsp:getvalueof var="firstName" bean="Profile.firstName" />
						<li><a href="#" class="utility">
						<c:choose>
							<c:when test="${firstName != null }">
								<c:choose>
									<c:when test="${fn:length(firstName) > 12 }">
										<c:set var="fName" value="${fn:substring(firstName,0, 12)}" />
										Hello,${fName}..
									</c:when>
									<c:otherwise>
										<!-- need to display first name -->
										Hello,${firstName}
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								Welcome, View Account
							</c:otherwise>
						</c:choose>
						</a>
						<dsp:include src="${pageContext.request.contextPath}/account/gadgets/headerAccountMenu.jsp"/>
						</li>
					</c:when>
					<c:otherwise>
						<li data-module="cbox" data-className="sign-in-modal" data-transition="elastic" data-speed="500">
	                       <a href="/modals/signin.jsp" class="modal utility sign-in" data-module="sign-in" data-form="signInForm">Sign in</a> 
	                       <span class="utility">/</span>
	                       <a href="/modals/create-account.jsp" class="modal utility sign-in">Create Account</a>
	                    </li>
					</c:otherwise>
			</c:choose>
		</ul>

	</nav>

</div>

<header role="banner" class="masthead">

	   <c:if test="${not empty content.brandLogo}">
	   		<a href="/index.jsp">
				<dsp:renderContentItem contentItem="${content.brandLogo}" />
			</a>
	   </c:if>
	

	 <div class="header-promo" data-module="cbox">
	    <c:if test="${not empty content.managedContentSlot}">
			<dsp:renderContentItem contentItem="${content.managedContentSlot}" />
		</c:if>
     </div>


	<div class="cart-checkout" data-module="nav-hover-intent" data-hovertarget=".mini-cart-list">
		<dsp:include page="${pageContext.request.contextPath}/global/includes/minicart.jsp" />
	</div>

	<c:if test="${not empty content.searchBox}">
		<dsp:renderContentItem contentItem="${content.searchBox}" />
	</c:if>

</header>

<div class="primary-nav">

	<nav role="navigation" data-module="nav-hover-intent">

		<ul class="nav-list">
		<%-- 
			<li><a href="#">Recliners test</a>

				<div class="mega-nav">

					<header>

						<img src="http://placehold.it/100&text=category+thumb"
							alt="Category Thumb" />

						<p class="clear">
							Lorem ipsum dolor sit amet, consectetur adipisicing elit. Debitis
							doloremque, mollitia non maxime aliquid dicta esse delectus.
							Excepturi eligendi fugit consectetur modi aspernatur obcaecati,
							accusamus cupiditate officia. Hic, ducimus, aperiam. <a href="#"
								class="triangle-right">View all Recliners</a>
						</p>

					</header>

					<div class="cat-container">
						<ul class="cats">
							<li>
								<ul class="sub-cat">
									<li><strong>Style</strong></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul>
							</li>
							<li><strong>Material</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
							<li><strong>Color</strong>

								<ul class="color-swatches sub-cat">
									<li><a href="#">Color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>

								</ul></li>
							<li><strong>Options</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
							<li><strong>Features</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
							<li><strong>Overall width</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
							<li><strong>Specials</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
						</ul>

					</div>

					<footer>

						<div class="nav-promo">

							<img src="http://placehold.it/453x59" alt="placeholder text">

						</div>

						<div class="nav-promo">

							<img src="http://placehold.it/453x59" alt="placeholder text">

						</div>

					</footer>

				</div></li>
			<li><a href="#">Chairs</a>

				<div class="mega-nav">

					<header>

						<img src="http://placehold.it/100&text=category+thumb"
							alt="Category Thumb" />

						<p class="clear">
							Lorem ipsum dolor sit amet, consectetur adipisicing elit. Debitis
							doloremque, mollitia non maxime aliquid dicta esse delectus.
							Excepturi eligendi fugit consectetur modi aspernatur obcaecati,
							accusamus cupiditate officia. Hic, ducimus, aperiam. <a href="#"
								class="triangle-right">View all Recliners</a>
						</p>

					</header>

					<div class="cat-container">


						<ul class="cats">
							<li>

								<ul class="sub-cat">
									<li><strong>Style</strong></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul>

							</li>
							<li><strong>Material</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
							<li><strong>Color</strong>

								<ul class="color-swatches sub-cat">
									<li><a href="#">Color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>

								</ul></li>
							<li><strong>Options</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
							<li><strong>Features</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
							<li><strong>Overall width</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
							<li><strong>Specials</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
						</ul>

					</div>

					<footer>

						<div class="nav-promo">

							<img src="http://placehold.it/453x59" alt="placeholder text">

						</div>

						<div class="nav-promo">

							<img src="http://placehold.it/453x59" alt="placeholder text">

						</div>

					</footer>

				</div></li>
			<li><a href="#">Sofas</a>

				<div class="mega-nav">

					<header>

						<img src="http://placehold.it/100&text=category+thumb"
							alt="Category Thumb" />

						<p class="clear">
							Lorem ipsum dolor sit amet, consectetur adipisicing elit. Debitis
							doloremque, mollitia non maxime aliquid dicta esse delectus.
							Excepturi eligendi fugit consectetur modi aspernatur obcaecati,
							accusamus cupiditate officia. Hic, ducimus, aperiam. <a href="#"
								class="triangle-right">View all Recliners</a>
						</p>

					</header>

					<div class="cat-container">


						<ul class="cats">
							<li>

								<ul class="sub-cat">
									<li><strong>Style</strong></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul>

							</li>
							<li><strong>Material</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
							<li><strong>Color</strong>

								<ul class="color-swatches sub-cat">
									<li><a href="#">Color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>

								</ul></li>
							<li><strong>Options</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
							<li><strong>Features</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
							<li><strong>Overall width</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
							<li><strong>Specials</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
						</ul>

					</div>

					<footer>

						<div class="nav-promo">

							<img src="http://placehold.it/453x59" alt="placeholder text">

						</div>

						<div class="nav-promo">

							<img src="http://placehold.it/453x59" alt="placeholder text">

						</div>

					</footer>

				</div></li>
			<li><a href="#">Sectionals</a>

				<div class="mega-nav">

					<header>

						<img src="http://placehold.it/100&text=category+thumb"
							alt="Category Thumb" />

						<p class="clear">
							Lorem ipsum dolor sit amet, consectetur adipisicing elit. Debitis
							doloremque, mollitia non maxime aliquid dicta esse delectus.
							Excepturi eligendi fugit consectetur modi aspernatur obcaecati,
							accusamus cupiditate officia. Hic, ducimus, aperiam. <a href="#"
								class="triangle-right">View all Recliners</a>
						</p>

					</header>

					<div class="cat-container">


						<ul class="cats">
							<li>

								<ul class="sub-cat">
									<li><strong>Style</strong></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul>

							</li>
							<li><strong>Material</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
							<li><strong>Color</strong>

								<ul class="color-swatches sub-cat">
									<li><a href="#">Color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>

								</ul></li>
							<li><strong>Options</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
							<li><strong>Features</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
							<li><strong>Overall width</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
							<li><strong>Specials</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
						</ul>

					</div>

					<footer>

						<div class="nav-promo">

							<img src="http://placehold.it/453x59" alt="placeholder text">

						</div>

						<div class="nav-promo">

							<img src="http://placehold.it/453x59" alt="placeholder text">

						</div>

					</footer>

				</div></li>
			<li><a href="#">Ottomans</a>

				<div class="mega-nav">

					<header>

						<img src="http://placehold.it/100&text=category+thumb"
							alt="Category Thumb" />

						<p class="clear">
							Lorem ipsum dolor sit amet, consectetur adipisicing elit. Debitis
							doloremque, mollitia non maxime aliquid dicta esse delectus.
							Excepturi eligendi fugit consectetur modi aspernatur obcaecati,
							accusamus cupiditate officia. Hic, ducimus, aperiam. <a href="#"
								class="triangle-right">View all Recliners</a>
						</p>

					</header>

					<div class="cat-container">


						<ul class="cats">
							<li>

								<ul class="sub-cat">
									<li><strong>Style</strong></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul>

							</li>
							<li><strong>Material</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
							<li><strong>Color</strong>

								<ul class="color-swatches sub-cat">
									<li><a href="#">Color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>

								</ul></li>
							<li><strong>Options</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
							<li><strong>Features</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
							<li><strong>Overall width</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
							<li><strong>Specials</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
						</ul>

					</div>

					<footer>

						<div class="nav-promo">

							<img src="http://placehold.it/453x59" alt="placeholder text">

						</div>

						<div class="nav-promo">

							<img src="http://placehold.it/453x59" alt="placeholder text">

						</div>

					</footer>

				</div></li>
			<li><a href="#">Love Seats</a>

				<div class="mega-nav">

					<header>

						<img src="http://placehold.it/100&text=category+thumb"
							alt="Category Thumb" />

						<p class="clear">
							Lorem ipsum dolor sit amet, consectetur adipisicing elit. Debitis
							doloremque, mollitia non maxime aliquid dicta esse delectus.
							Excepturi eligendi fugit consectetur modi aspernatur obcaecati,
							accusamus cupiditate officia. Hic, ducimus, aperiam. <a href="#"
								class="triangle-right">View all Recliners</a>
						</p>

					</header>

					<div class="cat-container">


						<ul class="cats">
							<li>

								<ul class="sub-cat">
									<li><strong>Style</strong></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul>

							</li>
							<li><strong>Material</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
							<li><strong>Color</strong>

								<ul class="color-swatches sub-cat">
									<li><a href="#">Color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>
									<li><a href="#">color</a></li>

								</ul></li>
							<li><strong>Options</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
							<li><strong>Features</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
							<li><strong>Overall width</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
							<li><strong>Specials</strong>

								<ul class="sub-cat">
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
									<li><a href="#">Link</a></li>
								</ul></li>
						</ul>

					</div>

					<footer>

						<div class="nav-promo">

							<img src="http://placehold.it/453x59" alt="placeholder text">

						</div>

						<div class="nav-promo">

							<img src="http://placehold.it/453x59" alt="placeholder text">

						</div>

					</footer>

				</div></li>
			<li><a href="#">Tables</a>

				<div class="mega-nav">This it the megaNav test</div></li>
			<li><a href="#">Urban attitudes</a>

				<div class="mega-nav">This it the megaNav test</div></li>
			<li><a href="#">On sale</a>

				<div class="mega-nav">This it the megaNav test</div></li>
				--%>
		</ul>

	</nav>

</div>
</dsp:page>