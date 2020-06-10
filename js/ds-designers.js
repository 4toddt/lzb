// Data needed to generate designer HTML
var designers = [ //{
    //     name: "Amanda",
    //     location: "Raleigh, NC",
    //     longitude: "-78.638176",
    //     portrait: "/Images/npc/designer/list/amanda.png",
    //     room: "/Images/npc/designer/list/amanda-room.jpg",
    //     page: "/content/design-services/amanda"
    // },
    // {
    //     name: "Sharon",
    //     location: "Vaughan, ON",
    //     longitude: "-79.508278",
    //     portrait: "/Images/npc/designer/list/sharon.png",
    //     room: "/Images/npc/designer/list/sharon-room.jpg",
    //     page: "/content/design-services/sharon"
    // },
    {
        name: "Everton",
        location: "Manchester, CT",
        longitude: "-72.521500",
        portrait: "/Images/npc/designer/list/everton_v2.png",
        room: "/Images/npc/designer/list/everton-room.jpg",
        page: "/content/design-services/everton"
    },
    {
        name: "Alexis",
        location: "Myrtle Beach, SC",
        longitude: "-78.886696",
        portrait: "/Images/npc/designer/list/alexis_v2.png",
        room: "/Images/npc/designer/list/alexis-room.jpg",
        page: "/content/design-services/alexis"
    },
    {
        name: "Jonathan",
        location: "Pittsburgh, PA",
        longitude: "-79.995888",
        portrait: "/Images/npc/designer/list/jonathan_v2.jpg",
        room: "/Images/npc/designer/list/jonathan-room.jpg",
        page: "/content/design-services/jonathan"
    },
    {
        name: "Danielle",
        location: "Pittsburgh, PA",
        longitude: "-79.995888",
        portrait: "/Images/npc/designer/list/danielle.jpg",
        room: "/Images/npc/designer/list/danielle-room.jpg",
        page: "/content/design-services/danielle"
    },
    {
        name: "Erica",
        location: "Sterling Heights, MI",
        longitude: "-83.010979",
        portrait: "/Images/npc/designer/list/erica.jpg",
        room: "/Images/npc/designer/list/erica-room.jpg",
        page: "/content/design-services/erica"
    },
    {
        name: "Shannon",
        location: "Dublin, OH",
        longitude: "-83.114075",
        portrait: "/Images/npc/designer/list/shannon.jpg",
        room: "/Images/npc/designer/list/shannon-room.jpg",
        page: "/content/design-services/shannon"
    },
    // {
    //     name: "Hilda",
    //     location: "Beavercreek, OH",
    //     longitude: "-84.065880",
    //     portrait: "/Images/npc/designer/list/hilda_v2.jpg",
    //     room: "/Images/npc/designer/list/hilda-room.jpg",
    //     page: "/content/design-services/hilda"
    // },
    {
        name: "Jen",
        location: "Indianapolis, IN",
        longitude: "-86.158066",
        portrait: "/Images/npc/designer/list/jen.png",
        room: "/Images/npc/designer/list/jen-room.jpg",
        page: "/content/design-services/jen"
    },
    {
        name: "Jessica",
        location: "South Bend, IN",
        longitude: "-86.251961",
        portrait: "/Images/npc/designer/list/jessica_s.jpg",
        room: "/Images/npc/designer/list/jessica_s-room.jpg",
        page: "/content/design-services/jessica_s"
    },
    {
        name: "Tessa",
        location: "Nashville, TN",
        longitude: "-86.781601",
        portrait: "/Images/npc/designer/list/tessa_v2.jpg",
        room: "/Images/npc/designer/list/tessa-room.jpg",
        page: "/content/design-services/tessa"
    },
    {
        name: "Jessica",
        location: "Chandler, AZ",
        longitude: "-111.841248",
        portrait: "/Images/npc/designer/list/jessica.png",
        room: "/Images/npc/designer/list/jessica-room.jpg",
        page: "/content/design-services/jessica"
    },
    {
        name: "Betsy",
        location: "Chandler, AZ",
        longitude: "-111.841248",
        portrait: "/Images/npc/designer/list/betsy.png",
        room: "/Images/npc/designer/list/betsy-room.jpg",
        page: "/content/design-services/betsy"
    },
    {
        name: "Sonja",
        location: "Mesa, AZ",
        longitude: "-111.833267",
        portrait: "/Images/npc/designer/list/sonja.png",
        room: "/Images/npc/designer/list/sonja-room.jpg",
        page: "/content/design-services/sonja"
    },
    {
        name: "Jill",
        location: "Scottsdale, AZ",
        longitude: "-111.926048",
        portrait: "/Images/npc/designer/list/jill.png",
        room: "/Images/npc/designer/list/jill-room.jpg",
        page: "/content/design-services/jill"
    },
    {
        name: "Erin",
        location: "Scottsdale, AZ",
        longitude: "-111.926048",
        portrait: "/Images/npc/designer/list/erin.png",
        room: "/Images/npc/designer/list/erin-room.jpg",
        page: "/content/design-services/erin"
    },
    {
        name: "Carol-Ann",
        location: "San Marcos, CA",
        longitude: "-117.166145",
        portrait: "/Images/npc/designer/list/carol-ann.jpg",
        room: "/Images/npc/designer/list/carol-ann-room.jpg",
        page: "/content/design-services/carol-ann"
    },
    {
        name: "Nicole",
        location: "Roseville, CA",
        longitude: "-121.288010",
        portrait: "/Images/npc/designer/list/nicole.png",
        room: "/Images/npc/designer/list/nicole-room.jpg",
        page: "/content/design-services/nicole"
    },
    {
        name: "Marilou",
        location: "Tualatin, OR",
        longitude: "-122.761719",
        portrait: "/Images/npc/designer/list/marilou.png",
        room: "/Images/npc/designer/list/marilou-room.jpg",
        page: "/content/design-services/marilou"
    }
];
var len = designers.length;
var pagePath = window.location.pathname.match(/.*?(\/content.*?)(?:\.html|$)/)[1];

