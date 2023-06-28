# Head First JavaScript Programming

<br>

## 자바스크립트 간단히 맛보기

+ 자바스크립트는 웹 페이지에 동적 기능을 추가하기 위해 사용됩니다.
+ 동적인 웹 환경에서는 사용자가 페이지와 대화하고 새로운 데이터가 바로바로 표시되고 여러 이벤트가 발생합니다.
+ 브라우저는 웹 페이지에서 자바스크립트 코드를 바로 실행합니다.

<br>

## 진짜 코드 만들기

+ 플로우차트를 이용해 자바스크립트 프로그램의 논리를 설계하고 분기점이나 행동을 보여줍니다.
+ 실제 자바스크립트 코드와 일반적인 말로 프로그램을 표현한 것의 중간이라고 볼 수 있는 의사코드를 작성해 필요한 변수와 프로그램의 논리를 설명합니다.
+ 의사코드를 진짜 자바스크립트 코드를 짜기 위한 설계도로 사용합니다.
+ 품질 보증(Quality Assurance) 은 소프트웨어의 결함을 찾아내는 검사 프로세스로 여러 가지 조작을 통해 결함을 찾아낼 수 있습니다.
+ 함수는 그 이름을 호출해 코드를 사용하고 또 재사용할 수 있는 강력한 기능입니다.

<br>

## 함수 개요

+ 복잡한 부분을 간단히 생각할 수 있게 해주는 방법을 추상화라고 합니다.
+ 자바스크립트 함수는 함수에 인자를 전달할 때 값을 복사하고 해당 파라미터에 할당합니다.
+ 함수 안에서 파라미터의 값을 바꿔도 함수에 전달된 원래 값은 바뀌지 않습니다.
+ 전역 변수를 과도하게 사용하면 이 변수들이 어디에서 쓰이고 어디에서 바뀌는지 알아내기 힘들고 코드에 버그가 생기게 됩니다.
+ 전역 변수의 범위는 단 하나뿐이므로 여러 개의 파일을 동시에 로딩하면 별도의 스코프를 갖지 않고 하나의 전역 변수 집합이 됩니다. 충돌을 피하기 위해 전역 변수를 줄이거나 아예 제거하는 편이 좋습니다.

<br>

## 순서가 있는 데이터 - 배열

+ 배열은 순서가 있는 여러 값을 저장할 수 있고 비슷한 것들을 하나로 묶기 위해 배열을 사용합니다. 숫자나 문자열처럼 단 하나의 값만 보관하는 변수와는 다릅니다.
+ while 문은 카운터를 초기화하고 증가시키는 문장을 따로 사용해야 합니다. 코드를 고치다보면 실수가 발생할 수 있습니다.
+ for 문은 초기화하고 증가시키는 코드가 제일 앞에 나오기 때문에 유지보수가 쉽습니다.
+ while 문은 루프를 몇 번 반복해야 하는지 잘 모르는 경우에 사용하고, 루프 횟수를 알고 있다면 for 문이 훨씬 간단합니다.
+ 리팩토링은 코드가 하는 일은 바꾸지 않고 코드를 읽고 유지보수 하기 쉽게 재구성하는 것을 말합니다.

<br>

## 객체 개요

