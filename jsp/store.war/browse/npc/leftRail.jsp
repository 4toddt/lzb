<dsp:page>
	<dsp:importbean bean="/atg/repository/seo/ContentItemLink" />
	<dsp:getvalueof param="selectedPage" var="selectedPage" />
	<dsp:getvalueof param="categoryPage" var="categoryPage" />
	<nav role="navigation" class="account secondary-nav">

			<h2 class="nav-heading-title">   
				${fn:toUpperCase(categoryPage.name)}
			</h2>
			<c:if test="${not empty categoryPage.childPages }">
				<ul>
					<c:forEach items="${categoryPage.childPages }" var="childPage">
						<li class="nav-item">
							<c:if test="${selectedPage eq childPage }">
							</c:if>
							<a href="${pageContext.request.contextPath}/content/${empty categoryPage.seoName?categoryPage.id:categoryPage.seoName  }/${empty childPage.seoName?childPage.id:childPage.seoName }">
								${childPage.name }
							</a>
							<c:if test="${selectedPage eq childPage }">
								</b>
							</c:if>
						</li>
					</c:forEach>
				</ul>
			</c:if>

			<div class="vcard">
				<dsp:include page="userStoreDetails.jsp"></dsp:include>
			</div>

	</nav>

</dsp:page>