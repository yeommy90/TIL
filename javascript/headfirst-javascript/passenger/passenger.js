var passengers = [
  { name: "김함수", paid: true, ticket: "일반석" },
  { name: "닥터 이블", paid: true, ticket: "일등석" },
  { name: "박루프", paid: false, ticket: "일등석" },
  { name: "최호출", paid: true, ticket: "우등석" }
];

function checkNoFlyList(passenger) {
  return (passenger.name === "닥터 이블");
}
function checkNotPaid(passenger) {
  return (!passenger.paid);
}
function processPassengers(passengers, testFunction) {
  for (var i = 0; i < passengers.length; i++) {
    if (testFunction(passengers[i])) {
      return false;
    }
  }
  return true;
}

var allCanFly = processPassengers(passengers, checkNoFlyList);
var allPaid = processPassengers(passengers, checkNotPaid);
if (!allCanFly || !allPaid) {
  console.log("이륙 불가");
}

function printPassenger(passenger) {
  console.log(passenger.name);
  return false;
}

processPassengers(passengers, printPassenger);

function serveCustomer(passenger) {
  var getDrinkOrderFunction = createDrinkOrder(passenger);
  var getDinnerOrderFunction = createDinnerOrder(passenger);

  getDrinkOrderFunction();
  getDinnerOrderFunction();
}

function createDrinkOrder(passenger) {
  var orderFunction;

  if (passenger.ticket === "일등석") {
    orderFunction = function() {
      alert("칵테일, 와인");
    };
  } else if (passenger.ticket === "우등석") {
    orderFunction = function() {
      alert("물, 콜라, 와인");
    };
  } else {
    orderFunction = function() {
      alert("물, 콜라");
    }
  }
  return orderFunction;
}

function createDinnerOrder(passenger) {
  var orderFunction;

  if (passenger.ticket === "일등석") {
    orderFunction = function() {
      alert("닭, 파스타");
    };
  } else if (passenger.ticket === "우등석") {
    orderFunction = function() {
      alert("과자, 치즈");
    };
  } else {
    orderFunction = function() {
      alert("땅콩, 프레첼");
    }
  }
  return orderFunction;
}

function servePassengers(passengers) {
  for (var i = 0; i < passengers.length; i++) {
    serveCustomer(passengers[i]);
  }
}

servePassengers(passengers);