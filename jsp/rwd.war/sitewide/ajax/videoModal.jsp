<%--
  - File Name: videoModal.jsp
  - Author(s): DMI UX Team
  - Copyright Notice:
  - Description:
  - Required Parameters:
        - videoURL
  - Optional Parameters:
        - title
        - description
--%>
<dsp:page>
    <%-- Page Variables --%>
    <dsp:getvalueof param="videoURL" var="videoURL"/>
    <dsp:getvalueof param="title" var="title"/>
    <dsp:getvalueof param="description" var="description"/>

	<layout:ajax>
		<jsp:attribute name="section">modal</jsp:attribute>
		<jsp:attribute name="pageType">videoModal</jsp:attribute>

        <jsp:body>
            <%-- display title --%>
            <c:if test="${not empty title}">
                <div class="modal-header">
    				<div class="title-bar">
                        <h2>${title}</h2>
    				</div>
                </div>
            </c:if>

            <section class="modal-body video-content">
                <%-- display video --%>
                <c:if test="${not empty videoURL}">
                    <div class="video-container">
                        <iframe class="video-modal-iframe" src="${fn:escapeXml(videoURL)}" frameborder="0" allowfullscreen></iframe>
                    </div>
                </c:if>
                <%-- display description --%>
                <c:if test="${not empty description}">
                    <p>${description}</p>
                </c:if>
			</section>

            <div class="modal-footer">
    			<p><fmt:message key="modal.video.footer"/></p>
    		</div>
		</jsp:body>
	</layout:ajax>
</dsp:page>
