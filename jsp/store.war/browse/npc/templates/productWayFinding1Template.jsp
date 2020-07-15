<dsp:page>
	<dsp:getvalueof var="templateItem" param="templateItem" />
	<dsp:getvalueof var="pageItem" param="page" />

	<section role="region" class="cust-support" data-template-name="productWayFinding1">
		<dsp:include page="/browse/npc/pageTitle.jsp">
			<dsp:param name="pageTitle" value="${pageItem.name}"  />
		</dsp:include>		
		<div class="cust-contant">
			<div class="customize-degn">
				<div class="laz-careimg">
					<img src="${templateItem.image1.url}" alt="${templateItem.image1.description}" />
					<a href="#" class="triangle-forwards">${templateItem.subTitle1}</a>
				</div>
				<p><dsp:valueof value="${templateItem.contentBlock1}" valueishtml="true"/></p>
				<a href="#" class="triangle-forwards">Learn more</a>
			</div>
			<div class="customize-degn">
				<div class="laz-careimg">
					<img src="${templateItem.image2.url}" alt="${templateItem.image2.description}" />
					<a href="#" class="triangle-forwards">${templateItem.subTitle2}</a>
				</div>
				<p><dsp:valueof value="${templateItem.contentBlock2}" valueishtml="true"/></p>
				<a href="#" class="triangle-forwards">Learn more</a>
			</div>
			<div class="customize-degn">
				<div class="laz-careimg">
					<img src="${templateItem.image3.url}" alt="${templateItem.image3.description}" />
					<a href="#" class="triangle-forwards">${templateItem.subTitle3}</a>
				</div>
				<p><dsp:valueof value="${templateItem.contentBlock3}" valueishtml="true"/></p>
				<a href="#" class="triangle-forwards">Learn more</a>
			</div>
			<div class="customize-degn">
				<div class="laz-careimg">
					<img src="${templateItem.image4.url}" alt="${templateItem.image4.description}" />
					<a href="#" class="triangle-forwards">${templateItem.subTitle4}</a>
				</div>
				<p>${templateItem.contentBlock4}</p>
				<a href="#" class="triangle-forwards">Learn more</a>
			</div>
		</div>
	</section>
</dsp:page>