<dsp:page>
	<lzb:pageContainer>

		<jsp:attribute name="bodyClass">npc</jsp:attribute>

		<jsp:attribute name="title"><fmt:message key="dashboard.orderHistory"/></jsp:attribute>
		<dsp:layeredBundle basename="com.lzb.common.WebAppResources">
		<lzb:breadCrumb pageKey="breadcrumb.orderHistory"
			divClass="breadcrumb" />

		<main role="main">
		<dsp:include page="/includes/leftnavigation.jsp">
					        <dsp:param name="selpage" value="ORDERHISTORY" />
					      </dsp:include>

		<section role="region" class="my-account-content">

			<h1><fmt:message key="dashboard.orderHistory"/></h1>
			<div class="order-history">
				<div class="order-history-table">
					<table>
						<tbody>
							<tr>
								<td>
									<div>
										<!-- order history content -->
										<dsp:include
											src="${pageContext.request.contextPath}/account/gadgets/myOrders.jsp" />
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>

		</section>

		</main>
	</dsp:layeredBundle>
	</lzb:pageContainer>

</dsp:page>
