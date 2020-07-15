<dsp:page>
	<dsp:getvalueof var="creditCardType" param="creditCardType" />
	
	<c:choose>
		<c:when test="${creditCardType == 'Visa'}">
			<span class="icon icon-visa" aria-hidden="true">
				<span class="path1"></span><span class="path2"></span>
			</span>
		</c:when>
		<c:when test="${creditCardType == 'AmericanExpress'}">
			<span class="icon icon-amex" aria-hidden="true">
				<span class="path1"></span><span class="path2"></span>
			</span>
		</c:when>
		<c:when test="${creditCardType == 'MasterCard'}">
			<span class="icon icon-mastercard" aria-hidden="true">
				<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>
			</span>
		</c:when>
		<c:when test="${creditCardType == 'LZBCard'}">
			<span class="icon icon-lazboy" aria-hidden="true">
                <span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span><span class="path8"></span>
        	</span>
		</c:when>
		<c:otherwise>
		</c:otherwise>
	</c:choose>
</dsp:page>