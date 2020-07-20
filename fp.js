let body = document.querySelector('body');
let fingerprint = document.querySelector('.fingerprint');
let center = document.querySelector('.center');
let scan = document.querySelector('.scan');
let timer, timerSuccess;

function onSuccess() {
  body.removeEventListener('mousedown', onTouchStart);
  body.removeEventListener('touchstart', onTouchStart);

  fingerprint.classList.remove('active');
  center.classList.add('success');

  clearTimeout(timerSuccess);

  timerSuccess = setTimeout(() => {
    body.addEventListener('mousedown', onTouchStart);
    body.addEventListener('touchstart', onTouchStart);

    center.classList.remove('success');
  }, 3000);
}

function onTouchStart() {
  fingerprint.classList.add('active');
  timer = setTimeout(onSuccess, 2000);
}

function onTouchEnd() {
  fingerprint.classList.remove('active');
  clearTimeout(timer);
}

body.addEventListener('mousedown', onTouchStart);
body.addEventListener('touchstart', onTouchStart);
body.addEventListener('mouseup', onTouchEnd);
body.addEventListener('touchend', onTouchEnd);


$(document).ready(function(){
  $(".success").click(function(){
    $("body").fadeOut();
    $("body").delay(500);
    $("body").html('<meta http-equiv="refresh" content="1;URL=index.html">')
  });
    $("div.center.success").click(function(){
    $("body").fadeOut();
    $("html").html('<meta http-equiv="refresh" content="4;URL=index.html">');
   // $("body").
  });
});
