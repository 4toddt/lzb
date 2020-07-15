<dsp:page>
<table>
<tr>
<td>
<dsp:include page="/comparisons/gadgets/compareItemImage.jsp">
	<dsp:param name="element" param="element" />
</dsp:include>
</td>

<td>
<dsp:valueof param="element.product.displayName"/>@<dsp:valueof param="element.product.description"/><br>
<fmt:message key="compare.aslowas"/> </br>
  	 <dsp:include page="/global/gadgets/priceLookup.jsp">
    			<dsp:param name="listPrice" param="element.priceInfo.listPrice"/>
     			<dsp:param name="salePrice" param="element.priceInfo.salePrice"/>
    </dsp:include>
</td>
</tr>
</table>



</dsp:page>