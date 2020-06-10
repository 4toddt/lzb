<dsp:page>
	<dsp:importbean var="storeConfig" bean="/atg/store/LZBStoreConfiguration"/>
	<dsp:importbean bean="/atg/commerce/catalog/SKULookup"/>
	<c:set var="contentHostName" value="//${storeConfig.contentHostName}"/>
	<c:set var="storeConfigHostName" value="${contentHostName}" />
	<c:set var="imagePathAlt" value="/Images/product/categoryalt/" />
	<c:set var="imagePathDimension" value="/Images/product/dimensions/" />

    <div id="prodDetails" class="product-details pdp-block-container" data-anchor="productDetails">
        <!-- PDP Info Block -->
        <h3 class="section-heading">
          <fmt:message key="pdp.productDetails.heading"/>
        </h3>
        <div class="pdp-info-tabs tabs-white-blue">
            <div>
                <ul class="tabs" data-module="tabs" data-focus-selector="li > a">
                    <li>
                        <a href="#" data-rel="pdpDescriptionTabContent" class="active">
                          <fmt:message key="pdp.productDetails.descTab"/>
                        </a>
                    </li>
                    <li>
                        <a href="#" data-rel="pdpDimensionTabContent">
                          <fmt:message key="pdp.productDetails.dimTab"/>
                        </a>
                    </li>
										<li>
                        <a href="#" data-rel="pdpResourcesTabContent">
                          <fmt:message key="pdp.productDetails.resourcesTab"/>
                        </a>
                    </li>
                </ul>
            </div>
            <div id="pdpDescriptionTabContent" class="pdp-block tab-content active">
                <div class="pdp-desc-block">
                    <div id="pdpDescription" class="pdp-block">
                        <h4 class="pdp-block-title">
                          <fmt:message key="pdp.productDetails.descTab.heading" />
                        </h4>
                        <c:if test="${not empty productRecord['styleNumber']}">
			                    <p class="small">
                            <fmt:message key="pdp.styleNumber" />
                            &nbsp;${productRecord['styleNumber']}
                          </p>
					              </c:if>
                        <c:if test ="${not empty productRecord['sku.longDescription']}">
                            <p class="description" itemprop="description">${productRecord['sku.longDescription']}</p>
                        </c:if>
                        <c:if test ="${not empty productRecord['sku.acaBadge'] && productRecord['sku.acaBadge'] eq 'true'}">
                            <img src="${contentHostName}${madeInACABadgeFullImagePath}" alt="<fmt:message key="pdp.aca.badge"/>"/>
                        </c:if>
                        <c:if test ="${not empty productRecord['sku.madeInUSABadge'] && productRecord['sku.madeInUSABadge'] eq 'true'}">
                            <img src="${contentHostName}${madeInUSABadgeFullImagePath}" alt="<fmt:message key="pdp.usa.badge"/>"/>
                        </c:if>

                        <div id="tt-gallery-row"></div>
                    </div>

                    <%-- Life Style Image URL Rendering --%>
                    <dsp:getvalueof var="lifestyleUrl" value="${productRecord['sku.cdpMouseOverImage']}" />
                   	<dsp:getvalueof var="lifestyleUrlPartPath" value="${fn:split(lifestyleUrl,'/')[0]}"/>
                    <dsp:getvalueof var="lifestyleUrlPartFileName" value="${fn:split(lifestyleUrl,'/')[1]}"/>
                    
                    <c:if test="${not empty lifestyleUrl}">                
                  	<c:choose>
    					<c:when test="${not empty lifestyleUrlPartPath and not empty lifestyleUrlPartFileName}">
      						<div class="lifestyle-img">
	                        <img src="${storeConfigHostName}${imagePathAlt}${lifestyleUrlPartPath}/large/${lifestyleUrlPartFileName}" alt="${productRecord['product.displayName']}"/>
	                    </div>
    					</c:when>
  						<c:otherwise>
        					<div class="lifestyle-img">
	                        <img src="${storeConfigHostName}${imagePathAlt}/large/${lifestyleUrl}" alt="${productRecord['product.displayName']}"/>
	                    </div>
	                    </c:otherwise>
					</c:choose>
                    </c:if>
                </div>
            </div>
            <div id="pdpDimensionTabContent" class="pdp-block tab-content">
                <h4 class="pdp-block-title">
                  <fmt:message key="pdp.productDetails.dimTab.heading" />
                </h4>
                <div id="pdpDimensions" class="pdp-block">
                    <div>
                    	<dsp:droplet name="SKULookup">
						<dsp:param name="id" value="${productRecord['sku.repositoryId']}" />
						<dsp:param name="elementName" value="sku" />
						<dsp:oparam name="output">
							<dsp:getvalueof var="dimensionsHTML" param="sku.dimensionsHTML" />
						</dsp:oparam>
						</dsp:droplet>
						
						<c:choose>
							<c:when test="${not empty dimensionsHTML}">
								<dsp:valueof value="${dimensionsHTML}" valueishtml="true" />
							</c:when>
							<c:otherwise>
								<ul>
                          			<c:if test="${not empty productRecord['sku.exteriorDepth']}">
                            			<li>
                                			<p><strong><fmt:message key="pdp.bodyDepth" /></strong> <span>${productRecord['sku.exteriorDepth']}</span></p>
                            			</li>
                          			</c:if>
									<c:if test="${not empty productRecord['sku.exteriorHeight']}">
                            			<li>
                                			<p><strong><fmt:message key="pdp.bodyHeight" /></strong> <span>${productRecord['sku.exteriorHeight']}</span></p>
                            			</li>
									</c:if>
									<c:if test="${not empty productRecord['sku.exteriorWidth.prop']}">
                            			<li>
                                			<p><strong><fmt:message key="pdp.bodyWidth" /></strong> <span>${productRecord['sku.exteriorWidth.prop']}</span></p>
                            			</li>
									</c:if>
									<c:if test="${not empty productRecord['sku.interiorDepth']}">
                            			<li>
                                			<p><strong><fmt:message key="pdp.seatDepth" /></strong> <span>${productRecord['sku.interiorDepth']}</span></p>
                            			</li>
									</c:if>
									<c:if test="${not empty productRecord['sku.interiorHeight']}">
                            			<li>
                                			<p><strong><fmt:message key="pdp.seatHeight" /></strong> </strong><span>${productRecord['sku.interiorHeight']}</span></p>
                            			</li>
									</c:if>
									<c:if test="${not empty productRecord['sku.interiorWidth']}">
                            			<li>
                                			<p><strong><fmt:message key="pdp.seatWidth" /></strong> <span>${productRecord['sku.interiorWidth']}</span></p>
                            			</li>
									</c:if>
                        		</ul>
							</c:otherwise>
						</c:choose>
							
                    </div>

                    <%-- Dimension URL Rendering --%>
                    <dsp:getvalueof var="dimensionImageUrl" value="${productRecord['sku.dimensionImage']}" />
                    <c:if test="${not empty dimensionImageUrl}">
	                    <div class="dimension-image">
												<fmt:message key="pdp.dimensions.imageAlt" var="dimensionsImageAlt" />
	                      <img src="${storeConfigHostName}${imagePathDimension}${dimensionImageUrl}" alt="${dimensionsImageAlt}"/>
	                    </div>
                    </c:if>

                </div>
            </div>
            <div id="pdpResourcesTabContent" class="pdp-block tab-content pdp-adtl-info">
                <div class="pdp-block">
                    <dsp:include src="${pageContext.request.contextPath}/browse/pdp/additionalInfo.jsp">
                        <dsp:param name="productRecord" value="${productRecord}"/>
                    </dsp:include>
                </div>
            </div>
        </div>
    </div>
</dsp:page>