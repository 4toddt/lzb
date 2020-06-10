<%--
  - File Name: imageModal.jsp
  - Author(s): DMI UX Team
  - Copyright Notice:
  - Description:
  - Required Parameters:
        - imageURL
  - Optional Parameters:
        - title
        - description
--%>
<dsp:page>
    <%-- Page Variables --%>
    <dsp:getvalueof param="imageURL" var="imageURL"/>
    <dsp:getvalueof param="imageAlt" var="imageAlt"/>
    <dsp:getvalueof param="title" var="title"/>
    <dsp:getvalueof param="description" var="description"/>

	<layout:ajax>
		<jsp:attribute name="section">modal</jsp:attribute>
		<jsp:attribute name="pageType">imageModal</jsp:attribute>

        <jsp:body>
            <%-- display title --%>
            <c:if test="${not empty title}">
                <div class="modal-header">
    				<div class="title-bar">
                        <h2>${title}</h2>
    				</div>
                </div>
            </c:if>

            <section class="modal-body image-content">
                <%-- display image --%>
                <c:if test="${not empty imageURL}">
                    <div class="image-container">
                        <img src="${fn:escapeXml(imageURL)}" alt="${imageAlt}">
                    </div>
                </c:if>
                <%-- display description --%>
                <c:if test="${not empty description}">
                    <p>${description}</p>
                </c:if>
			</section>

            <%-- <div class="modal-footer"></div> --%>
		</jsp:body>
	</layout:ajax>
</dsp:page>
