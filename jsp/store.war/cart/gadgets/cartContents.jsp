<dsp:page>
	<!-- component imports here -->
	<%-- 
    The number of items currently in the shopping cart. This is used to determine
    which shopping cart message to display to the user when the cart is empty.
  --%>
	 <dsp:include page="/global/includes/reprice.jsp">
		<dsp:param name="pageReprice" value="cart"/>
	</dsp:include>
	<dsp:include page="cartContentItems.jsp"/> 
</dsp:page>