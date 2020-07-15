<%--
  Tag that acts as a container for all top level pages, including all relevant
  header, footer and nav elements.
  The body of this tag should include any required gadgets.

  If any of the divId, titleKey or textKey attributes are set, then the
  pageIntro gadget will be included.  If none of these attributes are
  specified, then the pageIntro gadget will not be included.

  This tag accepts the following attributes

  bodyClass (optional) - class name that will be used in the page's <body> tag.

  contentClass (optional) - class name that will be used for the page's 'content' <div> tag.

  index (optional) - indexing instruction passed to robot <meta> tag, takes "true|false"
                     value and specifies whether a page should be indexed by search robots,
           	         "true" is default

  follow (optional) - indexing instruction passed to robot <meta> tag, takes "true|false"
                      value and specifies whether a page should be followed by search robots,
                      "true" is default

  The tag accepts the following fragments

  SEOTagRenderer - define a fragment that will render SEO meta tags.
                  If required, use as
                    <jsp:attribute name="SEOTagRenderer">
                      ....
                    </jsp:attribute>

  pageSpecificJS/CSS - define a fragment that will add page specific JS/CSS file to header
                  If required, use as
                    <jsp:attribute name="pageSpecificJS">
                      ....
                    </jsp:attribute>
--%>
<%@ include file="/global/includes/taglibs.jspf" %>
<%@ include file="/includes/context.jspf" %>

<%@ tag language="java" %>
<%@ attribute name="bodyClass" %>
<%@ attribute name="contentClass" %>
<%@ attribute name="index" %>
<%@ attribute name="follow" %>
<%@ attribute name="title" %>
<%@ attribute name="metaDescription" %>
<%@ attribute name="metaKeywords" %>
<%@ attribute name="seoAlternateURL"%>
<%@ attribute name="seoCanonicalURL"%>
<%@ attribute name="SEOTagRenderer" fragment="true"%>
<%@ attribute name="pageSpecificJS" fragment="true"%>
<%@ attribute name="pageSpecificBottomJS" fragment="true"%>
<%@ attribute name="pageSpecificCSS" fragment="true"%>
<%@ attribute name="pageSpecificMETA" fragment="true"%>

<jsp:invoke fragment="pageSpecificJS" var="pageSpecificJSContent"/>
<jsp:invoke fragment="pageSpecificBottomJS" var="pageSpecificBottomJSContent"/>
<jsp:invoke fragment="pageSpecificCSS" var="pageSpecificCSSContent"/>
<jsp:invoke fragment="pageSpecificMETA" var="pageSpecificMETAContent"/>

<c:set var="encodedSeoAlternateURL" scope="request"><c:url value="${seoAlternateURL}"/></c:set>
<c:set var="encodedSeoCanonicalURL" scope="request"><c:url value="${seoCanonicalURL}"/></c:set>

<dsp:include page="/includes/pageStart.jsp">
	<dsp:param name="bodyClass" value="${bodyClass}"/>
	<dsp:param name="index" value="${index}"/>
	<dsp:param name="follow" value="${follow}"/>
	<dsp:param name="SEOTagRendererContent" value="${SEOTagRendererContent}"/>
	<dsp:param name="pageSpecificJS" value="${pageSpecificJSContent}"/>
	<dsp:param name="pageSpecificCSS" value="${pageSpecificCSSContent}"/>
	<dsp:param name="title" value="${title}"/>
	<dsp:param name="metaDescription" value="${metaDescription}"/>
	<dsp:param name="metaKeywords" value="${metaKeywords}"/>
	<dsp:param name="pageSpecificMETA" value="${pageSpecificMETAContent}"/>
	<dsp:param name="encodedSeoAlternateURL" value="${encodedSeoAlternateURL}"/>
	<dsp:param name="encodedSeoCanonicalURL" value="${encodedSeoCanonicalURL}"/>
</dsp:include>

<jsp:doBody/>

<dsp:include page="/includes/pageEnd.jsp">
	<dsp:param name="pageSpecificBottomJS" value="${pageSpecificBottomJSContent}"/>
</dsp:include>
