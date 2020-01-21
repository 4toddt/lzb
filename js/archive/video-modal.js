
// Move modal to top of <body>
var elem = document.getElementById('video-modal');
var body = document.body;
body.insertBefore(elem, body.firstChild);

var modal = document.getElementById('video-modal');
var videoPane = document.getElementById('video-modal-content');
var closeButton = document.getElementById('video-modal-close');
var videoIframe = document.getElementById('video-modal-video-iframe');

// Function to play the modal video. DD video is 'P1li3aQv3eQ'.
function playVideo(srcID) {
    var source = 'https://www.youtube.com/embed/' + srcID + '?rel=0&amp;ecver=2&amp;enablejsapi=1&amp;showinfo=0&amp;autoplay=1';
    videoIframe.setAttribute('src', source);
    modal.style.display = 'block';
    return false;
}

// When the user clicks on <span> (x), close the modal
closeButton.onclick = function () {
    modal.style.display = 'none';
    videoIframe.setAttribute('src', '');
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function (event) {
    if (event.target == modal) {
        modal.style.display = 'none';
        videoIframe.setAttribute('src', '');
    }
}

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

// Play the video in the query string
if (vars['video'] != null) {
    playVideo(vars['video']);
}