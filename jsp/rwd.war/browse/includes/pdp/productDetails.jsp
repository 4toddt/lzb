<%--
    - File Name: productDetails.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page lays out the product details section on the product page.
    - Required Parameters:
        - pdpRecordType: pdp record type is a request scope variable,
        - productRecord: product record,
        - productName: name of the product
    - Optional Parameters:
--%>
<dsp:page>
    <%-- Imports --%>
    <dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig" />
    <dsp:importbean bean="/com/lzb/droplet/LZBConfigurableSkuLookUpDroplet" />
    <dsp:importbean bean="/atg/commerce/catalog/SKULookup"/>

    <%-- Page Variables --%>
    <dsp:getvalueof var="productRecord" param="productRecord" />
    <dsp:getvalueof var="productName" param="productName" />
    <dsp:getvalueof var="turnToEnabled" bean="/com/lzb/common/LZBTurnToConfiguration.turnToEnabled" />
    <c:set var="contentHostName" value="//${storeConfig.contentHostName}"/>
	<c:set var="imagePathAlt" value="/Images/product/categoryalt/" />
	<c:set var="imagePathDimension" value="/Images/product/dimensions/" />
    <c:set var="styleNumber" value="${productRecord['styleNumber']}" />
    <c:set var="longDescription" value="${productRecord['sku.longDescription']}" />
    <c:set var="acaBadge" value="${productRecord['sku.acaBadge']}" />
    <c:set var="madeInUSABadge" value="${productRecord['sku.madeInUSABadge']}" />
    <c:set var="lifestyleUrl" value="${productRecord['sku.cdpMouseOverImage']}" />
    <c:set var="lifestyleUrlPartPath" value="${fn:split(lifestyleUrl,'/')[0]}"/>
    <c:set var="lifestyleUrlPartFileName" value="${fn:split(lifestyleUrl,'/')[1]}"/>
    <c:set var="exteriorDepth" value="${productRecord['sku.exteriorDepth']}" />
    <c:set var="exteriorHeight" value="${productRecord['sku.exteriorHeight']}" />
    <c:set var="exteriorWidth" value="${productRecord['sku.exteriorWidth.prop']}" />
    <c:set var="interiorDepth" value="${productRecord['sku.interiorDepth']}" />
    <c:set var="interiorHeight" value="${productRecord['sku.interiorHeight']}" />
    <c:set var="interiorWidth" value="${productRecord['sku.interiorWidth']}" />
    <c:set var="dimensionImageUrl" value="${productRecord['sku.dimensionImage']}" />
    <c:set var="productDownloadImage" value="${productRecord['product.productDownloadImage']}" />
    <c:set var="productDownloadHeading" value="${productRecord['product.productDownloadHeading']}" />
    <c:set var="productDownloadDescription" value="${productRecord['product.productDownloadDescription']}" />
    <c:set var="productDownloadLink" value="${productRecord['product.productDownloadLink']}" />
    <fmt:message var="acaBadgeImgAlt" key="pdp.badge.aca" />
    <fmt:message var="usaBadgeImgAlt" key="pdp.badge.usa" />
    <fmt:message var="dimensionsImageAlt" key="pdp.productDetails.dimensionsPanel.imageAlt" />
    
    <dsp:droplet name="SKULookup">
	<dsp:param name="id" value="${productRecord['sku.repositoryId']}" />
	<dsp:param name="elementName" value="sku" />
	<dsp:oparam name="output">
		<dsp:getvalueof var="dimensionsHTML" param="sku.dimensionsHTML" />
	</dsp:oparam>
	</dsp:droplet>

    <%-- Render Product Details --%>
    <div id="productDetails" class="product-details section-row">
        <div class="section-title">
            <h2><fmt:message key="pdp.productDetails.heading"/></h2>
        </div>

        <%-- Render Tab Content --%>
        <div class="section-content tabs" data-tabs>
            <%-- Render Tab Menu --%>
            <ul class="tabs-container" role="tablist">
                <li role="presentation">
                    <a id="overview-tab" class="tab-title active" href="#overview-panel" aria-selected="true" aria-controls="overview-panel" role="tab">
                        <fmt:message key="pdp.productDetails.tab.overview"/>
                    </a>
                </li>
                <li role="presentation">
                    <a id="dimensions-tab" class="tab-title" href="#dimensions-panel" aria-selected="false" aria-controls="dimensions-panel" role="tab">
                        <fmt:message key="pdp.productDetails.tab.dimensions"/>
                    </a>
                </li>
                <li role="presentation">
                    <a id="resources-tab" class="tab-title" href="#resources-panel" aria-selected="false" aria-controls="resources-panel" role="tab">
                        <fmt:message key="pdp.productDetails.tab.resources"/>
                    </a>
                </li>
            </ul>

            <%-- Render Tab Panels --%>
            <div class="tabs-content">
                <%-- START: Overview Tab Panel --%>
                <section id="overview-panel" class="tab-body active" aria-labeledby="overview-tab" aria-hidden="false" role="tabpanel">
                    <div class="tab-body-content">
                        <div class="overview-description">
                            <%-- Render Product Style Number --%>
                            <c:if test="${not empty styleNumber}">
                                <p class="style-number small"><fmt:message key="pdp.styleNumber" />&nbsp;${styleNumber}</p>
                            </c:if>

                            <%-- Render Product Description --%>
                            <c:if test ="${not empty longDescription}">
                                <div class="description" itemprop="description">${longDescription}</div>
                            </c:if>

                            <%-- Render Badge Images --%>
                            <c:if test ="${not empty acaBadge && acaBadge eq 'true' || not empty madeInUSABadge && madeInUSABadge eq 'true'}">
                                <div class="overview-badges">
                                    <c:if test ="${not empty acaBadge && acaBadge eq 'true'}">
                                        <img src="${contentHostName}/Images/productIcons/ACA-Badge.png" alt="${acaBadgeImgAlt}"/>
                                    </c:if>

                                    <c:if test ="${not empty madeInUSABadge && madeInUSABadge eq 'true'}">
                                        <img src="${contentHostName}/Images/productIcons/MIA-Badge.png" alt="${usaBadgeImgAlt}"/>
                                    </c:if>
                                </div>
                            </c:if>
                        </div>

                        <%-- Render Lifestyle Image --%>
                        <c:if test="${not empty lifestyleUrl}">
                            <div class="lifestyle-img">
                                <c:choose>
                                    <c:when test="${not empty lifestyleUrlPartPath and not empty lifestyleUrlPartFileName}">
                                        <img src="${contentHostName}${imagePathAlt}${lifestyleUrlPartPath}/large/${lifestyleUrlPartFileName}" alt="${productName}"/>
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${contentHostName}${imagePathAlt}/large/${lifestyleUrl}" alt="${productName}"/>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:if>

                        <%-- Render TurnTo Image Gallery, CSS/JS included from ProductDetailsPage Cartridge --%>
            			<c:if test="${turnToEnabled}">
                            <div id="tt-gallery-row"></div>
                        </c:if>
                    </div>
                </section>
                <%-- END: Overview Tab Panel --%>

                <%-- START: Dimensions Tab Panel --%>
                <section id="dimensions-panel" class="tab-body" aria-labeledby="dimensions-tab" aria-hidden="true" role="tabpanel">
                    <div class="tab-body-content">
                        <%-- Render Dimension Image --%>
                        <c:if test="${not empty dimensionImageUrl}">
                            <div class="dimension-image">
                                <img src="${contentHostName}${imagePathDimension}${dimensionImageUrl}" alt="${dimensionsImageAlt}"/>
                            </div>
                        </c:if>

                        <%-- Render Dimension Details --%>
                       	<div class="dimension-details">
                        	<h4><fmt:message key="pdp.productDetails.dimensionsPanel.heading" /></h4>
							<c:choose>
								<c:when test="${not empty dimensionsHTML}">
									<dsp:valueof value="${dimensionsHTML}" valueishtml="true" />
								</c:when>
								<c:otherwise>
									<ul>
	                                    <c:if test="${not empty exteriorDepth}">
	                                        <li>
	                                            <p><strong><fmt:message key="pdp.productDetails.dimensionsPanel.bodyDepth" /></strong> <span>${exteriorDepth}</span></p>
	                                        </li>
	                                    </c:if>
	                                    <c:if test="${not empty exteriorHeight}">
	                                        <li>
	                                            <p><strong><fmt:message key="pdp.productDetails.dimensionsPanel.bodyHeight" /></strong> <span>${exteriorHeight}</span></p>
	                                        </li>
	                                    </c:if>
	                                    <c:if test="${not empty exteriorWidth}">
	                                        <li>
	                                            <p><strong><fmt:message key="pdp.productDetails.dimensionsPanel.bodyWidth" /></strong> <span>${exteriorWidth}</span></p>
	                                        </li>
	                                    </c:if>
	                                    <c:if test="${not empty interiorDepth}">
	                                        <li>
	                                            <p><strong><fmt:message key="pdp.productDetails.dimensionsPanel.seatDepth" /></strong> <span>${interiorDepth}</span></p>
	                                        </li>
	                                    </c:if>
	                                    <c:if test="${not empty interiorHeight}">
	                                        <li>
	                                            <p><strong><fmt:message key="pdp.productDetails.dimensionsPanel.seatHeight" /></strong> </strong><span>${interiorHeight}</span></p>
	                                        </li>
	                                    </c:if>
	                                    <c:if test="${not empty interiorWidth}">
	                                        <li>
	                                            <p><strong><fmt:message key="pdp.productDetails.dimensionsPanel.seatWidth" /></strong> <span>${interiorWidth}</span></p>
	                                        </li>
	                                    </c:if>
	                                </ul>
								</c:otherwise>
							</c:choose>
                     	</div>
                    </div>
                </section>
                <%-- END: Dimensions Tab Panel --%>

                <%-- START: Resources Tab Panel --%>
                <section id="resources-panel" class="tab-body" aria-labeledby="resources-tab" aria-hidden="true" role="tabpanel">
                    <div class="tab-body-content">
                		<c:if test="${not empty styleNumber}">
                			<dsp:droplet name="LZBConfigurableSkuLookUpDroplet">
                				<dsp:param name="id" value="${styleNumber}"/>
                				<dsp:param value="sku" name="elementName"/>
                				<dsp:oparam name="output">
                					<dsp:valueof param="sku.resources" valueishtml="true"/>
                				</dsp:oparam>
                				<dsp:oparam name="wrongCatalog">
                					<dsp:valueof param="sku.resources" valueishtml="true"/>
                				</dsp:oparam>
                			</dsp:droplet>
                		</c:if>

                    	<c:if test="${not empty productDownloadImage || not empty productDownloadHeading || not empty productDownloadDescription || not empty productDownloadLink}" >
                            <div class="product-manual">
                        		<c:if test="${not empty productDownloadImage}">
                        			<img src="${productDownloadImage}" alt="${productDownloadHeading}"/>
                        		</c:if>

                                <c:if test="${not empty productDownloadHeading || not empty productDownloadDescription || not empty productDownloadLink}">
                                    <div class="content">
                            			<c:if test="${not empty productDownloadHeading}">
                            				<h4>${productDownloadHeading}</h4>
                            			</c:if>

                                        <c:if test="${not empty productDownloadDescription || not empty productDownloadLink}">
                                            <p>
                                                <c:if test="${not empty productDownloadDescription}">
                                    				${productDownloadDescription}
                                    			</c:if>
                                				<c:if test="${not empty productDownloadLink}">
                                					<a href="${productDownloadLink}"><fmt:message key="pdp.productDetails.resourcesPanel.downloadLinkText" /></a>
                                				</c:if>
                                			</p>
                                        </c:if>
                            		</div>
                                </c:if>
                        	</div>
                        </c:if>
                    </div>
                </section>
                <%-- END: Resources Tab Panel --%>
            </div>
        </div>
    </div>
</dsp:page>