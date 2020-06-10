<%@ taglib prefix="dsp"
	uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_1"%><%-- JSON Rendering Taglib --%>

			<dsp:page>
			<dsp:getvalueof var="category" param="contactUsCategory" />
			<c:if test="${not empty category}">
				Category: ${category}<br/>
			</c:if>
			<dsp:getvalueof var="subCategory" param="contactUsSubCategory" />
			<c:if test="${not empty subCategory}">
				Sub Category: ${subCategory}<br/>
			</c:if>
			<dsp:getvalueof var="fname" param="firstName" />
			<c:if test="${not empty fname}">
				First Name:${fname} <br/>
			</c:if>
			<dsp:getvalueof var="lname" param="lastName" />
			<c:if test="${not empty lname}">
				Last Name:${lname} <br/>
			</c:if>
			<dsp:getvalueof var="addrs1" param="address1" />
			<c:if test="${not empty addrs1}">
				Address: ${addrs1}<br/>
			</c:if>
			<dsp:getvalueof var="addrs2" param="address2" />
			<c:if test="${not empty addrs2}">
				Address 2:${addrs2}<br/>
			</c:if>
			<dsp:getvalueof var="city" param="city" />
			<c:if test="${not empty city}">
				City: ${city}<br/>
			</c:if>
			<dsp:getvalueof var="state" param="state" />
			<c:if test="${not empty state}">
				State/Province: ${state}<br/>
			</c:if>
			<dsp:getvalueof var="postalCode" param="zipCode" />
			<c:if test="${not empty postalCode}">
				ZipCode:${postalCode} <br/>
			</c:if>
			<dsp:getvalueof  var="country" param="country" />
			<c:if test="${not empty country}">
				Country: ${country}<br/>
			</c:if>
			<dsp:getvalueof var="emailId" param="email" />
			<c:if test="${not empty emailId}">
				Email:${emailId} <br/>
			</c:if>
			<dsp:getvalueof var="phoneNum" param="phoneNumber" />
			<c:if test="${not empty phoneNum}">
				Telephone:${phoneNum}<br/>
			</c:if>
			<dsp:getvalueof var="comment" param="comments" />
			<c:if test="${not empty comment}">
				Question/Comments:${comment} <br/>
			</c:if>
			<dsp:getvalueof var="acknowledgeNo" param="acknowledgmentNumber" />
			<c:if test="${not empty acknowledgeNo}">
				Acknowledgment Number:${acknowledgeNo}<br/>
			</c:if>
			<dsp:getvalueof var="StyleNo" param="styleNumber" />
			<c:if test="${not empty StyleNo}">
				Style Number:${StyleNo}<br/>
			</c:if>
			<dsp:getvalueof  var="coverNo" param="coverNumber" />
			<c:if test="${not empty coverNo}">
				Cover Number:${coverNo}<br/>
			</c:if>
			<dsp:getvalueof var="deliveryDate" param="dateOfDelivery" />
			<c:if test="${not empty deliveryDate}">
				Date of Delivery:${deliveryDate}<br/>
			</c:if>
			<dsp:getvalueof var="dealerName" param="dealerName" />
			<c:if test="${not empty dealerName}">
				Name of Dealer Purchased From:${dealerName}<br/>
			</c:if>
			<dsp:getvalueof var="dealerCity" param="dealerCity" />
			<c:if test="${not empty dealerCity}">
				Dealer City:${dealerCity}<br/>
			</c:if>
			<dsp:getvalueof var="dealerState" param="dealerState" />
			<c:if test="${not empty dealerState}">
				Dealer State:${dealerState}<br/>
			</c:if>
			 <dsp:getvalueof var="submittedDate" param="submittedDate" />
			<c:if test="${not empty submittedDate}">
				Date Submitted:${submittedDate}
			</c:if>

</dsp:page>