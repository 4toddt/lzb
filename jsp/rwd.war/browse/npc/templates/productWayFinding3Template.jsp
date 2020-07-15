<dsp:page>

	<dsp:getvalueof var="templateItem" param="templateItem" />
	<dsp:getvalueof var="heroImages" value="${templateItem.heroImages}" />
	<dsp:getvalueof var="features" value="${templateItem.features}" />
	
	<c:if test="${not empty heroImages}">
		<c:forEach items="${heroImages}" var="heroImageItem">
			<img src="${heroImageItem.heroImage.url}" alt="${heroImageItem.heroCaption}" title="" /> 
        </c:forEach>
	</c:if>
	<c:if test="${not empty features}">
		<div class="cust-contant" data-module="cbox">
			<c:forEach items="${features}" var="feature">
				<div class="hme-design" >
					<img src="${feature.image.url}" />
					<p><strong>${feature.subTitle}</strong></p>
					${feature.contentBlock}
					<c:if test="${not empty feature.linkURL}">
						<p>
						<c:choose>
							<c:when test="${fn:contains(feature.linkURL, 'youtube')}">
								
								<a href="${feature.linkURL}" class="youtube">${feature.linkText}</a>      
							</c:when>
		
							<c:otherwise>
								<a class="cboxElement" data-href="${feature.linkURL}">${feature.linkText}</a>
							</c:otherwise>
						</c:choose>
						</p>
					</c:if>
				</div>
				<div class="alert-modal"></div>

			</c:forEach>
			
		</div>
	</c:if>
	
	
			<script>
			function delayStart(){

				$('.cboxElement').colorbox({
					height: 120,
					html: function(){
						var url = $(this).attr('data-href');
						return '<div style="margin: 0 10px;"><p>This link will redirect you to the desktop version of the site. Would you like to proceed?</p><p><a href="' + url + '" class="orange-button" style="padding: 5px; margin-right: 10px" >Yes</a> <a onclick="parent.$.colorbox.close(); return false;" class="orange-button" style="padding: 5px" >No</a></p></div>'
					},
					closeButton : false
				});
			}
			window.onload = function () {
				window.setTimeout(delayStart,5000);
			};
			</script>
</dsp:page>