if (pagePath == "/content/design-services/meet-our-designers") {
    // var designerBlocks = "";
    var designerParent = document.querySelector('.bcc-fbt .block-wrapper');
    designerParent.innerHTML = "";
    for (var i = 0; i < len; i++) {
        var tempNode = document.createElement("DIV");
        tempNode.innerHTML = "\
        <div class='designer-block'>\
            <img src='https://content.la-z-boy.com" + designers[i].room + "' alt='" + designers[i].name + "&rsquo;s Room'>\
            <div class='designer group'>\
                <div class='designer-portrait'>\
                    <img src='https://content.la-z-boy.com" + designers[i].portrait + "' alt='" + designers[i].name + "&rsquo;s Portrait'>\
                </div>\
                <div class='designer-info'>\
                    <h2>" + designers[i].name + "</h2>\
                    <p>" + designers[i].location + "</p>\
                    <a class='arrow-right' href='" + designers[i].page + "'>View Portfolio</a>\
                </div>\
            </div>\
        </div>";
        designerParent.appendChild(tempNode.firstElementChild);
    }
} else {
    // Find index of current page
    var currentDesignerIndex;
    for (var i = 0; i < len; i++) {
        if (designers[i].page == pagePath) {
            currentDesignerIndex = i;
        }
    }
    // Create carousel
    var start = currentDesignerIndex + len - 4 % len;
    var designerHTML = "";
    var site = typeof LZB != 'undefined' ? LZB.constants.contextLinkPath : '';
    for (var i = start; i < start + len; i++) {
        var j = i % len;
        if (j != currentDesignerIndex) {
            designerHTML += "<a href='" + site + designers[j].page + "'><div class='wrapper'><img src='https://content.la-z-boy.com" + designers[j].portrait + "' alt='" + designers[j].name + "'><h3>" + designers[j].name + "</h3><p class='arrow-right'>View Portfolio</p></div></a>";
        }
    }
    //Load carousel
    document.querySelector('.lzb-browse .designer-carousel').innerHTML = designerHTML;
}

if (pagePath != "/content/design-services/meet-our-designers") {
    // function returns true if jQuery is ready
    function jqIsReady() {
        if (typeof $ === "undefined") {
            return false;
        }
        return true;
    }
    //JQuery Functions
    (function jqCheck() {
        if (!jqIsReady()) {
            setTimeout(jqCheck, 10);
            return;
        } else {
            // When the user clicks on the badge, toggle between hiding and showing the dropdown content
            $('.bcc-fbt .badge').click(function(event) {
                event.stopPropagation();
                $(this).toggleClass('show');
                $(this).siblings().removeClass('show');
            });
            //Close all dropdowns if the user clicks outside of a badge
            $('body').on('click', function() {
                $('.bcc-fbt .badge').removeClass('show');
            });
            // Previous buttons for room gallery
            $(".lzb-gallery .lzb-nav-left").click(function() {
                var $active = $(".lzb-gallery .active").removeClass("active");
                var divs = $active.parent().children();
                divs.eq((divs.index($active) - 1) % divs.length).addClass("active");
            });
            // Next buttons for room gallery
            $(".lzb-gallery .lzb-nav-right").click(function() {
                var $active = $(".lzb-gallery .active").removeClass("active");
                var divs = $active.parent().children();
                divs.eq((divs.index($active) + 1) % divs.length).addClass("active");
            });


            var carousel = $('.lzb-browse .designer-carousel')[0];

            //Previous button for Browse Designers
            $(".lzb-browse .lzb-nav-left").click(function() {
                var leftDesigner = $('.lzb-browse .designer-carousel a:nth-child(2)')[0];
                if ($('span.designer-carousel').css('display') == 'none') {
                    window.location.href = leftDesigner.getAttribute('href');
                } else {
                    $(carousel.lastElementChild).insertBefore(carousel.firstElementChild);
                }
            });

            //Next button for Browse Designers
            $(".lzb-browse .lzb-nav-right").click(function() {
                var rightDesigner = $('.lzb-browse .designer-carousel a:nth-child(3)')[0];
                if ($('span.designer-carousel').css('display') == 'none') {
                    window.location.href = rightDesigner.getAttribute('href');
                } else {
                    $(carousel.firstElementChild).insertAfter(carousel.lastElementChild);
                }
            });

        }
    })();
}