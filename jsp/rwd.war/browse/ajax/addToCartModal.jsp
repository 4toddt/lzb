<%--
	- File Name: addToCartModal.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This is confirmation modal when a user adds item to cart from the product detail page.
	- Required Parameters:
	- Optional Parameters:
--%>

<dsp:page>
	<%-- Imports --%>

	<%-- Page Variables --%>

	<layout:ajax>
		<jsp:attribute name="section">modal</jsp:attribute>
		<jsp:attribute name="pageType">addToCartModal</jsp:attribute>

		<jsp:body>
			<div class="add-to-cart-modal">
				<%-- NOTE: Modal content is rendered using a Mustache template in lzb.templates.js --%>
			</div>
		</jsp:body>
	</layout:ajax>
</dsp:page>