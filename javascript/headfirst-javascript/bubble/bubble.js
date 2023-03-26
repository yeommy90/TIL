var scores = [60, 50, 60, 58, 54, 54, 58, 50, 52, 52, 48, 69, 34, 55, 51, 52, 52, 44, 51, 69, 65, 64, 66, 52, 44, 18, 25, 41, 53, 44, 51];
var costs = [.25, .27, .25, .25, .25, .25, .33, .31, .25, .29, .27, .22, .31, .25, .25, .33, .21, .25, .25, .25, .28, .25, .24, .25, .25, .25, .27, 25, .26, .29, .25];

function printAndGetHighScore(scores) {
  var highscore = 0;
  var output;

  for (var i=0; i<scores.length; i++) {
    output = "비눗방울 용액 #" + i + " 점수 : " + scores[i];
    console.log(output);
    if (highscore<scores[i]) {
      highscore = scores[i];
    }
  }
  return highscore;
}

function getBestResults(scores, highscore) {
  var bestSolutions = [];

  for (var i=0; i<scores.length; i++) {
    if (highscore==scores[i]) {
      bestSolutions.push(i);
    }
  }
  return bestSolutions;
}

function getMostCostEffectiveSolution(scores, costs, highscore) {
  var cost = 100;
  var index;

  for(var i=0; i<scores.length; i++) {
    if(scores[i]==highscore) {
      if(costs[i]<cost) {
        cost = costs[i];
        index = i;
      }
    }
  }
  return index;
}

var highscore = printAndGetHighScore(scores);
console.log("비눗방울 실험 횟수 : " + scores.length);
console.log("최고 비눗방울 점수 : " + highscore);

var bestSolutions = getBestResults(scores, highscore);
console.log("최고 점수 용액 번호 : " + bestSolutions);

var mostCostEffective = getMostCostEffectiveSolution(scores, costs, highscore);
console.log("비눗방울 용액 #" + mostCostEffective + "이 비용 효율이 가장 좋아용");