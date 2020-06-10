<dsp:page>
   			<dsp:getvalueof var="listPrice" param="listPrice"  vartype="java.lang.Double"/>
			<dsp:getvalueof var="salePrice" param="salePrice"  vartype="java.lang.Double"/>
			
			<c:choose>
				<c:when test="${not empty salePrice and salePrice ne 0.00}"> 
					<span class="strike-thru">
					<dsp:include page="../../global/includes/formattedPrice.jsp">
						<dsp:param name="price" value="${listPrice}" />
					</dsp:include>
					</span><br />
					<span class="sale-price">
					<dsp:include page="../../global/includes/formattedPrice.jsp">
						<dsp:param name="price" value="${salePrice}" />
					</dsp:include>
					</span>
				</c:when>
				<c:otherwise>
					<span>
					<dsp:include page="../../global/includes/formattedPrice.jsp">
						<dsp:param name="price" value="${listPrice}" />
					</dsp:include>
					</span>
				</c:otherwise>
			</c:choose>
</dsp:page>