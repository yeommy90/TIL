var chevy = {
  make: "쉐보레",
  model: "벨 에어",
  year: 1957,
  color: "Red",
  passengers: 2,
  convertible: false,
  mileage: 1021,
  started: false,
  start: function() {
    this.started = true;
  },
  stop: function() {
    this.started = false;
  },
  drive: function() {
    if(this.started) {
      alert(this.make + " " + this.model + "이(가) 붕붕 달려용");
    } else {
      alert("먼저 시동을 거세요");
    }
  }
};

var cadi = {
  make: "GM",
  model: "캐딜락",
  year: 1995,
  color: "Brown",
  passengers: 5,
  convertible: false,
  mileage: 12892,
  started: false,
  start: function() {
    this.started = true;
  },
  stop: function() {
    this.started = false;
  },
  drive: function() {
    if(this.started) {
      alert(this.make + " " + this.model + "이(가) 붕붕 달려용");
    } else {
      alert("먼저 시동을 거세요");
    }
  }
};

var fiat = {
  make: "피아트",
  model: "500",
  year: 1957,
  color: "Navy",
  passengers: 2,
  convertible: false,
  mileage: 88000,
  started: false,
  fuel: 0,
  start: function() {
    if(this.fuel==0) {
      alert("연료통이 비었어용. 채워주세용");
    } else {
      this.started = true;
    }
  },
  stop: function() {
    this.started = false;
  },
  drive: function() {
    if(this.started) {
      if(this.fuel>0) {
        alert(this.make + " " + this.model + "이(가) 붕붕 달려용");
        this.fuel = this.fuel - 1;
      } else {
        alert("연료가 떨어졌어용!");
        this.stop();
      }
    } else {
      alert("먼저 시동을 거세용");
    }
  },
  addFuel: function(amount) {
    this.fuel = this.fuel + amount;
  }
};

var taxi = {
  make: "웹타운 모터스",
  model: "택시",
  year: 1955,
  color: "Yellow",
  passengers: 4,
  convertible: false,
  mileage: 281341,
  started: false,
  start: function() {
    this.started = true;
  },
  stop: function() {
    this.started = false;
  },
  drive: function() {
    if(this.started) {
      alert(this.make + " " + this.model + "이(가) 붕붕 달려용");
    } else {
      alert("먼저 시동을 거세요");
    }
  }
};

fiat.start();
fiat.drive();
fiat.addFuel(2);
fiat.start();
fiat.drive();
fiat.drive();
fiat.drive();
fiat.stop();
