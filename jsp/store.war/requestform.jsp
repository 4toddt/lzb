

<dsp:page>
	<dsp:importbean bean="/com/lzb/contactus/ContactUSFormHandler"/>
    <dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
    <dsp:importbean bean="/atg/dynamo/droplet/ErrorMessageForEach"/>
    <dsp:droplet name="ErrorMessageForEach">
	<dsp:param name="exceptions" param="ContactUSFormHandler.formExceptions" />
	<dsp:oparam name="output">
		<dsp:getvalueof var="errorMessage" param="message"/>
		<h3>
			<c:out value="${errorMessage}"/>
		</h3>
	</dsp:oparam>
	</dsp:droplet>
    
    <dsp:form name="requestForm" id="requestFormId" formid="requestFormId"  method="post">  
    	First Name : <dsp:input  type="text" id="firstName"  maxlength="40" beanvalue="ContactUSFormHandler.requestForm.firstName"  bean="ContactUSFormHandler.requestForm.firstName">
		</dsp:input><br/>
		Last Name : <dsp:input  type="text" id="lastName" maxlength="40" beanvalue="ContactUSFormHandler.requestForm.lastName"  bean="ContactUSFormHandler.requestForm.lastName">
		</dsp:input><br/>
		Email : <dsp:input  type="text" id="email" maxlength="40" beanvalue="ContactUSFormHandler.requestForm.email"  bean="ContactUSFormHandler.requestForm.email">
		</dsp:input><br/>
		Phone : <dsp:input  type="text" id="phone"  maxlength="10" beanvalue="ContactUSFormHandler.requestForm.phone"  bean="ContactUSFormHandler.requestForm.phone">
		</dsp:input><br/>
		Address : <dsp:input  type="text" id="address"  maxlength="100" beanvalue="ContactUSFormHandler.requestForm.address"  bean="ContactUSFormHandler.requestForm.address">
		</dsp:input><br/>
		City : <dsp:input  type="text" id="city"  maxlength="40" beanvalue="ContactUSFormHandler.requestForm.city"  bean="ContactUSFormHandler.requestForm.city">
		</dsp:input><br/>
		State : <dsp:input  type="text" id="state"  maxlength="40" beanvalue="ContactUSFormHandler.requestForm.state"  bean="ContactUSFormHandler.requestForm.state">
		</dsp:input><br/>
		Zip Code : <dsp:input  type="text" id="zipCode"  maxlength="40" beanvalue="ContactUSFormHandler.requestForm.zipCode"  bean="ContactUSFormHandler.requestForm.zipCode">
		</dsp:input><br/>
		Type of request :<br/>
		<dsp:input  type="radio" id="typeOfRequest"   value="Access"   bean="ContactUSFormHandler.requestForm.typeOfRequest">
		</dsp:input>Access&nbsp;&nbsp;
		<dsp:input  type="radio" id="typeOfRequest"  value="Deletion"   bean="ContactUSFormHandler.requestForm.typeOfRequest">
		</dsp:input>Deletion&nbsp;&nbsp;
		<dsp:input  type="radio" id="typeOfRequest"   value="data"   bean="ContactUSFormHandler.requestForm.typeOfRequest">
		</dsp:input>Category of Data&nbsp;&nbsp;
		<dsp:input  type="radio" id="typeOfRequest"  value="stop of sale"   bean="ContactUSFormHandler.requestForm.typeOfRequest">
		</dsp:input>Stop of Sale&nbsp;&nbsp;
		<br/>
		
		Type of data :<br/>
		<input  type="checkbox" id="typeOfData" name="typeOfData" value="Product"/>
		Product&nbsp;&nbsp;
		<input  type="checkbox" id="typeOfData" name="typeOfData"  value="Accounting"/>
		Accounting&nbsp;&nbsp;
		<input  type="checkbox" id="typeOfData" name="typeOfData"  value="Marketing"/>
		Marketing&nbsp;&nbsp;
		
		<br/>
		
		Account Names : <input  type="text"  name="accountNames" maxlength="40" />
		<br/>
		<input  type="text"  maxlength="40" name="accountNames"  />
		<br/>
		
		Product Info : <br/>
		Product Name 1: <input  type="text" name="productName"  maxlength="40"  />&nbsp;&nbsp;&nbsp;
		Serial No 1: <input  type="text" name="serialNumber"  maxlength="40"  />
		<br/>
		Product Name 2: <input  type="text"  name="productName"  maxlength="40"  />&nbsp;&nbsp;&nbsp;
		Serial No 2: <input  type="text"  name="serialNumber"  maxlength="40"  />
		<br/>
		
		Second verification : <dsp:input  type="text" id="delete"  maxlength="40"  bean="ContactUSFormHandler.requestForm.delete">
		</dsp:input><br/>
		
		Comments: <dsp:input  type="text" id="comments"  maxlength="40"   bean="ContactUSFormHandler.requestForm.comments">
		</dsp:input><br/>
		
		<dsp:input  type="checkbox" id="legal" value="true"   bean="ContactUSFormHandler.requestForm.legal">
		</dsp:input>Legal <br/>
		
		<dsp:input type="hidden" bean="ContactUSFormHandler.errorUrl" value="${contextPath}/requestform.jsp?error=true"/>
        <dsp:input type="hidden" bean="ContactUSFormHandler.successUrl" value="${contextPath}/requestform.jsp?success=true"/>
        <dsp:input type="submit"  value="Submit" id="requestFormSubmit" bean="ContactUSFormHandler.requestContactForm" />
				
    </dsp:form>   
	
</dsp:page>