<dsp:page>

  <div class="coverSearch">
    <div class="coverSearch__search">
      <p class="coverSearch__text">
        La-Z-Boy lets you customize your furniture with an amazing assortment of fabrics and leathers.<br/>
        Use the filters below to find the perfect cover, then save it for future reference.
      </p>
      <%-- see lzb.accordion.js for details --%>
      <div class="filterBar filterBar--mobile accordion" data-accordion>
        <div class="accordion-container">
          <div class="filterBar__accordionBtn filterBar__accordionBtn--outer accordion-title" role="tab" aria-controls="SortByPanel" id="SortByTab">Sort by</div>
          <div class="filterBar__accordionChild filterBar__accordionChild--outer accordion-body" aria-labeledby="SortByTab" role="tabpanel" id="SortByPanel">
            <button class="filterBar__option filterBar__option--sort filterBar__option-js filterBar__option--sort-js" data-deselectable="false" aria-selected="true" value="A-Z">A-Z</button>
            <button class="filterBar__option filterBar__option--sort filterBar__option-js filterBar__option--sort-js" data-deselectable="false" aria-selected="false" value="Z-A">Z-A</button>
          </div>
        </div>
        <div class="accordion-container">
          <div class="filterBar__accordionBtn filterBar__accordionBtn--outer accordion-title" role="tab" aria-controls="FilterByPanel" id="FilterByTab">Filter by</div>
          <div class="filterBar__accordionChild filterBar__accordionChild--outer accordion-body" aria-labeledby="FilterByTab" role="tabpanel" id="FilterByPanel">
            <button class="filterBar__accordionBtn accordion-title" role="tab" aria-controls="MaterialPanel" id="MaterialTab">Material</button>
            <div class="filterBar__accordionChild accordion-body" aria-labeledby="MaterialTab" role="tabpanel" id="MaterialPanel">
              <c:if test="${not empty contentItem.navigation}">
                <c:forEach var="element" items="${contentItem.navigation}">
                  <c:if test="${element.dimensionName eq 'coverSku.coverType'}">
                    <c:forEach items="${element.refinements}" var="refinement">
                      <button class="filterBar__option filterBar__option--material filterBar__option-js filterBar__option--material-js" aria-selected="false" value="${refinement.label}">${refinement.label}</button>
                    </c:forEach>
                  </c:if>
                </c:forEach>
              </c:if>
            </div>
            <button class="filterBar__accordionBtn accordion-title" role="tab" aria-controls="ColorPanel" id="ColorTab">Color</button>
            <div class="filterBar__accordionChild accordion-body" aria-labeledby="ColorTab" role="tabpanel" id="ColorPanel">
              <c:if test="${not empty contentItem.navigation}">
                <c:forEach var="element" items="${contentItem.navigation}">
                  <c:if test="${element.dimensionName eq 'coverSku.colorFamliy'}">
                    <c:forEach items="${element.refinements}" var="refinement">
                      <button class="filterBar__option filterBar__option--color filterBar__option-js filterBar__option--color-js" aria-selected="false" value="${refinement.label}">${refinement.label}</button>
                    </c:forEach>
                  </c:if>
                </c:forEach>
              </c:if>
            </div>
            <button class="filterBar__accordionBtn accordion-title" role="tab" aria-controls="PatternPanel" id="PatternTab">Pattern</button>
            <div class="filterBar__accordionChild accordion-body" aria-labeledby="PatternTab" role="tabpanel" id="PatternPanel">
              <c:if test="${not empty contentItem.navigation}">
                <c:forEach var="element" items="${contentItem.navigation}">
                  <c:if test="${element.dimensionName eq 'coverSku.patternName'}">
                    <c:forEach items="${element.refinements}" var="refinement">
                      <button class="filterBar__option filterBar__option--pattern filterBar__option-js filterBar__option--pattern-js" aria-selected="false" value="${refinement.label}">${refinement.label}</button>
                    </c:forEach>
                  </c:if>
                </c:forEach>
              </c:if>
            </div>
          </div>
        </div>
      </div>
      <div class="filterBar filterBar--desktop">
        <div class="filterBar__selectContainer">
          <select class="filterBar__select filterBar__select--sort filterBar__select--sort-js">
            <option value="none">Sort by</option>
            <option value="A-Z">A-Z</option>
            <option value="Z-A">Z-A</option>
          </select>
          <span class="coverSearch__selectIcon" aria-hidden="true" tabindex="-1"></span>
        </div>
        <div class="filterBar__selectContainer">
          <select class="filterBar__select filterBar__select--material filterBar__select--material-js">
            <option value="none">Material</option>
            <c:if test="${not empty contentItem.navigation}">
              <c:forEach var="element" items="${contentItem.navigation}">
                <c:if test="${element.dimensionName eq 'coverSku.coverType'}">
                  <c:forEach items="${element.refinements}" var="refinement">
                    <option value="${refinement.label}">${refinement.label}</option>
                  </c:forEach>
                </c:if>
              </c:forEach>
            </c:if>
          </select>
          <span class="coverSearch__selectIcon" aria-hidden="true" tabindex="-1"></span>
        </div>
        <div class="filterBar__selectContainer">
          <select class="filterBar__select filterBar__select--color filterBar__select--color-js">
            <option value="none">Color</option>
            <c:if test="${not empty contentItem.navigation}">
              <c:forEach var="element" items="${contentItem.navigation}">
                <c:if test="${element.dimensionName eq 'coverSku.colorFamliy'}">
                  <c:forEach items="${element.refinements}" var="refinement">
                    <option value="${refinement.label}">${refinement.label}</option>
                  </c:forEach>
                </c:if>
              </c:forEach>
            </c:if>
          </select>
          <span class="coverSearch__selectIcon" aria-hidden="true" tabindex="-1"></span>
        </div>
        <div class="filterBar__selectContainer">
          <select class="filterBar__select filterBar__select--pattern filterBar__select--pattern-js">
            <option value="none">Pattern</option>
            <c:if test="${not empty contentItem.navigation}">
              <c:forEach var="element" items="${contentItem.navigation}">
                <c:if test="${element.dimensionName eq 'coverSku.patternName'}">
                  <c:forEach items="${element.refinements}" var="refinement">
                    <option value="${refinement.label}">${refinement.label}</option>
                  </c:forEach>
                </c:if>
              </c:forEach>
            </c:if>
          </select>
          <span class="coverSearch__selectIcon" aria-hidden="true" tabindex="-1"></span>
        </div>
      </div>
      <div class="searchBar">
        <div class="searchBar__searchContainer">
          <input class="searchBar__search searchBar__search-js" placeholder="Search SKU">
          <button class="searchBar__searchBtn searchBar__searchBtn-js"></button>
        </div>
        <div class="searchBar__itemsContainer">
          <div class="searchBar__selectContainer">
            <label for="ItemsPerPage" class="searchBar__label">View:</label>
            <select id="ItemsPerPage" class="searchBar__select searchBar__select--items searchBar__select--items-js">
              <c:set var="recsPerPage">${contentItem.recsPerPage}</c:set>
              <c:set var="perPageOptions" value="${fn:split('10,25,50,100', ',')}" />
              <c:forEach items="${perPageOptions}" var="perPageOption">
                <c:choose>
                  <c:when test="${(not empty recsPerPage && recsPerPage == perPageOption) || perPageOption == '25'}">
                    <option value="${perPageOption}" selected>${perPageOption}</option>
                  </c:when>
                  <c:otherwise>
                    <option value="${perPageOption}">${perPageOption}</option>
                  </c:otherwise>
                </c:choose>
              </c:forEach>
            </select>
            <span class="coverSearch__selectIcon" aria-hidden="true" tabindex="-1"></span>
          </div>
          <p class="searchBar__items"><span class="searchBar__itemsAmt-js">0</span> Items</p>
        </div>
      </div>
    </div>
  </div>
</dsp:page>