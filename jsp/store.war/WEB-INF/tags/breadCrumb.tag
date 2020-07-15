<%--
  Tag using the YCBreadCrumbDroplet to create breadcrumbs on non Endeca pages.
  e.g. account pages.

  Required attributes:
  pageKey
    The key used for getting the breadcrumb structure.

  Optional attributes:
  separator
    Used for separating breadcrumb values.
  valueParam
  	Used for passing additional parameter values like orderId.
  divClass
  	Class name that will be used in the div tag.

  Usage:
    <yc:breadCrumb pageKey={key} separator={separator} valueParam={valueParam} />

  Example:
  	<yc:breadCrumb pageKey="editAddr" />
  	<yc:breadCrumb pageKey="editAddr" separator=">" />
  	<yc:breadCrumb pageKey="editAddr" separator=">" divClass="breadCrumb" />
  	<yc:breadCrumb pageKey="editAddr" separator=">" valueParam="o210014" />
--%>

<%@include file="/global/includes/taglibs.jspf"%>
<%@include file="/includes/context.jspf"%>

<%@attribute name="pageKey" required="true" %>
<%@attribute name="separator" %>
<%@attribute name="valueParam" %>
<%@attribute name="divClass" %>

<dsp:importbean bean="/com/lzb/navigation/LZBBreadCrumbDroplet"/>
<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
<dsp:getvalueof param="orderId" var="orderId"/>

<dsp:droplet name="LZBBreadCrumbDroplet">
	<dsp:param name="pageKey" value="${pageKey}" />
	<dsp:param name="contextRoot" value="${pageContext.request.contextPath}" />
	<dsp:oparam name="output">
		<dsp:droplet name="ForEach">
			<dsp:param name="array" param="pageBreadCrumb" />
			<dsp:oparam name="outputStart">
				<nav aria-label="breadcrumb" role="navigation" class="breadcrumb-wrapper">
					<ul>
			</dsp:oparam>
			<dsp:oparam name="output">
				<dsp:getvalueof var="breadCrumbName" param="element.breadCrumbName" />
				<dsp:getvalueof var="url" param="element.url" />
				<li>
					<c:choose>
						<c:when test="${empty url}">
							<fmt:message key="${breadCrumbName}">
								<c:if test="${not empty valueParam}">
									<fmt:param value="${valueParam}"/>
								</c:if>
							</fmt:message> ${orderId}
						</c:when>
						<c:otherwise>
							<a href="${ url}"><fmt:message key="${breadCrumbName}"/></a>
						</c:otherwise>
					</c:choose>
				</li>
			</dsp:oparam>
			<dsp:oparam name="outputEnd">
					</ul>
				</nav>
  		</dsp:oparam>
		</dsp:droplet>
	</dsp:oparam>
</dsp:droplet>
