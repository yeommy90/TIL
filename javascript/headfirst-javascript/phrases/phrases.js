function makePhrases() {
  var words1 = ["아름다운", "예쁜", "건강한", "슬기로운", "매력적인"];
  var words2 = ["서영이를", "재준이를"];
  var words3 = ["잡아먹기", "칭찬해주기", "집에보내기", "마구때리기", "청소시키기"];

  var rand1 = Math.floor(Math.random() * words1.length);
  var rand2 = Math.floor(Math.random() * words2.length);
  var rand3 = Math.floor(Math.random() * words3.length);

  var phrase = words1[rand1] + " " + words2[rand2] + " " + words3[rand3];
  alert(phrase);
}
makePhrases();