+ 단순한 문장, 조건식, 루프, 배열과 함수를 사용하면서 절차적인 방식으로 코드를 만들었다면, 앞으로는 문제를 상태와 행동으로 구성된 객체 중심의 관점에서 바라보도록 합니다.
+ 예를 들어 물을 끓일 때 물리학적 원리에 따라 전선을 이용해 전열선을 만들고 전기에 연결하고 냄비에 물을 넣고 끓이고 전열선의 전기를 차단하는 과정이 절차적인 방식이라면, 그냥 전기포트에 물을 넣고 버튼을 누른다는 간단한 메서드를 지원하는 전기포트 객체라고 생각하는 것이 객체지향형 프로그래밍 입니다.
+ 객체는 복잡한 데이터를 한데 모아서 상위 수준에서 코드 설계를 볼 수 있게 해줍니다. 예를 들어 수십 대의 자동차에 대한 교통 시뮬레이터를 만든다고 할 때, 수백 개의 자잘한 변수보다는 자동차, 신호 등 도로 객체들에 집중할 수 있어야 하고 객체는 여러 복잡한 상태와 행동을 캡슐화 해주므로 전체적으로 코드를 이해하기 쉬워집니다.
+ 객체를 변수에 할당할 때는 객체 자체가 아니라 객체에 대한 참조(객체에 대한 포인터)가 변수에 저장됩니다.  따라서 객체를 전달하면서 함수를 호출할 때는 객체 자체가 아니라 값으로 전달하는 방식을 사용해 객체 참조의 사본이 파라미터에 저장되고 이 참조는 여전히 원래 객체를 가리키게 됩니다. 이 경우 함수 안에서 객체의 속성을 바꾸면 참조는 원래 객체를 가리키고 있기 때문에 원래 객체의 속성도 바뀌게 됩니다.
+ 메서드 안에서 자기 객체의 속성에 접근해야 하는 경우라면 이 속성이 어느 객체에 속하는지 반드시 알려주어야 합니다. 속성이 이 객체에 속해 있다는 것을 명시적으로 알려주기 위해 this 키워드를 사용합니다.
+ 메서드는 객체에 들어있는 속성명에 할당된 함수일 뿐이므로 메서드를 호출할 때는 객체명.메서드명을 정확히 써주어야 합니다. 메서드 안에서 자기 자신이 속한 객체를 가리킬 때에는 this 키워드를 사용합니다.
+ this 는 객체를 정의할 때가 아닌 메서드를 호출할 때 정해집니다.
+ 자바스크립트는 바로 사용할 수 있도록 내장된 객체를 제공합니다. (Math, Date, RegExp, JSON)

<br>

## 웹 페이지와 대화를 - DOM

+ 웹 페이지가 로딩될 때, 브라우저는 html 문서를 파싱하고 화면에 출력합니다. 출력할 때 태그를 나타내는 각각의 객체를 만들고 이 객체는 DOM 에 저장됩니다. 자바스크립트는 이 DOM 과 대화하고 DOM 요소에 접근해 요소를 생성하고 변경할 수 있습니다. 자바스크립트가 DOM 을 수정하면 웹 페이지가 동적으로 갱신되므로 웹 페이지에서 새로운 내용을 볼 수 있습니다.

+ 문서 객체 모델은 웹 페이지를 브라우저 내부에서 표현하는 형태입니다.
+ document 객체는 DOM 에 접근하고 수정할 수 있게 해주는 속성과 메서드를 갖고 있습니다.
+ 요소 객체는 요소의 내용을 읽거나 변경할 수 있게 해주는 속성과 메서드를 갖고 있습니다.
+ window 객체의 onload 속성을 이용해 페이지의 로딩이 완료되었을 때 이벤트 처리기, 혹은 콜백 함수를 설정할 수 있습니다.
+ getElementsById() 사용시 해당 아이디를 가진 요소를 찾지 못하면 null을 반환합니다.

<br>

## 형, 일치, 변환 기타 등등

+ 자바스크립트에는 기본형(숫자, 문자열, 불린형, null, undefined)과 객체 두가지 형이 있고, 기본형이 아닌 값은 모두 객체입니다.

+ undefined는 값이 초기화되지 않은 변수, 존재하지 않는 객체의 속성, 배열 안에서 값이 할당되어 있지 않은 요소를 나타냅니다.

+ null은 '객체가 없음'을 의미합니다.

  ```javascript
  var test1 = null;
  console.log(typeof test1); // object
  // 어떤 객체가 아직 존재하지 않음을 나타냅니다.
  ```

+ NaN는 표현할 수 없는 숫자라는 의미로 숫자형입니다. 또한 어떤 숫자와도 똑같지 않고 자신과도 같지 않습니다. NaN인지 검사하려면 isNaN() 함수를 사용해야 합니다.

+ 객체 참조를 담고 있는 변수가 동일한 객체를 참조하고 있을 때에만 두 객체 변수가 일치합니다.

+ falsy : undefined, null, 0, "", false

+ 문자열 조작 메서드

  - substring() : 두 개의 인자를 전달하면 두 인덱스 사이의 문자열을 반환합니다.
  - indexOf() : 문자열을 인자로 받아 이 문자열이 처음으로 나타나는 인덱스 번호를 반환합니다.
  - charAt() : 인덱스 번호를 인자로 받아 해당 위치의 문자열을 반환합니다.

<br>

## 전함 게임 만들기

