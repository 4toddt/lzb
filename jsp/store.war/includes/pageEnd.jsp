<dsp:page>

<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
<dsp:importbean bean="/atg/dynamo/servlet/RequestLocale" var="requestlocale"/>
<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfigVar"/>
<c:choose>
    <c:when test="${not empty contentItem.footerContent}">
        <c:forEach var="element" items="${contentItem.footerContent}">
           <dsp:renderContentItem contentItem="${element}" />
         </c:forEach>
    </c:when>
    <c:otherwise>
        <dsp:include src="/global/includes/footer.jsp" />
    </c:otherwise>
    </c:choose>
    <%-- Analytics group_name | event_name---%>
    <meta name="WT.cg_n" content="${cg_n}" />
    <meta name="WT.cg_s" content="${cg_s}" />

    <%-- Include content from pageSpecificJS tag renderer --%>
    <dsp:getvalueof var="pageSpecificBottomJS" param="pageSpecificBottomJS"/>
    <c:choose>
        <c:when test="${not empty pageSpecificBottomJS}">
            <c:out value="${pageSpecificBottomJS}" escapeXml="false"/>
        </c:when>
    </c:choose>

    <%-- Adobe tag manager script end tag --%>
    <c:if test="${not empty storeConfigVar.adobeTagMgrScriptPath}">
        <script type="text/javascript">_satellite.pageBottom();</script>
    </c:if>

    <script>

        window.onload = function() {


            $(".cdp-nav .cdp-subtitle.toggle").attr({
                "tabindex": "0",
                "aria-expanded": "true"
            });

            $(".cdp-nav .cdp-subtitle.toggle").on({
                keydown: function(e) {
                    var code = e.which;
                    if (code === 13) {
                        $(this).click();
                    }
                },
                click: function() {
                        if ($(this).attr("aria-expanded") == "true") {
                            $(this).attr("aria-expanded", "false");
                        } else {
                            $(this).attr("aria-expanded", "true");
                        }
                }
            });

            /* JIRA DMI-1763 Hide Wishlist UI
            $('.cdp-wishlist img[tabindex="0"]').on({
                keydown: function(e) {
                    var thisRef = $(this);
                    var code = e.which;
                    if (code === 13) {
                        thisRef.click();
                        setTimeout(function() {
                            $("#cboxClose").attr("tabindex","0");
                        },1000);
                    }
                }
            });
            */

            $(document).on("keydown","#cboxClose",function(e){
                var code = e.which;
                if (code === 13) {
                    $(this).click();
                }
            });

            $(".btn-search").removeAttr("disabled");

            var paginationSelected = false;
            $(document).on("keyup","a",function(e){
                var code = e.which;
                if (code === 9 && $(e.target).is(".cdp-pagination-drop li:first a")) {
                    $(".cdp-pagination-drop li ul").css({
                        "display" : "block",
                        "opacity" : "1",
                        "visibility" : "visible"
                    });
                    paginationSelected = true;
                }else if(code === 9 && paginationSelected){
                    $(".cdp-pagination-drop li ul").css({
                        "display" : "none",
                        "opacity" : "0",
                        "visibility" : "hidden"
                    });
                }
            });

            $(document).on("mouseover",".cdp-pagination-drop li:first a",function(e){
                    $(".cdp-pagination-drop li ul").css({
                        "display" : "block",
                        "opacity" : "1",
                        "visibility" : "visible"
                    });
            });

            $(document).on("mouseout",".cdp-pagination-drop li:first a",function(e){

                if($(".cdp-pagination-drop li ul").is(":hidden")){
                    $(".cdp-pagination-drop li ul").css({
                        "display" : "none",
                        "opacity" : "0",
                        "visibility" : "hidden"
                    });
                }
            });


            $('.wish-addcart-anchor').click(function(e){



            });

            $('nav.cdp-nav .search-nav a').click(function(e){

                var hrefVal=$(this).attr("href");
                window.open(hrefVal,"_self");
            });



        } // window.onload
     </script>



        <div id="bPopupContainer">

            <button type="button" id="cboxClose" class="b-pop-close" tabindex="0">close</button>
            <div class="content"></div>

        </div>



	<%-- Monetate tag related data update --%>
	<c:if test="${storeConfigVar.monetateEnabled eq true }" >
	<%-- Monetate tag : push CDP or PDP data to monetate queue --%>
	<dsp:include page="/includes/monetateCDPAndPDPPageData.jsp" flush="true"></dsp:include>

	<%-- Monetate tag : push page type to monetate queue --%>
	<c:choose>
	    <c:when test="${isHomePage}">
				<dsp:include page="/includes/monetatePageType.jsp" flush="true">
					<dsp:param name="pageType" value="main"/>
				</dsp:include>
	    </c:when>
	    <c:otherwise>
				<dsp:include page="/includes/monetatePageType.jsp" flush="true">
					<dsp:param name="pageType" value="${pageTypeForTracking}"/>
				</dsp:include>
	    </c:otherwise>
	</c:choose>
	<%-- Monetate tag data submit --%>
	<script>
		window.monetateQ.push(["trackData"]);
	</script>
	</c:if>

    <c:choose>
        <c:when test="${storeConfigVar.staging eq true}">
            <c:set var="foreseeEnvironment" value="staging"/>
        </c:when>
        <c:otherwise>
            <c:set var="foreseeEnvironment" value="production"/>
        </c:otherwise>
    </c:choose>

    <%-- Foresee tag start --%>
    <script>
    // DO NOT MODIFY BELOW THIS LINE *****************************************
    ;(function (g) {
    var d = document, am = d.createElement('script'), h = d.head || d.getElementsByTagName("head")[0], fsr = 'fsReady',
    aex = {
      "src": "//gateway.foresee.com/sites/lazboy/<c:out value="${foreseeEnvironment}"/>/gateway.min.js",
      "type": "text/javascript",
      "async": "true",
      "data-vendor": "fs",
      "data-role": "gateway"
    };
    for (var attr in aex) { am.setAttribute(attr, aex[attr]); } h.appendChild(am); g[fsr] || (g[fsr] = function () { var aT = '__' + fsr + '_stk__'; g[aT] = g[aT] || []; g[aT].push(arguments); });
    })(window);
    // DO NOT MODIFY ABOVE THIS LINE *****************************************
    </script>
    <%-- Foresee tag end --%>

    </body>
    </html>
</dsp:page>
