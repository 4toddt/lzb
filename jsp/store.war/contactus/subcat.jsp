<dsp:page>
<dsp:importbean bean="/com/lzb/contactus/ContactUSFormHandler"/>
	<dsp:importbean bean="/com/lzb/service/CountryStateMapper" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/atg/dynamo/droplet/RQLQueryForEach" />
	<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty" />
 
 
<dsp:droplet name="IsEmpty">
         <dsp:param name="value" param="category" />
         <dsp:oparam name="false" >				
				 <dsp:getvalueof var="pCat" param="category" />
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
				        	<option value="${optionValue}"><dsp:valueof param="subCat.name" /></option>
				        </dsp:oparam>
				        </dsp:droplet>		

					</dsp:oparam>
				</dsp:droplet>
		</dsp:oparam>
</dsp:droplet>		
		
		
</dsp:page>