+ model : 게임의 상태를 저장하고 상태를 변화시키는 논리를 구현하는 책임을 집니다. (전함갯수, 명중여부, 격침여부, 전함생성)
+ view : 모델 안에서 상태 변화가 일어났을 때 화면을 갱신하는 책임을 집니다. (displaymsg, displayhit, displaymiss)
+ controller : 각 객체를 연결해 게이머가 추측한 값이 모델에 전달되어 게임 상태가 갱신되도록 보장하고 게임이 종료되었는지 확인하는 책임을 집니다. (유저의 추측값)
+ onload 되면 전함생성 후 유저의 입력값을 받아 controller에 전달 -> 입력값 유효성 검사 후 숫자로 변환해 model에 전달하고 명중여부, 격침여부 확인 -> view에서 화면 갱신

<br>

## 비동기 코딩

+ 대부분의 자바스크립트 코드는 이벤트에 응답하기 위해 작성됩니다.
+ 이벤트에 응답하려면 이벤트 처리기 함수를 작성하고 등록합니다. 예를 들어 클릭 이벤트에 처리기를 등록하려면 처리기 함수를 요소의 onclick 속성에 할당합니다.
+ 이벤트를 처리하도록 작성한 코드는 위에서 아래로 차례대로 모두 실행되는 코드와는 다릅니다. 이벤트 처리기는 언제 어떤 순서로도 실행될 수 있으므로 <b>비동기</b>적입니다.
+ DOM 요소의 이벤트는 이벤트 종류 및 타깃 등 이벤트에 대한 추가 정보를 가진 속성을 담은 이벤트 객체를 이벤트 처리기에 전달합니다. (click, load, e.target 등)
+ 여러 이벤트가 짧은 시간 안에 발생할 경우, 이벤트 큐에 발생한 순서대로 저장하고 나서 브라우저가 하나씩 처리합니다.

```javascript
window.onload = function() {
    var images = document.getElementByTagName("img");
    for (var i = 0; i < images.length; i++) {
        images[i].onclick = showAnswer;
    }
}

// img 태그를 가져온 images DOM 요소의 onclick 속성에 이벤트 객체를 담은 이벤트 처리기를 전달합니다.
function showAnswer(e) {
    var image = e.target;
    image.src = image.id + ".jpg";
}
```

+ setTimeout()과 setInterval() 함수는 일정한 시간이 지난 후에 시간 이벤트를 발생시킵니다.

```javascript
// 이벤트 처리기는 그저 경고창만 보여줍니다.
function timerHandler() {
    alert("머해용");
}

// 스톱워치, 5초를 기다린 후 처리기를 호출합니다.
setTimeout(timerHandler, 5000);
```

<br>

## 일급 함수

#### 함수 선언문과 함수 표현식

+ 함수는 함수 선언문이나 함수 표현식을 이용해 정의할 수 있습니다.
+ 함수 선언문은 브라우저가 코드를 평가하기 전에 먼저 함수 선언을 처리하고 평가할 때 함수와 함께 함수명과 동일한 변수를 생성합니다. 이 변수에는 함수 참조가 저장됩니다.
+ 함수 표현식은 나머지 코드와 마찬가지로 코드를 실행할 때 평가됩니다. 브라우저가 함수 표현식을 평가할 때 함수를 생성하지만 이 함수에 대한 참조를 관리하는 건 개발자의 몫입니다.

#### 일급 값과 일급 함수

+ 일급값은 변수에 할당하거나, 데이터 구조체에 포함시키거나, 함수에 전달하거나, 함수에서 반환할 수 있습니다.
+ 함수 참조는 일급값입니다.
+ 함수도 숫자, 문자열, 불린형, 객체와 똑같은 값이고 호출할 수 있다는 점이 나머지 값들과 다를 뿐입니다.
+ 함수에 대한 참조를 이용해 언제든 함수를 호출할 수 있습니다.
+ 새로운 검사를 추가하거나 기존 검사 함수에 대한 요구사항이 바뀌거나, 승객을 나타내는 데이터 구조가 바뀔 경우, 융통성을 가진 구조로 만든다면 코드를 추가하거나 바꿀 때 전체적인 복잡도를 줄여서 버그가 생길 가능성을 줄일 수 있습니다.

