
<dsp:importbean bean="/atg/dynamo/servlet/RequestLocale" />
<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />

<dsp:layeredBundle basename="com.lzb.common.WebAppResources">
	<dsp:getvalueof var="activeTab" param="selpage" />

	<nav role="navigation" class="account secondary-nav">
		<dsp:importbean bean="/atg/dynamo/servlet/RequestLocale" />
		<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />

		<div class="nav-title">Design Inspirations</div>
		<ul>
			<c:choose>
				<c:when test="${activeTab == 'ROOM_INSPIRATIONS'}">
					<li class="nav-item current">
				</c:when>
				<c:otherwise>
					<li class="nav-item">
				</c:otherwise>
			</c:choose>
			<a href="/customercare/designInspirations/roomInspirations.jsp">Room Inspirations</a>
			</li>
			<c:choose>
				<c:when test="${activeTab == 'ROOM_PLANNER'}">
					<li class="nav-item current"><b>${prefStore}</b>
				</c:when>
				<c:otherwise>
					<li class="nav-item">
				</c:otherwise>
			</c:choose>
			<a href="/customercare/designInspirations/roomPlanner.jsp">3D Room Planner</a>
			</li>
			<c:choose>
				<c:when test="${activeTab == 'STYLE_FINDER'}">
					<li class="nav-item current">
				</c:when>
				<c:otherwise>
					<li class="nav-item">
				</c:otherwise>
			</c:choose>
			<a href="/customercare/designInspirations/styleFinder.jsp">Style Finder</a>
			</li>

			<c:choose>
				<c:when test="${activeTab == 'ROOM_MEASURING'}">
					<li class="nav-item current">
				</c:when>
				<c:otherwise>
					<li class="nav-item">
				</c:otherwise>
			</c:choose>
			<a href="/customercare/designInspirations/roomMeasuring.jsp">Room Measuring</a>
			</li>

			<c:choose>
				<c:when test="${activeTab == 'HOME_DESIGN'}">
					<li class="nav-item current">
				</c:when>
				<c:otherwise>
					<li class="nav-item">
				</c:otherwise>
			</c:choose>
			<a href="/customercare/designInspirations/homeDesign.jsp">Free In-Home Design</a>
			</li>
		</ul>
	</nav>

</dsp:layeredBundle>