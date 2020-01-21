// Create array of query string values
var vars = [], hash;
var q = document.URL.split('?')[1];
if (q != undefined) {
    q = q.split('&');
    for (var i = 0; i < q.length; i++) {
        hash = q[i].split('=');
        vars.push(hash[1]);
        vars[hash[0]] = hash[1];
    }
}

// Hide the pricing if indicated in query string
if (vars['pricing'] == 'hidden') {
    document.write('<style id="temp-hide-price">.pdp-price,.selected-cover-price{display:none}</style>');
    requirejs(['jQuery'], function ($) {
        $('#pdp-price-info').css('display', 'none');
        $('.selected-cover-price').empty();
        $('#temp-hide-price').remove();
    });
}