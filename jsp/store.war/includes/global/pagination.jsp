
<dsp:importbean bean="/atg/dynamo/droplet/Range" />
<dsp:importbean bean="/atg/dynamo/droplet/Compare" />
<dsp:importbean bean="/com/lzb/droplet/LZBPaginationDroplet" />
<dsp:page>
					
	<dsp:getvalueof var="howMany" param="howMany"  idtype="java.lang.Integer"/>
	<dsp:getvalueof var="pageNumber" param="pageNumber"  idtype="java.lang.Integer">
	<dsp:getvalueof var="perPage" param="perPage" idtype="java.lang.Integer" />
	<dsp:getvalueof var="page" param="page" idtype="java.lang.String" />
	<dsp:droplet name="/atg/dynamo/droplet/IsNull">
		<dsp:param name="value" value="${pageNumber}" />
		<dsp:oparam name="true">
			<dsp:getvalueof var="pageNumber" value="1"  idtype="java.lang.Integer"/>	
		</dsp:oparam>
	</dsp:droplet>
		<dsp:droplet name="LZBPaginationDroplet">
		<dsp:param name="howMany" value="${howMany}"/>
		<dsp:param name="pageNumber" value="${pageNumber}"/>
		<dsp:param name="perPage" value="${perPage}"/>
			<dsp:oparam name="hasPrevOn">
				<dsp:a iclass="numbers" href="${pageContext.request.requestURI}?page=${page}">
					&lt; &nbsp;
					<dsp:param name="howMany" value="${howMany}"/>
					<dsp:param name="pagination" value="true"/>
					<dsp:param name="perPage" value="${perPage}"/>
					<dsp:param name="arrayStarts" value="${(perPage *(pageNumber - 2)) + 1}"/>
					<dsp:param name="pageNumber" value="${pageNumber - 1}"/>
				</dsp:a>
				<dsp:a iclass="numbers" href="${pageContext.request.requestURI}?page=${page}">
					Prev&nbsp;&nbsp;
					<dsp:param name="howMany" value="${howMany}"/>
					<dsp:param name="pagination" value="true"/>
					<dsp:param name="perPage" value="${perPage}"/>
					<dsp:param name="arrayStarts" value="${(perPage *(pageNumber - 2)) + 1}"/>
					<dsp:param name="pageNumber" value="${pageNumber - 1}"/>
				</dsp:a>
				
			</dsp:oparam>
			<dsp:oparam name="hasPrevOff">
			 	
			</dsp:oparam>
			<dsp:oparam name="firstCount">
			 	<dsp:a iclass="numbers" href="${pageContext.request.requestURI}?page=${page}" >
					<dsp:param name="howMany" value="${howMany}"/>
					<dsp:param name="perPage" value="${perPage}"/>
					<dsp:param name="arrayStarts" value="1"/>
					<dsp:param name="pageNumber" value="1"/>
					<dsp:param name="pagination" value="true"/>
					1</span>						
				</dsp:a>&nbsp;...
			</dsp:oparam>
			<dsp:oparam name="output">
			<dsp:getvalueof id="pagecount" param="count" idtype="java.lang.Integer"/>
			<c:choose>
			<c:when test="${ pagecount eq pageNumber }">
					<strong><dsp:valueof param="count"/></strong>&nbsp;
			</c:when>
			<c:otherwise>
				<dsp:a iclass="numbers" href="${pageContext.request.requestURI}?page=${page}" >
					
					<dsp:param name="howMany" value="${howMany}"/>
					<dsp:param name="perPage" value="${perPage}"/>
						<c:choose>
						<c:when test="${ pagecount eq 1 }">
								<dsp:param name="arrayStarts" value="1"/>
						</c:when>
						<c:when test="${ pagecount eq 2 }">
								<dsp:param name="arrayStarts" value="${perPage+1}"/>
						</c:when>
						<c:when test="${ pagecount gt 2 }">
								<dsp:param name="arrayStarts" value="${(perPage *(pagecount - 1)) + 1}"/>
						</c:when>
						</c:choose>
					<dsp:param name="pagination" value="true"/>
					<dsp:param name="pageNumber" value="${pagecount}"/>
					<dsp:valueof param="count"/>
					&nbsp;
				</dsp:a>
			</c:otherwise>
			</c:choose>
			</dsp:oparam>
			<dsp:oparam name="lastCount">
			<dsp:getvalueof id="totalCount" param="totalPage" idtype="java.lang.Integer"/>
			 	&nbsp;...<dsp:a iclass="numbers" href="${pageContext.request.requestURI}?page=${page}">
					<dsp:param name="howMany" value="${howMany}"/>
					<dsp:param name="pagination" value="true"/>
					<dsp:param name="perPage" value="${perPage}"/>
					<dsp:param name="arrayStarts" value="${(perPage*(totalCount -1)) +1}"/>
					<dsp:param name="pageNumber" value="${totalCount}"/>
					<dsp:valueof param="totalPage"/>
				</dsp:a>
			</dsp:oparam>
			<c:choose>
				<c:when test="${pageNumber ge 5}">
					<dsp:oparam name="hasNextOn">
						<dsp:a iclass="numbers" href="${pageContext.request.requestURI}?page=${page}" >
							...&nbsp;&nbsp;
							<dsp:param name="howMany" value="${howMany}"/>
							<dsp:param name="perPage" value="${perPage}"/>
							<dsp:param name="pagination" value="true"/>
							<dsp:param name="arrayStarts" value="${(perPage * pageNumber) +1}"/>
							
							<dsp:param name="pageNumber" value="${pageNumber +1}"/>
						</dsp:a>
						<dsp:a iclass="numbers" href="${pageContext.request.requestURI}?page=${page}" >
							Next	
							<dsp:param name="howMany" value="${howMany}"/>
							<dsp:param name="perPage" value="${perPage}"/>
							<dsp:param name="pagination" value="true"/>
							<dsp:param name="arrayStarts" value="${(perPage * pageNumber) +1}"/>
							
							<dsp:param name="pageNumber" value="${pageNumber +1}"/>
						</dsp:a>
						<dsp:a iclass="numbers" href="${pageContext.request.requestURI}?page=${page}" >
							 &nbsp;&gt;	
							<dsp:param name="howMany" value="${howMany}"/>
							<dsp:param name="perPage" value="${perPage}"/>
							<dsp:param name="pagination" value="true"/>
							<dsp:param name="arrayStarts" value="${(perPage * pageNumber) +1}"/>
							
							<dsp:param name="pageNumber" value="${pageNumber +1}"/>
						</dsp:a>
					</dsp:oparam>
				</c:when>
				<c:otherwise>
				    <dsp:oparam name="hasNextOn">
						<dsp:a iclass="numbers" href="${pageContext.request.requestURI}?page=${page}" >
							&nbsp;&nbsp;
							<dsp:param name="howMany" value="${howMany}"/>
							<dsp:param name="perPage" value="${perPage}"/>
							<dsp:param name="pagination" value="true"/>
							<dsp:param name="arrayStarts" value="${(perPage * pageNumber) +1}"/>
							
							<dsp:param name="pageNumber" value="${pageNumber +1}"/>
						</dsp:a>
						<dsp:a iclass="numbers" href="${pageContext.request.requestURI}?page=${page}" >
							Next	
							<dsp:param name="howMany" value="${howMany}"/>
							<dsp:param name="perPage" value="${perPage}"/>
							<dsp:param name="pagination" value="true"/>
							<dsp:param name="arrayStarts" value="${(perPage * pageNumber) +1}"/>
							
							<dsp:param name="pageNumber" value="${pageNumber +1}"/>
						</dsp:a>
						<dsp:a iclass="numbers" href="${pageContext.request.requestURI}?page=${page}" >
							 &nbsp;&gt;	
							<dsp:param name="howMany" value="${howMany}"/>
							<dsp:param name="perPage" value="${perPage}"/>
							<dsp:param name="pagination" value="true"/>
							<dsp:param name="arrayStarts" value="${(perPage * pageNumber) +1}"/>
							
							<dsp:param name="pageNumber" value="${pageNumber +1}"/>
						</dsp:a>
					</dsp:oparam>
				</c:otherwise>
			</c:choose>
			<dsp:oparam name="hasNextOff">
				<span> 
											
				</span>						
			</dsp:oparam>
		</dsp:droplet>
	
	</dsp:getvalueof>
	
</dsp:page>