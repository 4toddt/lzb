<dsp:page>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/atg/dynamo/droplet/RQLQueryForEach" />
 	
 	<dsp:getvalueof var="pCat" param="category" />
 	<c:if test="${not empty pCat}">
 		<dsp:droplet name="RQLQueryForEach">
		<dsp:param name="queryRQL"	value="name EQUALS IGNORECASE :pCat" />
		<dsp:param name="pCat" value="${pCat}" />
		<dsp:param name="repository" value="/com/lzb/repository/content/LZBContentRepository" />
		<dsp:param name="itemDescriptor" value="contactUsCategory" />
		<dsp:param name="elementName" value="cat" />
		<dsp:oparam name="output">
			<dsp:droplet name="ForEach">
			<dsp:param name="array" param="cat.contactUsSubCategories" />
			<dsp:param name="elementName" value="subCat" />
			<dsp:getvalueof var="optionValue" param="subCat.name" />
			<dsp:oparam name="outputStart">
				<option value=""></option>
			</dsp:oparam>
			<dsp:oparam name="output">
				<option value="${fn:trim(optionValue)}"><dsp:valueof param="subCat.name" /></option>
			</dsp:oparam>
			</dsp:droplet>		
		</dsp:oparam>
		</dsp:droplet>
	</c:if>
</dsp:page>