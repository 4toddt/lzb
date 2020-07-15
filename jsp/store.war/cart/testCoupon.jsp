<dsp:page>
<dsp:importbean bean="/atg/commerce/promotion/CouponFormHandler"/>

<dsp:form id="couponId" name="couponId">
<dsp:input bean="CouponFormHandler.couponClaimCode" type="text" id="couponCode" autocomplete="off"/>
<dsp:input bean="CouponFormHandler.claimCoupon" type="submit" value="Apply" />
<dsp:input bean="CouponFormHandler.claimCouponSuccessURL" type="hidden"
		value="/cart/bag.jsp" />
	<dsp:input bean="CouponFormHandler.claimCouponErrorURL" type="hidden"
		value="/cart/bag.jsp" />
		
		
</dsp:form>
</dsp:page>