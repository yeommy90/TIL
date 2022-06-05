# Do it! 자바스크립트 입문

## 02. 자바스크립트와 친해지기

### 02-6 자바스크립트 작성시 지켜야 할 규칙

+ 대소문자를 구별하여 작성
+ 들여쓰는 습관
+ 세미콜론으로 문장을 구분
+ 주석 사용
  - 한줄 주석 : //
  - 여러줄 주석 : /* 줄바꿈 */
+ 예약어 사용 주의



## 03. 변수와 자료형 그리고 연산자

### 03-1 변수를 선언하는 규칙

+ 의미를 가진 변수명

+ Camel Case

+ 첫 글자는 반드시 문자, 밑줄(_), 달러기호($)

+ 예약어

  - let : 모던한 변수 선언 키워드, 코드 블록을 벗어나면 사용할 수 없음

  - const : 변수의 값을 변경할 수 없음 = 상수

  - var : 중복 선언 가능 = 예상하지 못한 결과가 나올 수 있음

    함수레벨스코프 = 함수 외부에서 선언하면 전역변수로 취급됨

  - 변수의 스코프는 최대한 좁게 만드는 것을 권장

    

###  03-2 자료형 이해하기

+ Weak Data Type Check : 자료형을 지정하지 않고 값을 바로 할당 = 값을 꼭 확인!
+ Strong Data Type Check : 자료형을 미리 지정 후 값을 할당 (C, java)
+ Typescript : 자바스크립트에 강한 유형을 추가



### 03-3 연산자 이해하기

+ 증감 연산자 
  - a++ : 전체 수식의 처리가 끝난 다음 적용
  - ++a : 전체 수식을 처리하기 전에 적용



## 04. 제어문

### 04-1 조건 연산자

+ 조건 ? true : false
+ truthy / falsy (0, 공백, null, undefined)



### 04-2 switch문

+ 조건이 3개 이상일때 사용

+ ```javascript
  switch(변수) { 
    case "1" : 실행코드;
    	break;
    case "2" : 실행코드;
    	break;
    case "3" : 실행코드;
   	break;
  default: 실행코드;
  }
  ```



### 04-3  for문

+ 초기값이 있으면서 일정한 간격으로 반복할 때 사용



### 04-5 while, do~while문

+ while : 조건부터 확인 / 조건에 맞지 않을 경우 명령을 실행하지 않음
+ do~while : 일단 실행하고 조건을 확인 / 일단 실행한 후 상황에 따라 반복



### 04-6 break문, continue문

+ break : 반복문의 흐름에서 바로 빠져나올때
+ continue : 다음 명령을 건너뛸때





## 05. 함수와 이벤트

### 05-2 let과 constant

+ 스코프 : 변수를 선언하고 사용할때 변수가 적용되는 범위

  - 지역변수/로컬변수 : 한 함수 안에서만 사용
  - 전역변수/글로벌변수 : 스크립트 전체에서 사용

+ 호이스팅 : 변수의 선언 부분을 스코프의 가장 먼저 해석하는 것

+ var 이 없으면 함수 내에 있어도 전역변수로 취급

+ var : 재선언, 재할당 가능, 함수 레벨, 호이스팅(undefined) 

  -> 변수명이 겹치거나 연결될 수 있음

+ let : 재선언 불가, 재할당 가능, 블록 레벨, 호이스팅 없음(오류메세지)

+ const : 상수, 재선언, 재할당 불가, 블록 레벨

+ 전역 변수는 최소한으로 사용한다.

+ var 변수는 함수의 시작 부분에서 선언한다.

+ for문에서 사용할 경우 블록 변수를 사용하는 것이 좋다.



### 05-4 함수 표현식

+ 익명함수 : 함수 자체를 변수에 할당 -> 변수를 함수 이름처럼 사용해 실행

+ 실행함수 : 함수 선언 자체를 괄호로 묶음

+ 화살표함수 : 

  ```javascript
  const hi = function() {
  	return "안녕";
  }
  
  const hi = () => { return "안녕" };
  ```

+ 함수 선언 -> 함수 호출 반드시 해야함!!!!
+ return : 함수 실행 후 결과값을 함수 호출한 위치로 넘기는 것



### 05-5 이벤트 다루기

+ 이벤트 처리기 : on+이벤트명 (onclick)

  ```javascript
  var coverImage = document.queryselector("#cover");
  coverImage.onclick = function() {
  	alert("왜눌렀나용");
  }
  ```