```javascript
var passengers = [
  { name: "김함수", paid: true, ticket: "일반석" },
  { name: "닥터 이블", paid: true, ticket: "일등석" },
  { name: "박루프", paid: false, ticket: "일등석" },
  { name: "최호출", paid: true, ticket: "우등석" }
];

// 승객의 배열, 각 승객에 대해 조건을 검사하는 방법을 알고 있는 함수를 파라미터로 갖습니다.
function processPassengers(passengers, testFunction) {
  for (var i = 0; i < passengers.length; i++) {
    if (testFunction(passengers[i])) { // 전체 승객에 대해 반복합니다.
      return false; // 검사에 실패하면 이륙할 수 없습니다.
    }
  }
  return true;
}

// 승객 한 명을 파라미터로 갖습니다.
function checkNoFlyList(passenger) {
  return (passenger.name === "닥터 이블");
}
function checkNotPaid(passenger) {
  return (!passenger.paid); // 지급하지 않았다면 true를 반환합니다.
}

// 함수에 함수를 전달합니다.
var allCanFly = processPassengers(passengers, checkNoFlyList);
var allPaid = processPassengers(passengers, checkNotPaid);
if (!allCanFly || !allPaid) {
  console.log("이륙 불가");
}
```

+ 함수를 설계할 때에는 하나의 함수가 하나의 일만 제대로 하게 하는 것이 일반적인 원칙입니다.

```javascript
// 이 함수는 음료제공, 영화상영, 식사제공 등 서비스하는 하나의 일만 해야합니다.
function serveCustomer(passenger) {
  createDrinkOrder(passenger);
}

// 음료수 주문을 처리하는 코드를 별도로 만듭니다.
function createDrinkOrder(passenger) {
  if (passenger.ticket === "일등석") {
    alert("칵테일, 와인");
  } else {
    alert("물, 콜라");
  }
}
```

+ 함수 자체를 매번 실행하는 것보다 함수가 반환한 함수 자체를 저장한 변수를 사용하는 것이 더 간단합니다.

```javascript
function serveCustomer(passenger) {
  var getDrinkOrderFunction = createDrinkOrder(passenger); // 함수가 반환한 함수 자체를 저장한 변수
  getDrinkOrderFunction();
}

function createDrinkOrder(passenger) {
  var orderFunction;

  if (passenger.ticket === "일등석") {
    orderFunction = function() {
      alert("칵테일, 와인");
    };
  } else {
    orderFunction = function() {
      alert("물, 콜라");
    };
  }
  return orderFunction; // 함수가 반환한 함수
}
```

#### 배열의 sort() 메서드 사용법

+ 자바스크립트 배열은 sort()라는 메서드를 갖고 있어서 배열에 있는 두 요소를 비교하는 방법을 아는 함수를 전달하면 배열을 정렬할 수 있습니다.
+ 전달할 비교 함수는 비교하는 두 요소에 따라 0보다 큰 값, 0, 0보다 작은 값을 반환합니다.

```javascript
var numberArray = [60, 50, 62, 58, 54, 54];

function compareNumbers(num1, num2) {
	if (num1 > num2) { // 오름차순 정렬입니다. (내림차순의 경우 num2 > num1)
		return 1;
	} else if (num1 === num2) {
		return 0;
	} else {
		return -1;
	}
}

numbersArray.sort(compareNumbers);
console.log(numberArray);
```

<br>

## 익명함수, 범위, 클로저

#### 익명 함수

+ 함수 선언문으로 함수를 정의할 때에는 이름이 반드시 붙지만, 함수 표현식으로 정의할 때에는 꼭 붙여야 하는 것은 아닙니다.
+ 익명 함수(Anonymous Function)를 사용하면 코드가 훨씬 더 간결해지고 읽기 좋아지며 유지보수성도 좋아집니다.

```javascript
function handler() { alert("로딩 완료!"); }
window.onload = handler;
                           
window.onload = function() { alert("로딩 완료!"); };

// 1. handler 변수는 단지 window.onload 속성에 할당하기 위해 존재한다.
// 2. 페이지가 로딩될 때에만 실행하기 위한 것으로 코드 안에서 handler를 다시 사용하지 않는다.
```

+ 함수 참조가 필요한 곳이라면 어디든 함수 표현식을 대신 쓸 수 있습니다. 함수 표현식을 평가하면 함수 참조가 되기 때문입니다.

