<dsp:page>
<dsp:importbean bean="/com/lzb/contactus/ContactUSFormHandler"/>
	<dsp:importbean bean="/com/lzb/service/CountryStateMapper" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/atg/dynamo/droplet/RQLQueryForEach" />
	<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty" />
	<json:object prettyPrint="true">
<json:array name="fieldArray">
<dsp:droplet name="IsEmpty">
         <dsp:param name="value" param="subCategory" />
         <dsp:oparam name="false" >			
				 <dsp:getvalueof var="pSubCat" param="subCategory" />
				  <dsp:droplet name="RQLQueryForEach">
					<dsp:param name="queryRQL"	value="name EQUALS IGNORECASE :pSubCat" />
					<dsp:param name="pSubCat" value="${pSubCat}" />
					<dsp:param name="repository" value="/com/lzb/repository/content/LZBContentRepository" />
					<dsp:param name="itemDescriptor" value="contactUsSubCategory" />
					<dsp:param name="elementName" value="subCat" />
					<dsp:oparam name="output">
						 <dsp:droplet name="ForEach">
						 <dsp:param name="array" param="subCat.subCategoryFormFields" />
				         <dsp:param name="elementName" value="formFields" />
				         <dsp:oparam name="output">
				         	 
				         	 <dsp:droplet name="ForEach">
							 <dsp:param name="array" param="formFields.fields" />
							  <dsp:param name="elementName" value="field" />
							 <dsp:oparam name="output">
							 <dsp:getvalueof var="field" param="field">
							 	<json:property value="${field.name}"/>
							 	</dsp:getvalueof>
							 </dsp:oparam>
							 </dsp:droplet>
							 
				         </dsp:oparam>
				         </dsp:droplet>
		

					</dsp:oparam>
				</dsp:droplet>
		</dsp:oparam>
</dsp:droplet>	
</json:array>
</json:object>
</dsp:page>