## 06. 객체

### 06-1 객체란?

+ 자바스크립트에서 인식할 수 있는 모든 대상 = 복합 자료형
+ 내장객체 : Number, Boolean, Array, Math, Date ...
+ 문서객체모델(DOM) : 객체를 사용해 웹문서를 관리하는 방식, Document, Image ...
+ 브라우저객체모델 : 웹브라우저 정보(주소표시줄, 창크기)를 객체로 다루는 방식
+ 사용자정의객체 : 사용자가 직접 정의
+ property / method : 값을 담고있는 정보 / 객체가 어떻게 동작할지 선언해놓은 함수 

+ prototype : 공통으로 가지는 속성과 기능을 모아놓은 틀

+ instance : 프로토타입을 사용해 만들어낸 객체

  ```javascript
  var now = new Date()
  // new 예약어로 Date 객체의 인스턴스를 만들고 now 변수에 저장
  ```



### 06-2 사용자 정의 객체

+ 리터럴 표기법 : 변수를 선언하면서 동시에 값을 지정

  ```javascript
  var book = {
      title: "자바스크립트",
      author: "서여미",
      price: 15000,
      info: function() {
          alert(this.title + "책은 " + this.pages + "쪽입니당");
      }
  };
  ```

  - 공통으로 들어가는 속성과 함수가 별로 없다면 각 객체를 따로 정의

+ 생성자 함수 : 객체 틀(prototype)을 만들어두고 instance에 정보 값을 담는 방법

  ```javascript
  function Book(author, pages, price, title) {
  	this.author = author;
  	this.pages = pages;
  	this.price = price;
  	this.title = title;
  }
  var jsBook = new Book("서여미", 500, 15000, "자바스크립트")
  ```

  - 객체 생성자 : Book (첫글자 대문자로 시작)



### 06-3 Date 객체

+ getMonth : 0~11의 숫자로 월을 표시, 0=1월

+ getDay : 0~6의 숫자로 요일을 표시, 0=일요일

  ```javascript
  now.setDate(now.getDate() + 50)
  ```

  



## 07. Array

### 07-1 Array 객체란?

+ 여러 개의 항목을 하나의 변수에 저장해야 할때 사용
+ for문 사용시 인덱스 값을 0부터 'length값 -1' 까지 지정



### 07-2 Array 객체 함수

+ concat() : 기존 배열1 + 기존 배열2 = 새로운 배열

+ join() : 배열 요소를 연결할때 각 요소 사이에 넣을 구분 기호 지정, 기본(,)

+ push() unshift() : 배열의 맨끝 / 배열의 맨앞에 새로운 요소를 추가

  ```javascript
  var nums = ["1", "2", "3"]
  nums.push("4", "5")
  nums.unshift("0")
  ["0", "1", "2", "3", "4","5"]
  ```

+ pop() shift() : 배열의 맨끝 / 배열의 맨앞에서 요소를 삭제

  ```javascript
  var study = ["html", "css", "javascript"]
  study.pop() // "javascript" 추출
  study.shift() // "html" 추출
  ```

+ splice() : 인수에 따라 일정 구간의 요소를 삭제하고 새로운 요소를 추가, 삭제한 구간의 요소들로 이루어진 새로운 배열이 결과값으로 표시됨

  - 인수가 1개인 경우 =  인수:인덱스값

  - ```javascript
    var numbers = [0, 1, 2, 3, 4, 5]
    numbers.splice(2) // 인덱스 2 이후 끝까지 삭제
    [2, 3, 4, 5] // 삭제된 요소로 이루어진 배열
    [0, 1] // 수정된 배열
    ```

  - 인수가 2개인 경우 = 인수1:인덱스값, 인수2:삭제할 개수

  - ```javascript
    var study = ["html", "css", "javascript", "jquery"]
    study.splice(2,1) // 인덱스 2에서 한개 삭제
    ["javascript"] // 삭제된 요소로 이루어진 배열
    ["html", "css", "jquery"] // 수정된 배열
    ```

  - 인수가 3개 이상 = 인수1:인덱스값, 인수2:삭제할 개수, 인수3:새로추가할요소

    ```javascript
    study.splice(2, 1, "js") // 인덱스 2에서 한개 삭제한 후
    ["jquery"] // 삭제된 요소로 이루어진 배열
    ["html", "css", "js"] // 삭제한 자리에 새로운 요소를 추가
    
    study.splice(2, 0, "jquery") // 원하는 위치에 요소를 추가
    
    study.splice(1, 0, "b", "c", "d") // 여러 개의 요소를 추가
    ```