```javascript
function cookieAlarm() {
	alert("쿠키 꺼내");
}
setTimeout(cookieAlarm, 600000);

setTimeout(function() { 
  	  alert("쿠키 꺼내"); 
	}, 600000);
```

#### 범위

+ 함수를 다른 함수 안에 넣으면(중첩) 안에 있는 함수를 볼 수 있는 범위가 제한됩니다.
+ 코드의 최상위 수준(전역)에서 정의된 함수는 전역 범위에 들어가지만, 다른 함수 안에서 정의된 함수는 지역 범위에 들어갑니다. 
+ 렉시컬 스코프(Lexical Scope) : 눈으로 보는 코드의 정적인 구조에 따라 변수의 범위를 정한다는 것을 의미합니다.
+ 자바스크립트 함수는 언제나 자신이 정의된 범위 환경에서 평가됩니다. 함수 안에서 어떤 변수가 어디에서 오는지 알고 싶다면 가장 가까이에서 에워싸고 있는 함수에서 최상위 함수로 올라가면서 검색하세요.

```javascript
var justVar = "전역 변수";

function whereAreYou() {
	var justVar = "지역 변수";
	return justVar;
}

var result = whereAreYou();
console.log(result); // 지역 변수
```

```javascript
var justVar = "전역 변수";

function whereAreYou() {
	var justVar = "지역 변수";
    
	function inner() {
		return justVar;
	}
    
	return inner(); // inner 함수는 전역 변수가 아니라 정적인 코드에서 자신과 가장 가까운 지역 변수를 반환합니다.
}

var result = whereAreYou();
console.log(result); // 지역 변수
```

```javascript
var justVar = "전역 변수";

function whereAreYou() {
	var justVar = "지역 변수";
    
	function inner() {
		return justVar;
	}
    
	return inner; // inner 함수를 그저 반환하지만 inner 가 가진 환경에 따라 지역 변수를 반환합니다.
}

var innerFunction = whereAreYou();
var result = innerFunction();
console.log(result);

// 모든 지역 변수는 환경에 저장됩니다.
// 함수를 반환할 때에는 함수뿐 아니라 함수와 연결된 환경도 함께 반환합니다.
```

#### 클로저

+ 클로저는 참조하는 환경을 갖고 있는 함수입니다.
+ 자유변수는 지역 범위에서 정의되지 않은 변수입니다.
+ 함수를 닫는다는 것은 필요한 모든 자유 변수들을 제공하는 것을 말합니다.
+ 모든 자유 변수에 대한 값을 갖고 있는 환경을 가질 때 함수를 '닫는다' 라고 합니다. 자유 변수가 있는 함수와 자유 변수를 알 수 있는 환경을 결합하면 클로저가 됩니다.

```javascript
var count = 0;

function counter() {
	count = count + 1;
	return count;
}

console.log(counter());
// count를 전역 변수로 사용한다는 문제점이 있습니다.
```

```javascript
function makeCounter() {
	var count = 0;
	
	function counter() {
		count = count + 1;
		return count;
	}
	return counter;
}
var doCount = makeCounter();
console.log(doCount());
console.log(doCount());
console.log(doCount());
// 전역에서는 count 변수를 볼 수 없습니다.
// count 자유 변수를 가진 counter 함수는 닫혀있고 그 환경을 포함해 클로저가 됩니다.
```

```javascript
function makeCounter() {
	var count = 0;
	
	return {
		increment: function() {
			count++;
			return count;
		}
	};
}

var counter = makeCounter();
console.log(counter.increment());
console.log(counter.increment());
console.log(counter.increment());
```

#### 이벤트 처리기로 클로저 생성하기

```javascript
var count = 0;

window.onload = function() {
	var button = document.getElementById("clickme");
    button.onclick = handleClick;
};

function handleClick() {
	var message = "나를 ";
	var div = document.getElementById("message");
	count++
	div.innerHTML = message + count + "번 눌렀따";
}
// 전역 변수를 사용하면 문제가 생길 수 있습니다.

window.onload = function() {
	var count = 0;
	var message = "나를 ";
	var div = document.getElementById("message");
	var button = document.getElementById("clickme");

	button.onclick = function() {
		count++;
		div.innerHTML = message + count + "번 눌렀따";
	};
};
// onclick 속성에 할당된 함수에는 3개의 자유 변수가 있습니다. 이는 클로저입니다.
```





















