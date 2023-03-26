window.onload = init;

function init() {
  var images = document.getElementsByTagName("img");
  for (var i = 0; i<images.length; i++) {
    images[i].onclick = showAnswer;
  }
}

function showAnswer(e) {
  var image = e.target;
  image.src = image.id + ".jpg";

  setTimeout(function() {
    image.src = image.id + "blur.jpg";
  }, 2000);
}