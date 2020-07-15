<%--
  - File Name: keywordSearch.jsp
  - Author(s): DMI UX Team
  - Copyright Notice: Copyright 2001, 2012, Oracle and/or its affiliates. All rights reserved.
  	Oracle and Java are registered trademarks of Oracle and/or its
  	affiliates. Other names may be trademarks of their respective owners.
  	UNIX is a registered trademark of The Open Group.
  - Description: This page renders a keyword search box that is seperate from the header search. To be used without typeahead.
  - Required Parameters:
        - contentItem
  - Optional Parameters:
        - headingText,
        - decriptionText
--%>
<dsp:page>
	<%-- Imports --%>
    <dsp:importbean bean="/atg/endeca/assembler/SearchFormHandler"/>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>

    <%-- Page Variables --%>
    <dsp:getvalueof param="headingText" var="headingText" />
    <dsp:getvalueof param="decriptionText" var="decriptionText" />

    <%-- Render Search Form --%>
    <div class="keyword-search" role="search">
        <%-- display heading --%>
        <c:if test="${not empty headingText}">
            <h2>${headingText}</h2>
        </c:if>
        <%-- display description --%>
        <c:if test="${not empty decriptionText}">
            <p>${decriptionText}</p>
        </c:if>

        <%-- display form --%>
        <dsp:form action="${contextPath}${storeConfig.mobileSearchUrl}" id="keyword-search-form" formid="keyword-search-form" requiresSessionConfirmation="false" name="keyword-search-form">
            <dsp:input bean="SearchFormHandler.searchSuccessURL" type="hidden" value="${contextPath}${storeConfig.mobileSearchUrl}"/>
            <dsp:input bean="SearchFormHandler.searchErrorURL" type="hidden" value="${contextPath}${storeConfig.mobileSearchUrl}"/>
            <input type="hidden" name="Dy" value="1"/>
            <input type="hidden" name="Nty" value="1"/>
            <input type="hidden" name="forwardRequestUri" value="${requestScope['javax.servlet.forward.request_uri']}"/>
            <div class="field-group inline-form">
                <div class="field search-field">
                    <label class="sr-only" for="keyword-search">keyword search</label>
                    <dsp:input bean="SearchFormHandler.searchTerm" type="text" value="" name="Ntt" id="keyword-search">
                        <dsp:tagAttribute name="class" value="keyword-field"/>
                          <dsp:tagAttribute name="autocomplete" value="off"/>
                          <dsp:tagAttribute name="autocorrect" value="off"/>
                          <dsp:tagAttribute name="placeholder" value="What are you looking for?"/>
                    </dsp:input>
                    <!--[if IE]><input type="text" style="display: none;" title="Ignore field. IE bug fix" disabled="disabled" size="1" /><![endif]-->
                </div>
                <div class="action-field">
                    <button type="submit" class="button keyword-search-button" aria-label="search">
                        <span class="icon icon-search" aria-hidden="true"></span>
                    </button>
                    <dsp:input type="hidden" bean="SearchFormHandler.search" name="search" value="Search" />
                </div>
            </div>
        </dsp:form>
    </div>
</dsp:page>