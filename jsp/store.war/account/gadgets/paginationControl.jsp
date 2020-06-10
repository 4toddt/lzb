<dsp:page>

	<!-- all imports goes here -->
	
	
	<!-- all default values here -->
	<dsp:getvalueof var="pageSize" value="${defaultPageSize}" />
	<dsp:getvalueof id="howMany" param="howMany" />
	<dsp:getvalueof id="start" param="arrayStarts" />
	<dsp:getvalueof id="viewAll" param="viewAll" />

	<c:if test="${empty start && !viewAll}">
		<c:set var="start" value="1" />
	</c:if>

	<c:if test="${empty pageSize}">
		<c:set var="pageSize" value="1" />
	</c:if>

	<c:if test="${empty howMany}">
		<c:set var="howMany" value="1" />
	</c:if>
	
	<dsp:getvalueof var="howManyToDisplay" param="numOrders" /> 
	<dsp:getvalueof var="size" param="totalCount" />


	<c:if test="${size > howManyToDisplay}">
		<!-- pagination-->		
		<c:choose>
			<c:when test="${size lt (start + howManyToDisplay)}">
				<c:choose>
					<c:when test="${start eq size}">
						Displaying ${start} of ${size} orders
					</c:when>
					<c:otherwise>
						Displaying ${start}-${(start + (size % howManyToDisplay))-1} of ${size} orders
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>			   
			   Displaying ${start}-${howManyToDisplay} of ${size} orders			   
		    </c:otherwise>
		</c:choose>
		
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>Page&nbsp;</span>
		
		
		<dsp:include page="${pageContext.request.contextPath}/includes/global/pagination.jsp">
			<!-- change this accordingly, to change the no of orders to display -->
			<dsp:param name="perPage" value="${howManyToDisplay}" />
			<dsp:param name="howMany" value="${size}" />
		</dsp:include>
	</c:if>
	<c:if test="${size <= howManyToDisplay}">
	    <c:choose>
				<c:when test="${start eq size}">
					Displaying ${start} of ${size} orders
				</c:when>
				<c:otherwise>
				   Displaying ${start}-${size} of ${size} orders
				</c:otherwise>
		</c:choose>		
	</c:if>
</dsp:page>