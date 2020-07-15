<%--
renders the contents of YC HomePage ShopBy Link Content
HomePageShopByLinkContentWithXLImageSlot.jsp
--%>
<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contentItem"
		vartype="com.endeca.infront.assembler.ContentItem"
		value="${originatingRequest.contentItem}" />
	<dsp:getvalueof var="rowSize" param="rowSize" />
<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />
	<c:set var="linkText" value="${contentItem.text}" />
	<c:set var="linkUrl" value="${contentItem.imageLink}" />
	<c:if test="${not empty linkUrl }">
		<dsp:droplet name="ActionURLDroplet">
			<dsp:param name="action" value="${linkUrl}" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="actionURLTitleLink" param="actionURL" />
			</dsp:oparam>
			<dsp:oparam name="empty">
			</dsp:oparam>
		</dsp:droplet>
	</c:if>
	<%-- 
    rowSize:  ${rowSize} 
	title : ${ contentItem.title  }
imageURL : ${ contentItem.imageURL  }
imageLink : ${ contentItem.imageLink  } 
alt : ${ contentItem.alt  } 
	--%>
	<div>
		<a href="${ actionURLTitleLink}" aria-label="${ contentItem.title  }">
			<img src="${ contentItem.imageURL  }" alt="${ contentItem.alt  }" title="${ contentItem.title  }" />
		</a>
		<%-- <h3></h3> --%>
	</div>
	
</dsp:page>