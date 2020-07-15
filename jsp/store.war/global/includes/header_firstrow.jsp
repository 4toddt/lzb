<dsp:page>
	<!-- All imports  -->
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="transient" bean="Profile.transient" />


	<table>
		<tr>
			<td>
				<!-- Language --> <dsp:include src="language.jsp" />
			</td>
			<!-- For  sign in -->
			<td>
				Customize It
			</td>
			<td>
				Design Inspirations
			</td>
			<td>
				Now Featuring 
			</td>
			<td>
				<c:choose>
					<c:when test="${ transient eq 'false' }">
						<dsp:getvalueof var="firstName" bean="Profile.firstName"/>
						<c:choose >
							<c:when test="${firstName != null }">
								<c:choose >
									<c:when test="${fn:length(firstName) > 12 }">
										<c:set var="fName" value="${fn:substring(firstName,0, 12)}"/>
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
					</c:when>
					<c:otherwise>
						<dsp:a href="/account/login.jsp" title="" onclick="">
							Sign In / Create an Account
						</dsp:a>
					</c:otherwise>
				</c:choose>
			</td>
			<td>
			</td>
		</tr>
	</table>
</dsp:page>