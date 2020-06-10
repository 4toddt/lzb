<dsp:page>
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:getvalueof var="transient" bean="Profile.transient" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:getvalueof var="styleFinderBaseURL"value="${storeConfig.styleFinderBaseURL}"/>
	<dsp:getvalueof var="styleFinderClientURL"value="${storeConfig.styleFinderClientURL}"/>
	<dsp:getvalueof var="customizeIt"value="${storeConfig.customizeIt}"/>
	
	<dsp:getvalueof var="menu" param="isMenu"/>

	<dsp:include src="/browse/createNPCUrl.jsp">
		<dsp:param name="catId" value="${customizeIt}" />
	</dsp:include>

	<li>
		<a href="${contextPath}/content/DesignInspirations/StyleFinder" title="style finder" ><fmt:message key="home.style" /><span class="icon icon-arrow-right"></span></a>
	</li>

	<li>
		<dsp:a href="${contextPath}/storeLocator/storeLocator.jsp">
			<fmt:message key="home.locator" /><span class="icon icon-arrow-right"></span>
		</dsp:a>
	</li>
	<li>
		<dsp:a href="${contextPath}/order/anonymousOrders.jsp">
			<fmt:message key="home.online" /><span class="icon icon-arrow-right"></span>
		</dsp:a>
	</li>
	<c:if test="${menu == 'false'}">
		<li>
			<dsp:a href="${contextPath}/content/CustomerCare/contactus"><fmt:message key="home.contact" /><span class="icon icon-arrow-right"></span></dsp:a>
		</li>
		<c:choose>
			<c:when test="${ transient eq 'false' }" >
				<!-- user logged in -->
				<li>
					<dsp:a href="${contextPath}/account/account.jsp"><fmt:message key="headerAcntMenu.myAcount" /><span class="icon icon-arrow-right"></span></dsp:a>
				</li>
			</c:when>
			<c:otherwise>
				<li>
					<dsp:a href="${contextPath}/account/register.jsp"><fmt:message key="create.account" /><span class="icon icon-arrow-right"></span></dsp:a>
				</li>
				<li>
					<dsp:a href="${contextPath}/account/login.jsp">
						<fmt:message key="register.signin" /><span class="icon icon-arrow-right"></span>
						<dsp:param name="pageType" value="loginPage"/>
					</dsp:a>
				</li>
			</c:otherwise>
		</c:choose>
	</c:if>
	<c:if test="${menu == 'true'}">
		<li>
			<dsp:a href="${contextPath}/content/CustomerCare/contactus"><fmt:message key="home.contact" /><span class="icon icon-arrow-right"></span></dsp:a>
		</li>
		<li>
			<b><fmt:message key="home.lzb" /></b>
		</li>
		<dsp:include src="/account/includes/headerAccountMenu.jsp"/>
	</c:if>
</dsp:page>