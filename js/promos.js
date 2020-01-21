//function to check if jQuery is ready
function jqIsReady() {
    if (typeof $ === "undefined") {
        //if (!JQREADY)
        return false;
    }
    return true;
}
(function jqCheck() {
    if (!jqIsReady()) {
        setTimeout(jqCheck, 10);
        return;
    } else {
        // Make images followed by links clickable
        $(document).ready(function() {
            $('#bcc-content .image~a').siblings(".image").addClass('clickable').click(function() {
                $(this).siblings('a')[0].click();
            });
        });
    }
})();