+ slice() : 시작인덱스와 끝인덱스를 지정해  그 직전까지의 요소를 꺼냄

  ```javascript
  var colors = ["red", "green", "blue", "white", "black"]
  colors.slice(2)
  ["blue", "white", "black"] // 인덱스 2부터 끝까지 추출
  // 원래 배열은 변경되지 않음
  
  var colors2 = color.slice(1, 4)
  ["green", "blue", "white"] // 끝인덱스 직전까지만 추출
  // 원래 배열은 변경되지 않음
  ```

  



## 08. 문서 객체 모델 (DOM)

### 08-1 DOM

+ 웹 문서의 모든 요소를 자바스크립트를 이용해 조작할 수 있도록 객체를 사용해 문서를 해석하는 방법



### 08-2 DOM 요소에 접근하기

+ getElementsByClassName() : class 선택자는 웹문서안에서 여러번 사용할수 있음

```javascript
document.getElementsByClassName("accent")[0] // 인덱스를 이용해 원하는 요소 가져오기
```

+ querySelector() / querySelectorAll() : 

```javascript
document.querySelectorAll(".accent")[1].style.backgroundColor = "yellow"
```

+ addEventListener() :

```javascript
document.addEventListener("click", function() {
	alert("안녕하세요옹"); // 문서 아무데나 누르면 알림창 뜨게하기
});
```





### 08-3 웹요소의 태그 속성 가져와서 수정하기

+ getAttribute() : 속성에 접근
+ setAttribute() : 속성을 변경

```javascript
document.queryselector("#prod-img > img").setAttribute("src", "이미지 경로") // 선택한 ID값의 src 속성을 변경
```





### 08-5 웹요소의 스타일 수정하기

+ display:none : 요소가 차지하던 공간도 사라짐
+ visibility:hidden : 요소가 있던 공간이 빈 상태로 남음





### 08-6 DOM에 요소 추가하기

```javascript
var newP = document.createElement("p") // 요소 노드 만들기

var newText = document.createTextNode("주문이 완료되었땅") // 텍스트 노드 만들기

newP.appendChild(newText) // 텍스트 노드를 요소 노드의 자식으로 설정

document.body.appendChild(newP) // 요소 노드를 body 태그의 자식으로 설정

var attr = document.createAttribute("class") // class 속성 노드 
attr.value = "accent" // class 속성 노드의 값

newP.setAttributeNode(attr) // 요소 노드와 연결
```



### 08-7 노드 순서 바꾸거나 삭제하기

```javascript
document.querySelectorAll("p")[0].hasChildNodes() // 자식 노드가 있는지 확인 t/f

document.querySelector("#nameList").childNodes // 자식 노드 리스트 줄바꿈도 텍스트 노드로 인식함

document.querySelector("#nameList").children // 자식 노드 중 요소에만 접근

var nameList = document.querySelector("#nameList")
nameList.insertBefore(nameList.children[2], nameList.children[0])
// 마지막 노드를 첫번째 노드 앞으로 이동

var firstDel = document.querySelectorAll(".del")[0] // 첫번째 X
var firstP = document.querySelectorAll("p")[0] // 위의 부모
firstP.removeChild(firstDel) // 부모의 자식을 삭제...
```





## 09. 폼과 자바스크립트

### 09-1 폼 요소에 접근하기

```javascript
document.querySelector("#billingName").value
// 텍스트 필드의 id를 사용해 가져오기

document.ship.shippongName.value
// 텍스트 필드의 name을 사용해 가져오기, form과 form요소 모두 name 속성이 있어야함!

document.forms[0].elements[0].value
// 첫번째 폼의 첫번째 요소의 값, 선택자가 없을때
```



### 09-2 폼 요소에서 입력값 검증하기

+ change 이벤트 : 필드에 입력을 마치고 빠져나올때 발생



### 09-3 다양한 폼 요소 다루기

```javascript
document.querySelector("#major").options 
// 옵션 항목에 접근하기

document.querySelector("#major").options[0].innerText
// 첫번재 옵션이 화면에 표시하는 내용에 접근하기

document.querySelector("#major").options[0].value
// 첫번째 옵션이 서버로 넘겨주는 값 접근하기
```

























