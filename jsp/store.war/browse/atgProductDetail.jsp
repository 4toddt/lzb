<dsp:importbean bean="/atg/userprofiling/Profile" />
<dsp:importbean bean="/com/lzb/commerce/pricing/droplet/LZBExceptionPriceDroplet"/>
<dsp:importbean bean="/com/lzb/droplet/LZBSelectHotBuyDroplet"/>
<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
<dsp:importbean bean="/atg/commerce/catalog/ProductLookup" />

<dsp:page>

<dsp:droplet name="ProductLookup">
	<dsp:param name="id" param="prodId" />
	<dsp:param name="elementName" value="product" />
	<dsp:oparam name="output">
	    <h3><dsp:valueof param="product.displayName" /></h3>
		<p>
			<span><dsp:valueof param="product.description" /></span>
		</p>
		<h2>Sku Information</h2>
		<dsp:droplet name="ForEach">
			<dsp:param name="array" param="product.childSKUs" />
			<dsp:param name="elementName" value="sku" />
			<dsp:oparam name="output">
				    <h3><dsp:valueof param="sku.displayName" /></h3>
				    <dsp:droplet name="ForEach">
					<dsp:param name="array" param="sku.configurableProperties" />
					<dsp:param name="elementName" value="configPropertyCover" />
					<dsp:oparam name="output">
					<dsp:getvalueof var="type" param="configPropertyCover.type"/>
					<dsp:getvalueof var="name" param="configPropertyCover.displayName" />
					  <c:choose>
					  <c:when test="${name eq 'Cover'}">
					    <table>

					   		<tr><td><h3><dsp:valueof param="configPropertyCover.displayName" /></h3></td></tr>
					   		<dsp:droplet name="ForEach">
							<dsp:param name="array" param="configPropertyCover.configurationOptions" />
							<dsp:param name="elementName" value="configOptionCover" />
								<dsp:oparam name="output">
								  <tr>
								  	<td>&nbsp;&nbsp;</td>
								  	<td><p><dsp:valueof param="configOptionCover.sku.grade" /></p></td>
								  	<td>&nbsp;&nbsp;</td>
								  	<td>
									  	<dsp:droplet name="ForEach">
										<dsp:param name="array" param="configOptionCover.sku.priceGradeCovers" />
										<dsp:param name="elementName" value="cover" />
											<dsp:oparam name="output">
											  <p><dsp:valueof param="cover.coverColor"/></p>
											</dsp:oparam>
										</dsp:droplet>

								  	</td>
								  </tr>
								</dsp:oparam>
							</dsp:droplet>
						</table>
					  </c:when>
					  </c:choose>
					</dsp:oparam>
					</dsp:droplet>

					<h3>Options and Upgrade</h3>
					<dsp:droplet name="ForEach">
					<dsp:param name="array" param="sku.configurableProperties" />
					<dsp:param name="elementName" value="configProperty" />
					<dsp:oparam name="output">
					<dsp:getvalueof var="type" param="configProperty.type"/>
					<dsp:getvalueof var="name" param="configProperty.displayName" />
					  <c:choose>
					  <c:when test="${name eq 'Cover'}">
					  </c:when>
					  <c:when test="${(empty type || type eq 'configurableProperty') }">
					        <table>

					   		<tr><td><h4><dsp:valueof param="configProperty.displayName" /></h4></td></tr>
					   		<dsp:droplet name="ForEach">
							<dsp:param name="array" param="configProperty.configurationOptions" />
							<dsp:param name="elementName" value="configOption" />
								<dsp:oparam name="output">
								  <tr><td>&nbsp;&nbsp;</td> <td><p><dsp:valueof param="configOption.sku.displayName" /></p></td></tr>
								</dsp:oparam>
							</dsp:droplet>
							</table>
					   </c:when>
					   <c:otherwise>
					     <table>

					      <tr><td><h4><dsp:valueof param="configProperty.displayName" /></h4></td><tr/>
					      <dsp:droplet name="ForEach">
							<dsp:param name="array" param="configProperty.configurationOptionsGroup" />
							<dsp:param name="elementName" value="configOptionGroup" />
								<dsp:oparam name="output">
								    <tr><td>&nbsp;</td><td><p><b><dsp:valueof param="configOptionGroup.displayName" /></b></p></td></tr>

								    <dsp:droplet name="ForEach">
									<dsp:param name="array" param="configOptionGroup.configurationOptions" />
									<dsp:param name="elementName" value="configOptionGroupOption" />
										<dsp:oparam name="output">
										 <tr><td>&nbsp;&nbsp;</td> <td><p><dsp:valueof param="configOptionGroupOption.sku.displayName" /></p></td></tr>
										</dsp:oparam>
									</dsp:droplet>
								</dsp:oparam>
							</dsp:droplet>
						</table>
					   </c:otherwise>
					  </c:choose>


					</dsp:oparam>
					</dsp:droplet>

			</dsp:oparam>
		</dsp:droplet>
	</dsp:oparam>
