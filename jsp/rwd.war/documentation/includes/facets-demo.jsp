<%--
    - File Name: facets-demo.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page lays out the facets for the product listing pages.
    - Required Parameters:
    - Optional Parameters:
--%>
<dsp:page>
	<%-- features selection --%>
    <div class="features-selection">
        <div class="features-selection-menu dropdown" data-dropdown>
            <a href="" class="dropdown-toggle" id="features-menu">
                <h1>Recliners</h1>
                <span class="icon icon-arrow-down" aria-hidden="true"></span>
            </a>
            <div class="dropdown-menu">
                <ul class="menu-list" role="menu" aria-labelledby="features-menu">
                    <li role="presentation"><a role="menuitem" href="#">Power</a></li>
                    <li role="presentation"><a role="menuitem" href="#">High Leg</a></li>
                    <li role="presentation"><a role="menuitem" href="#">duo&reg;</a></li>
                    <li role="presentation"><a role="menuitem" href="#">Rocking</a></li>
                    <li role="presentation"><a role="menuitem" href="#">Wall Recliner</a></li>
                    <li role="presentation"><a role="menuitem" href="#">Swivel</a></li>
                </ul>
            </div>
        </div>
        <p class="features-description">Not only did we invent the recliner, we're reinventing it every single day.</p>
    </div>

	<div class="facet-sidebar">
		<%-- offCanvas heading --%>
		<div class="off-canvas-heading">
			<div class="heading">
				Filter
				<span class="product-results-count">(<span class="result-count">111</span> Items)</span>
			</div>
			<a href="javascript:void(0);" class="close-off-canvas-link">
				<span class="icon icon-close" aria-hidden="true"></span>
				<span class="sr-only">close menu</span>
			</a>
		</div>
		<%-- Filters --%>
		<div class="filters" data-filters>
			<%-- START: facet menu --%>
			<div class="facet-menu">
				<div class="filters-list-container accordion facet-group" data-accordion aria-multiselectable="false">
					<%-- Facet: Style --%>
					<div class="accordion-container">
						<div class="facet-title accordion-title selected" role="tab" aria-controls="style-facet-body" id="style-facet-title" tabindex="0">
							<div class="facet-title-label">
								<div class="facet-title-name">Style</div>
								<div class="selected-facets">One, Two, Three</div>
							</div>
							<span class="icon icon-arrow-down"></span>
						</div>
						<div class="facet-body accordion-body" aria-labeledby="style-facet-title" role="tabpanel" id="style-facet-body">
							<div class="accordion-body-content">
								<div class="facet-list" data-dim="facet-list-1">
									<div class="facet custom-checkbox" data-id="stylefacet1" data-nstate="/store/browse/category.jsp?nstate=style1" data-cat="style-cat" >
										<input id="sfacet1" type="checkbox" name="style" value="sone"/>
										<label for="sfacet1">One <span class="ref-count">(45)</span></label>
									</div>
									<div class="facet custom-checkbox" data-id="stylefacet2" data-nstate="/store/browse/category.jsp?nstate=style2" data-cat="style-cat" >
										<input id="sfacet2" type="checkbox" name="style" value="stwo"/>
										<label for="sfacet2">Two <span class="ref-count">(45)</span></label>
									</div>
									<div class="facet custom-checkbox" data-id="stylefacet3" data-nstate="/store/browse/category.jsp?nstate=style3" data-cat="style-cat" >
										<input id="sfacet3" type="checkbox" name="style" value="sthree"/>
										<label for="sfacet3">Three <span class="ref-count">(45)</span></label>
									</div>
									<div class="facet custom-checkbox" data-id="stylefacet4" data-nstate="/store/browse/category.jsp?nstate=style4" data-cat="style-cat" >
										<input id="sfacet4" type="checkbox" name="style" value="sfour"/>
										<label for="sfacet4">Four <span class="ref-count">(45)</span></label>
									</div>
									<div class="facet custom-checkbox unavailable" data-id="stylefacet5" data-nstate="/store/browse/category.jsp?nstate=style5" data-cat="style-cat" >
										<input id="sfacet5" type="checkbox" name="style" value="sfive"/>
										<label for="sfacet5">Five <span class="ref-count">(45)</span></label>
									</div>
								</div>
							</div>
						</div>
					</div>

					<%-- Facet: Price --%>
					<div class="accordion-container">
						<div class="facet-title accordion-title" role="tab" aria-controls="price-facet-body" id="price-facet-title" tabindex="0">
							<div class="facet-title-label">
								<div class="facet-title-name">Price</div>
								<div class="selected-facets"></div>
							</div>
							<span class="icon icon-arrow-down"></span>
						</div>
						<div class="facet-body accordion-body" aria-labeledby="price-facet-title" role="tabpanel" id="price-facet-body">
							<div class="accordion-body-content">
								<div class="facet-list" data-dim="facet-list-2">
									<div class="facet custom-checkbox" data-id="pricefacet1" data-nstate="/store/browse/category.jsp?nstate=price1" data-cat="price-cat" >
										<input id="pfacet1" type="checkbox" name="price" value="pone"/>
										<label for="pfacet1">One <span class="ref-count">(45)</span></label>
									</div>
									<div class="facet custom-checkbox" data-id="pricefacet2" data-nstate="/store/browse/category.jsp?nstate=price2" data-cat="price-cat" >
										<input id="pfacet2" type="checkbox" name="price" value="ptwo"/>
										<label for="pfacet2">Two <span class="ref-count">(45)</span></label>
									</div>
									<div class="facet custom-checkbox" data-id="pricefacet3" data-nstate="/store/browse/category.jsp?nstate=price3" data-cat="price-cat" >
										<input id="pfacet3" type="checkbox" name="price" value="pthree"/>
										<label for="pfacet3">Three <span class="ref-count">(45)</span></label>
									</div>
									<div class="facet custom-checkbox" data-id="pricefacet4" data-nstate="/store/browse/category.jsp?nstate=price4" data-cat="price-cat" >
										<input id="pfacet4" type="checkbox" name="price" value="pfour"/>
										<label for="pfacet4">Four <span class="ref-count">(45)</span></label>
									</div>
									<div class="facet custom-checkbox unavailable" data-id="pricefacet5" data-nstate="/store/browse/category.jsp?nstate=price5" data-cat="price-cat" >
										<input id="pfacet5" type="checkbox" name="price" value="pfive"/>
										<label for="pfacet5">Five <span class="ref-count">(45)</span></label>
									</div>
								</div>
							</div>
						</div>
					</div>

					<%-- Facet: Material --%>
					<div class="accordion-container">
						<div class="facet-title accordion-title selected" role="tab" aria-controls="material-facet-body" id="material-facet-title" tabindex="0">
							Material <span class="icon icon-arrow-down"></span>
							<div class="selected-facets">One, Two, Three</div>
						</div>
						<div class="facet-body accordion-body" aria-labeledby="material-facet-title" role="tabpanel" id="material-facet-body">
							<div class="accordion-body-content">
								<div class="facet-list" data-dim="facet-list-3">
									<div class="facet custom-checkbox" data-id="materialfacet1" data-nstate="/store/browse/category.jsp?nstate=material1" data-cat="material-cat" >
										<input id="mfacet1" type="checkbox" name="material" value="mone"/>
										<label for="mfacet1">One <span class="ref-count">(45)</span></label>
									</div>
									<div class="facet custom-checkbox" data-id="materialfacet2" data-nstate="/store/browse/category.jsp?nstate=material2" data-cat="material-cat" >
										<input id="mfacet2" type="checkbox" name="material" value="mtwo"/>
										<label for="mfacet2">Two <span class="ref-count">(45)</span></label>
									</div>
									<div class="facet custom-checkbox" data-id="materialfacet3" data-nstate="/store/browse/category.jsp?nstate=material3" data-cat="material-cat" >
										<input id="mfacet3" type="checkbox" name="material" value="mthree"/>
										<label for="mfacet3">Three <span class="ref-count">(45)</span></label>
									</div>
									<div class="facet custom-checkbox" data-id="materialfacet4" data-nstate="/store/browse/category.jsp?nstate=material4" data-cat="material-cat" >
										<input id="mfacet4" type="checkbox" name="material" value="mfour"/>
										<label for="mfacet4">Four <span class="ref-count">(45)</span></label>
									</div>
									<div class="facet custom-checkbox unavailable" data-id="materialfacet5" data-nstate="/store/browse/category.jsp?nstate=material5" data-cat="material-cat" >
										<input id="mfacet5" type="checkbox" name="material" value="mfive"/>
										<label for="mfacet5">Five <span class="ref-count">(45)</span></label>
									</div>
								</div>
							</div>
						</div>
					</div>

					<%-- Facet: Upgrades --%>
					<div class="accordion-container">
						<div class="facet-title accordion-title" role="tab" aria-controls="upgrades-facet-body" id="upgrades-facet-title" tabindex="0">
							<div class="facet-title-label">
								<div class="facet-title-name">Upgrades</div>
								<div class="selected-facets"></div>
							</div>
							<span class="icon icon-arrow-down"></span>
						</div>
						<div class="facet-body accordion-body" aria-labeledby="upgrades-facet-title" role="tabpanel" id="upgrades-facet-body">
							<div class="accordion-body-content">
								<div class="facet-list" data-dim="facet-list-4">
									<div class="facet custom-checkbox" data-id="upgradesfacet1" data-nstate="/store/browse/category.jsp?nstate=upgrades1" data-cat="upgrades-cat" >
										<input id="ufacet1" type="checkbox" name="upgrades" value="uone"/>
										<label for="ufacet1">One <span class="ref-count">(45)</span></label>
									</div>
									<div class="facet custom-checkbox" data-id="upgradesfacet2" data-nstate="/store/browse/category.jsp?nstate=upgrades2" data-cat="upgrades-cat" >
										<input id="ufacet2" type="checkbox" name="upgrades" value="utwo"/>
										<label for="ufacet2">Two <span class="ref-count">(45)</span></label>
									</div>
									<div class="facet custom-checkbox" data-id="upgradesfacet3" data-nstate="/store/browse/category.jsp?nstate=upgrades3" data-cat="upgrades-cat" >
										<input id="ufacet3" type="checkbox" name="upgrades" value="uthree"/>
										<label for="ufacet3">Three <span class="ref-count">(45)</span></label>
									</div>
									<div class="facet custom-checkbox" data-id="upgradesfacet4" data-nstate="/store/browse/category.jsp?nstate=upgrades4" data-cat="upgrades-cat" >
										<input id="ufacet4" type="checkbox" name="upgrades" value="upfour"/>
										<label for="ufacet4">Four <span class="ref-count">(45)</span></label>
									</div>
									<div class="facet custom-checkbox unavailable" data-id="upgradesfacet5" data-nstate="/store/browse/category.jsp?nstate=upgrades5" data-cat="upgrades-cat" >
										<input id="ufacet5" type="checkbox" name="upgrades" value="ufive"/>
										<label for="ufacet5">Five <span class="ref-count">(45)</span></label>
									</div>
								</div>
							</div>
						</div>
					</div>

					<%-- Facet: Width --%>
					<div class="accordion-container">
						<div class="facet-title accordion-title" role="tab" aria-controls="width-facet-body" id="width-facet-title" tabindex="0">
							<div class="facet-title-label">
								<div class="facet-title-name">Width</div>
								<div class="selected-facets"></div>
							</div>
							<span class="icon icon-arrow-down"></span>
						</div>
						<div class="facet-body accordion-body" aria-labeledby="width-facet-title" role="tabpanel" id="width-facet-body">
							<div class="accordion-body-content">
								<div class="facet-list" data-dim="facet-list-5">
									<div class="facet custom-checkbox" data-id="widthfacet1" data-nstate="/store/browse/category.jsp?nstate=width1" data-cat="width-cat" >
										<input id="wfacet1" type="checkbox" name="width" value="wone"/>
										<label for="wfacet1">One <span class="ref-count">(45)</span></label>
									</div>
									<div class="facet custom-checkbox" data-id="widthfacet2" data-nstate="/store/browse/category.jsp?nstate=width2" data-cat="width-cat" >
										<input id="wfacet2" type="checkbox" name="width" value="wtwo"/>
										<label for="wfacet2">Two <span class="ref-count">(45)</span></label>
									</div>
									<div class="facet custom-checkbox" data-id="widthfacet3" data-nstate="/store/browse/category.jsp?nstate=width3" data-cat="width-cat" >
										<input id="wfacet3" type="checkbox" name="width" value="wthree"/>
										<label for="wfacet3">Three <span class="ref-count">(45)</span></label>
									</div>
									<div class="facet custom-checkbox" data-id="widthfacet4" data-nstate="/store/browse/category.jsp?nstate=width4" data-cat="width-cat" >
										<input id="wfacet4" type="checkbox" name="width" value="wfour"/>
										<label for="wfacet4">Four <span class="ref-count">(45)</span></label>
									</div>
									<div class="facet custom-checkbox unavailable" data-id="widthfacet5" data-nstate="/store/browse/category.jsp?nstate=width5" data-cat="width-cat" >
										<input id="wfacet5" type="checkbox" name="width" value="wfive"/>
										<label for="wfacet5">Five <span class="ref-count">(45)</span></label>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<%-- side menu actions --%>
				<div class="side-menu-actions">
					<a href="javascript:void(0);" class="apply-facets button primary">Show My Results</a>
				</div>
			</div>
			<%-- END: facet menu --%>
		</div>
	</div>
</dsp:page>