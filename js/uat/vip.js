
window.addEventListener(
    'message',
    function (e) {
        if (e.data.event && e.data.event == 'calendly.event_scheduled') {
            _satellite.track('calendly_event_scheduled');
        }
    }
);

var promo = window.location.pathname.split('/').slice(-1)[0];
var postal = window.location.search.split('postal=')[1].split('&')[0];
var vipAPI = 'https://gallerysiteapi.la-z-boy.com/api/VIP/Get?zipcode=' + postal + '&code=' + promo;
// console.log(vipAPI);

$.getJSON(vipAPI, function () {
    // console.log("success");
})
    .done(function (json) {
        // console.log("second success (done)");
        // console.log(json);
        if (!jQuery.isEmptyObject(json.Data)) {
            $("#store-appointment").attr("href", "https://calendly.com" + json.Data.StoreAppointment);
            $("#virtual-appointment").attr("href", "https://calendly.com" + json.Data.VirtualAppointment);
            $("#store-name").text(json.Data.StoreName);
            $("#store-address").html(json.Data.Address);
            $("#store-phone").text(json.Data.Phone);
            $('#npc-content').show();

            $(".calendly").click(function (e) {
                e.preventDefault();
                calendlyUrl = $(this).attr('href');
                $.getScript('https://assets.calendly.com/assets/external/widget.js')
                    .done(function () {
                        Calendly.initPopupWidget({
                            url: calendlyUrl
                        });
                        gtag('event', 'conversion', {
                            'allow_custom_scripts': true,
                            'send_to': 'DC-1461522/fy17l0/shedu0+standard'
                        });
                    });
                return false;
            });
        }
    });