</dsp:droplet>




	<dsp:droplet name="LZBExceptionPriceDroplet">
		<dsp:param name="dealerId" value="1179039"  />
		<dsp:param name="itemInfo" value='{"dealerid": "1179039", "productid": "prod051317", "catalogrefid": "051317", "qty": "1","coveroptionskus": [{"subskuid": "B100506","type": "cover","qty": 1}, {"subskuid": "051317_P1","type": "option","qty": 1}]}'/>
		<dsp:param name="profile" bean="Profile"/>
		<dsp:oparam name="price">
			List Price : <dsp:valueof param="exceptionListPrice.price"/><br/>
			List Price Exception Id : <dsp:valueof param="exceptionListPrice.exceptionId"/><br/>
			Sale Price : <dsp:valueof param="exceptionSalePrice.price"/><br/>
			Sale Price Exception Id : <dsp:valueof param="exceptionListPrice.exceptionId"/><br/>

		</dsp:oparam>
	</dsp:droplet>


	<dsp:droplet name="LZBSelectHotBuyDroplet">
		<dsp:param name="dealerId" value="1179039"  />
		<dsp:param name="configSkuId" value="40A420"/>
		<dsp:param name="profile" bean="Profile"/>
		<dsp:oparam name="select">
		    <h2>Selects</h2>
			<dsp:droplet name="ForEach">
			<dsp:param name="array" param="selects" />
			<dsp:param name="elementName" value="select" />
				<dsp:oparam name="output">
				  	Config Sku - <dsp:valueof param="select.configSku.displayName"/>:::
				  	Cover - <dsp:valueof param="select.cover.displayName"/>:::options{
				    <dsp:droplet name="ForEach">
					<dsp:param name="array" param="select.options" />
					<dsp:param name="elementName" value="option" />
						<dsp:oparam name="output">
						  	<dsp:valueof param="option.optionCode"/>-
						</dsp:oparam>
					</dsp:droplet>
					}<br/>
				    List Price : <dsp:valueof param="select.listPrice"/>  <br/>
				    Sale Price : <dsp:valueof param="select.salePrice"/>  <br/>
				    Exception Id : <dsp:valueof param="select.exceptionId"/>  <br/>
				</dsp:oparam>
			</dsp:droplet>
			<br/>
		</dsp:oparam>
		<dsp:oparam name="hotBuy">
		    <br/><h2>Hot Buys</h2>
			<dsp:droplet name="ForEach">
			<dsp:param name="array" param="hotBuys" />
			<dsp:param name="elementName" value="hotBuy" />
				<dsp:oparam name="output">
				    Config Sku - <dsp:valueof param="hotBuy.configSku.displayName"/>:::
				  	Cover - <dsp:valueof param="hotBuy.cover.displayName"/>:::options{
				    <dsp:droplet name="ForEach">
					<dsp:param name="array" param="hotBuy.options" />
					<dsp:param name="elementName" value="option" />
						<dsp:oparam name="output">
						  	<dsp:valueof param="option.optionCode"/>-
						</dsp:oparam>
					</dsp:droplet>
					}<br/>
				    List Price : <dsp:valueof param="hotBuy.listPrice"/>  <br/>
				    Sale Price : <dsp:valueof param="hotBuy.salePrice"/>  <br/>
				    Exception Id : <dsp:valueof param="hotBuy.exceptionId"/>  <br/>
				</dsp:oparam>
			</dsp:droplet>
		    <br/>
		</dsp:oparam>
	</dsp:droplet>

</dsp:page>