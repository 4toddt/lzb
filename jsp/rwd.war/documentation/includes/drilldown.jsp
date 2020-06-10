<section id="drilldown-docs" class="docs-section">

	<h2>Drilldown</h2>
	<p>The drilldown nav is a navigation of nested lists into a vertical drilldown menu. It can have categories and subcategories revealed on click and each nested menu will generate a back link once intitialized.</p>
	<p>It has an auto height property which adjusts the navigation height based on each submenu height.</p>
	<p>It can be integrated in combination with the offCanvas component for a mobile side navigation.</p>
	<p>It's class structure will look something like this:</p>

	<div class="docs-example">
	<h4>Example</h4>

	<div class="drilldown-menu" data-drilldown>
    	<ul class="drilldown-list">
        	<li><a href="#">Link 0.1</a></li>
     		<li>
     			<a href="#">Link with Drilldown 0.2 <span class="icon icon-arrow-right" aria-hidden="true"></span></a>
     			<ul class="submenu">
     				<li><a href="#">Link 1.1</a></li>
     				<li>
     					<a href="#">Link with Drilldown 1.2 <span class="icon icon-arrow-right" aria-hidden="true"></span></a>
     					<ul class="submenu">
    						<li><a href="#">Link 1.2.1</a></li>
    						<li>
    							<a href="#">Link with Drilldown 1.2.2 <span class="icon icon-arrow-right" aria-hidden="true"></span></a>
	    						<ul class="submenu">
	    							<li><a href="#">Link 1.2.2.1</a></li>
	    							<li><a href="#">Link 1.2.2.2</a></li>
	    							<li><a href="#">Link 1.2.2.3</a></li>
	    							<li><a href="#">Link 1.2.2.4</a></li>
	    							<li><a href="#">Link 1.2.2.5</a></li>
	    							<li><a href="#">Link 1.2.2.6</a></li>
	    						</ul>
    						</li>
    						<li><a href="#">Link 1.2.3</a></li>
    						<li><a href="#">Link 1.2.4</a></li>
    					</ul>
    				</li>
    			</ul>
    		</li>
      		<li><a href="#">Link 0.3</a></li>
    	</ul>
    </div>

	<h4 >HTML</h4>
	<format:prettyPrint>
		<jsp:attribute name="htmlString">
			<div class="drilldown-menu" data-drilldown>
		    	<ul class="drilldown-list">
		        	<li><a href="#">Link 0.1</a></li>
		     		<li>
		     			<a href="#">Link with Drilldown 0.2 <span class="icon icon-arrow-right" aria-hidden="true"></span></a>
		     			<ul class="submenu">
		     				<li><a href="#">Link 1.1</a></li>
		     				<li>
		     					<a href="#">Link with Drilldown 1.2 <span class="icon icon-arrow-right" aria-hidden="true"></span></a>
		     					<ul class="submenu">
		    						<li><a href="#">Link 1.2.1</a></li>
		    						<li>
		    							<a href="#">Link with Drilldown 1.2.2 <span class="icon icon-arrow-right" aria-hidden="true"></span></a>
			    						<ul class="submenu">
			    							<li><a href="#">Link 1.2.2.1</a></li>
			    							<li><a href="#">Link 1.2.2.2</a></li>
			    							<li><a href="#">Link 1.2.2.3</a></li>
			    							<li><a href="#">Link 1.2.2.4</a></li>
			    							<li><a href="#">Link 1.2.2.5</a></li>
			    							<li><a href="#">Link 1.2.2.6</a></li>
			    						</ul>
		    						</li>
		    						<li><a href="#">Link 1.2.3</a></li>
		    						<li><a href="#">Link 1.2.4</a></li>
		    					</ul>
		    				</li>
		    			</ul>
		    		</li>
		      		<li><a href="#">Link 0.3</a></li>
		    	</ul>
		    </div>
		</jsp:attribute>
	</format:prettyPrint>
</section>