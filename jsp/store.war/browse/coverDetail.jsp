
		<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
	 	<script src="//code.jquery.com/jquery-1.10.2.js"></script>
		<script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
    	<script src="http://malsup.github.com/jquery.form.js"></script>		
		<script type="text/javascript">
		$("#addcovertofavouritesid").click(function(e){
    		var iteminfo = getCoverItemInfoToAddToFavourites();
    		var data = JSON.stringify(iteminfo);
    		// save cover functionality is exactily as same as wishlist functionality.
    		// FEI team has already got the documnet related to wishlist implemenation.
    		//Same doc behaviour need to use here also/
    		
    		// First load the jsp add_item_to_save_cover_list_action.jsp if json response saying it is not login user then redirect to 
    		//login popup jsp and once user login then load the/work/browse/action/add_item_to_save_cover_list_actionForAnonymous_user.jsp to get 
    		// json response item is added into wish list or not
    		var requestString="favouriteiteminfo="+data;
    		$.ajax({
		        url: '/work/browse/action/add_item_to_save_cover_list_action.jsp',
		        type: 'post',
		        dataType: 'json',
		        data: requestString,
		        success:  function (data) {
		        	  	
		        }
		    });
    		
    	});
		
		
		function getCoverItemInfoToAddToFavourites() {
				var dealerid = "";
				var productid = "";	
				var catalogrefid = coverId;
    		var iteminfo = {};
    		iteminfo.dealerid = dealerid;
    		iteminfo.productid = productid;
    		iteminfo.catalogrefid = catalogrefid;
    		iteminfo.qty = 1;
    		return iteminfo;
		}
    	
	});
		
</script>
		
		
<dsp:page>
<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
<dsp:importbean bean="/com/lzb/droplet/LZBWishListContainDroplet" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/userprofiling/ProfileTools" />
	<dsp:param name="dealerId" bean="ProfileTools.priceListId" />
 <dsp:getvalueof var="type" param="type"/>
  <dsp:getvalueof var="color" param="color"/>
  <dsp:getvalueof var="pattern" param="pattern"/>
  <dsp:getvalueof var="coverId" param="coverId"/>
<img src="${storeConfig.hostName}${storeConfig.coverLargeviewBaseUrl}${coverId}.jpg" height="50" width="50" alt="${color}"/>
<meta itemprop="image" content="${storeConfig.hostName}${storeConfig.coverLargeviewBaseUrl}${coverId}.jpg" />
  COVER DETAILS</br>
  Type:&nbsp;&nbsp;${type}</br>
  Color:&nbsp;&nbsp;${color}</br>
  Pattern:&nbsp;&nbsp;${pattern}</br>
  </br>
 <dsp:droplet name="LZBWishListContainDroplet">
	    <dsp:param name="configSkuId" value="${coverId}" />
		<dsp:param name="saveCoverRequest" value="${true}" />
		<dsp:param name="profile" bean="/atg/userprofiling/Profile" />
	 <dsp:oparam name="true">
		<dsp:getvalueof var="wishlistid" param="wishListId"/>
		 <a href="#" onclick='removeFavoritesCover(this)' data-wishlistid="${wishlistid}"><img src="/img/heartred.png" class="heart" alt="heart icon" tabindex="0"/></a> 		
	</dsp:oparam>				
	<dsp:oparam name="false">
		 <a href="#" onclick='addFavoritesCover(this)'  data-skuid="${coverId}" data-productid="" data-dealerid="${dealerId}"><img src="/img/heart.png" class="heart" alt="heart icon" tabindex="0"/></a>
	</dsp:oparam>
</dsp:droplet>
 
</dsp:page>