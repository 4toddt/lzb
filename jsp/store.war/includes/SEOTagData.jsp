<dsp:page>

<dsp:getvalueof var="keyForSEOTagData" param="paramKeyForSEOTagData" />

<dsp:droplet name="/atg/dynamo/droplet/RQLQueryRange">
   <dsp:param name="repository" value="/atg/seo/SEORepository" />
   <dsp:param name="itemDescriptor" value="SEOTags" />
   <dsp:param name="howMany" value="1" />
   <dsp:param name="seoTagKey" value="${keyForSEOTagData }" />
   <dsp:param name="queryRQL" value="key = :seoTagKey" />
   <dsp:oparam name="output">
   	 <dsp:getvalueof var="sEOTagTitle" param="element.title" scope="request"/>
     <dsp:getvalueof var="sEOTagDescription" param="element.description" scope="request" />
     <dsp:getvalueof var="sEOKeywords" param="element.keywords" scope="request" />
     <dsp:getvalueof var="sEODisplayName" param="element.displayName" scope="request" />
     <dsp:getvalueof var="sEOMetaTagDescription" param="element.metaTagDescription" scope="request" />
	</dsp:oparam>
</dsp:droplet>
</dsp:page>
