<%@ taglib prefix="dsp" uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_1"%>


<dsp:page>
  <dsp:importbean bean="/atg/dynamo/droplet/ForEach" />

			<dsp:getvalueof var="fname" param="firstName" />
			<c:if test="${not empty fname}">
				First_Name:${fname} <br/>
			</c:if>
			<dsp:getvalueof var="lname" param="lastName" />
			<c:if test="${not empty lname}">
				Last_Name:${lname} <br/>
			</c:if>
			<dsp:getvalueof var="emailId" param="email" />
			
			Email_Address:${emailId} <br/>
			<dsp:getvalueof var="addrs1" param="address" />
			
			Address:${addrs1}<br/>
			
			<dsp:getvalueof var="city" param="city" />
			City:${city}<br/>
			
			<dsp:getvalueof var="state" param="state" />
			State:${state}<br/>
			
			<dsp:getvalueof var="postalCode" param="zipCode" />
			Zip_Code:${postalCode} <br/>
			
			
			<dsp:getvalueof var="phoneNum" param="phone" />
			Phone:${phoneNum}<br/>
			
			<dsp:getvalueof var="typeOfRequest" param="typeOfRequest" />
			Type_of_Request:${typeOfRequest} <br/>
			
			<dsp:getvalueof var="typeOfDataStr" param="typeOfDataStr" />
			Type_of_Data:${typeOfDataStr} <br/>
			
			<dsp:getvalueof var="accountName1" param="accountName1" />
			Account_Name_1:${accountName1} <br/>
			
			<dsp:getvalueof var="accountName2" param="accountName2" />
			Account_Name_2:${accountName2} <br/>
			
			<dsp:getvalueof var="productName1" param="productName1" />
			Product_1:${productName1} <br/>
			
			<dsp:getvalueof var="serialNumber1" param="serialNumber1" />
			ALI_1: ${serialNumber1} <br/>
			 
			<dsp:getvalueof var="productName2" param="productName2" />
			Product_2:${productName2} <br/>
			
			<dsp:getvalueof var="serialNumber2" param="serialNumber2" />
			ALI_2:${serialNumber2} <br/>
			
			<dsp:getvalueof var="productName3" param="productName3" />
			Product_3:${productName3} <br/>
			
			<dsp:getvalueof var="serialNumber3" param="serialNumber3" />
			ALI_3:${serialNumber3} <br/>
		
			
			<dsp:getvalueof var="delete" param="delete" />
			<c:if test="${not empty delete}">
				Verification_for_Delete:${delete} <br/>
			</c:if>
			
			<dsp:getvalueof var="comment" param="comments" />
			
			Additional_Information:${comment} <br/>
			
			
			<dsp:getvalueof var="legal" param="legal" />
			Legal_Agreement:Yes <br/>
			
				               		
			
</dsp:page>