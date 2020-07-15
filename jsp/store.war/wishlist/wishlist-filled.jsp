<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />

	<lzb:pageContainer>
		<jsp:attribute name="seoAlternateURL"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL">${originatingRequest.getRequestURI()}</jsp:attribute>

        <main role="main">

            <nav role="navigation" class="account secondary-nav">

				<div class="nav-title">My Account</div>
				<ul>
					<li class="nav-item"><a href="#">Profile</a></li>
					<li class="nav-item"><a href="#">My Preferred Store</a></li>
					<li class="nav-item"><a href="#">Address Book</a></li>
					<li class="nav-item"><a href="#">Order History</a></li>
					<%-- JIRA DMI-1763 Hide Wishlist UI
					<li class="nav-item"><a href="#">My Wishlist</a></li>
					--%>
					<li class="nav-item"><a href="#">Payment Methods</a></li>
					<li><a href="#"><div class="logout">Logout</div></a></li>
				</ul>
				<div class="nav-title">My Design Center<div class="triangle"></div></div>
				<ul>
					<li class="nav-item"><a href="#">Saved Covers</a></li>
					<li class="nav-item"><a href="#">Room Planner</a></li>
				</ul>
            </nav>

            <section role="region" class="wishlist-main">
				<div class="account-content">
				<h1>My Wishlist</h1>
				<div class="standard-border wishlist-update">Explain that prices depend on delivery postal / zip code. Let shopper correct ZIP / Postal Code for calculation.
					<input type="text" class="zip-input">
					<button class="yellow-button">Update</button>
				</div>
				<ul class="wishlist-nav">
					<li><input type="checkbox" id="wish"> Select All</li>
					<li><span class="wish-share">&nbsp;</span>Share Selected<div class="change-arrow"></div></li>
					<li><span class="wish-store">&nbsp;</span>Check with my Store</li>
					<li><span class="wish-remove">&nbsp;</span>Remove Items</li>
					<li><button class="orange-button">Add Items to Cart</button></li>
				</ul>

				<div class="wishlist-heading">
					<div class="wishlist-heading wishlist-select">Select</div>
					<div class="wishlist-heading wishlist-description">Description</div>
					<div class="wishlist-heading wishlist-price">Price</div>
					<div class="wishlist-heading wishlist-add-date">Added On</div>
					<div class="wishlist-heading wishlist-item-options">&nbsp;</div>
				</div>
				<div class="wishlist-item">
					<div class="wishlist-select">
						<input type="checkbox" id="wish1">
						<span class="wishlist-itms"><img src="../img/chairs.jpg" ></span></div>
					<div class="wishlist-description">
						<div><strong>Bijou Premier Stationary Chair</strong></div>
						<div><span>Cover:</span> Mariner (B968405)</div>
					</div>
					<div class="wishlist-price">
						<div class="reg-price">$799.00</div>
						<div class="price-red">$609.00</div>
					</div>
					<div class="wishlist-add-date">2014-07-15</div>
					<div class="wishlit-icon wishlist-item-options">
						<a href="#"><span class="wish-addcart">&nbsp;</span>Add Item to Cart</a>
						<a href="#"><span class="wish-remve">&nbsp;</span>Remove</a>
						<a href="#"><span class="wish-sharitm">&nbsp;</span>Share Item</a>
					</div>
				</div>
				<div class="wishlist-item">
					<div class="wishlist-select">
						<input type="checkbox" id="wish2">
						<span class="wishlist-itms"><img src="../img/lancer-chairs.jpg" ></span></div>
					<div class="wishlist-description">
						<div><strong>Lancer Reclina-Rocker&reg; Recliner</strong></div>
						<div><span>Cover:</span> Acorn(RD103768)</div>
					</div>
					<div class="wishlist-price">
						<div class="reg-price">$819.00</div>
						<div class="price-red">$619.00</div>
					</div>
					<div class="wishlist-add-date">2014-07-15</div>
					<div class="wishlit-icon wishlist-item-options">
						<a href="#"><span class="wish-addcart">&nbsp;</span>Add Item to Cart</a>
						<a href="#"><span class="wish-remve">&nbsp;</span>Remove</a>
						<a href="#"><span class="wish-sharitm">&nbsp;</span>Share Item</a>
					</div>
				</div>
				<div class="wishlist-item">
					<div class="wishlist-select">
						<input type="checkbox" id="wish3">
						<span class="wishlist-itms"><img src="../img/dephne-chairs.jpg" ></span></div>
					<div class="wishlist-description">
						<div><strong>Daphne La-Z-Boy Premier Supreme-Comfort Twin Sleeper</strong></div>
						<div><span>Cover:</span> Red (B127306)</div>
						<div><span>Pillow:</span> Red (B127306)</div>
					</div>
					<div class="wishlist-price">
						<div class="reg-price">$1,529.00</div>
						<div class="price-red">$1,169.00</div>
					</div>
					<div class="wishlist-add-date">2014-07-15</div>
					<div class="wishlit-icon wishlist-item-options">
						<a href="#"><span class="wish-addcart">&nbsp;</span>Add Item to Cart</a>
						<a href="#"><span class="wish-remve">&nbsp;</span>Remove</a>
						<a href="#"><span class="wish-sharitm">&nbsp;</span>Share Item</a>
					</div>
				</div>

					<div class="wishlist-but wishlist-link">
						<a href="#">Continue Shopping</a>
						<span>
							<button class="yellow-button">Print Wishlist</button>
							<button class="orange-button">Add All to Shopping Cart</button>
						</span>
					</div>

				</div>

            </section>

        </main>
	</lzb:pageContainer>
</dsp:page>