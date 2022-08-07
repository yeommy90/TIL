# 16장 프로퍼티 어트리뷰트

### 16.1 내부 슬롯과 내부 메서드

+ 자바스크립트 엔진의 구현 알고리즘을 설명하기 위해 ECMAScript 사양에서 사용하는 의사 프로퍼티와 의사 메서드다.

+ ECMAScript 사양에 정의된 대로 구현되어 자바스크립트 엔진에서 실제로 동작하지만 개발자가 직접 접근할 수 있도록 외부로 공개된 객체의 프로퍼티는 아니다.
+ 예를 들어 모든 객체는 [[Prototype]] 이라는 내부 슬롯을 갖는다. 원칙적으로 직접 접근할 수 없지만 proto 를 통해 간접적으로 접근할 수 있다.

```javascript
const o = {};

o.[[Prototype]] // SyntaxError
o.__proto__ // Object.prototype
```

<br>

### 16.2 프로퍼티 어트리뷰트와 프로퍼티 디스크립터 객체

+ 자바스크립트 엔진은 프로퍼티를 생성할 때 프로퍼티의 상태를 나타내는 프로퍼티 어트리뷰트를 기본값으로 자동 정의한다.
+ 값 : [[Value]], 값의 갱신 여부 : [[Writable]], 열거 가능 여부 : [[Enumerable]], 재정의 가능 여부 : [[Configurable]]
+ 직접 접근할 수 없지만 Object.getOwnPropertyDescriptor(객채, 프로퍼티 키) 메서드를 사용해 간접적으로 확인할 수 있다.

```javascript
const person = {
	name: 'Kim',
    age: 30
};

console.log(Object.getOwnPropertyDescriptor(person, 'name'));
// {value: "Kim", writable: true, enumerable: true, configurable: true}

console.log(Object.getOwnPropertyDescriptors(person));
/*
{
	name: {value: "Kim", writable: true, enumerable: true, configurable: true}
	age: {value: 30, writable: true, enumerable: true, configurable: true}
}
*/
```

<br>

### 16.3 데이터 프로퍼티와 접근자 프로퍼티

#### 16.3.1 데이터 프로퍼티

+ 키와 값으로 구성된 일반적인 프로퍼티
+ 자바스크립트 엔진이 프로퍼티를 생성할 때 기본값으로 자동 정의된다.
+ [[Value]] : 프로퍼티 키를 통해 프로퍼티 값에 접근하면 반환되는 값
+ [[Writable]] : 프로퍼티 값의 변경 가능 여부, false 인 경우 값을 변경할 수 없는 읽기 전용 프로퍼티가 된다.
+ [[Enumerable]] : false 인 경우 해당 프로퍼티는 for...in 문이나 Object.keys 메서드 등으로 열거할 수 없다.
+ [[Configurable]] : false 인 경우 해당 프로퍼티의 삭제, 프로퍼티 어트리뷰트 값의 변경이 금지된다.

#### 16.3.2 접근자 프로퍼티

+ 자체적으로는 값을 갖지 않고 다른 데이터 프로퍼티의 값을 읽거나 저장할 때 사용하는 접근자 함수(accessor function) 로 구성된 프로퍼티다.
+ [[Get]] : 접근자 프로퍼티를 통해 데이터 프로퍼티의 값을 읽을때 호출되는 접근자 함수, getter 함수가 호출되고 그 결과가 프로퍼티 값으로 반환된다.
+ [[Set]] : 접근자 프로퍼티를 통해 데이터 프로퍼티의 값을 저장할때 호출되는 접근자 함수, setter 함수가 호출되고 그 결과가 프로퍼티 값으로 저장된다.
+ [[Enumerable]], [[Configurable]]
+ fullName의 동작 과정
  - 프로퍼티 키가 유효한지 확인한다. 프로퍼티 키는 문자열 또는 심벌이어야 한다.
  - 프로토타입 체인에서 프로퍼티를 검색한다. person 객체에 fullName 프로퍼티가 존재한다.
  - 검색된 fullName 프로퍼티의 종류를 확인한다. fullName 은 접근자 프로퍼티다.
  - 접근자 프로퍼티 fullName 의 프로퍼티 어트리뷰트 값 [[Get]] 의 값, 즉 getter 함수를 호출해 그 결과를 반환한다.

```javascript
const person = {
	firstName: 'Seoyoung',
	lastName: 'Kim'
	
	get fullName() {
		return `${this.firstName} ${this.lastName}`;
	},
	
	set fullName(name) {
		[this.firstName, this.lastName] = name.split(' '); // 배열 디스트럭처링 할당
	}
};

// 데이터 프로퍼티를 통한 프로퍼티 값의 참조
console.log(person.firstName + ' ' + person.lastName); // Seoyoung Kim

// 접근자 프로퍼티를 통해 fullName 에 값을 저장하면 setter 함수가 호출된다.
person.fullName = 'Jaejun Kim';
console.log(person); // {firstName: "Jaejun", lastName: "Kim"}

// 접근자 프로퍼티를 통해 fullName 에 접근하면 getter 함수가 호출된다.
console.log(person.fullName); // Jaejun Kim

// 데이터 프로퍼티는 [[Value]], [[Writable]], [[Enumerable]], [[Configurable]] 
console.log(Object.getOwnPropertyDescriptor(person, 'firstName'));
// {value: "Jaejun", writable: true, enumerable: true, configurable: true}

// 접근자 프로퍼티는 [[Get]], [[Set]], [[Enumerable]], [[Configurable]] 
console.log(Object.getOwnPropertyDescriptor(person, 'fullName'));
// {get: f, set: f, enumerable: true, configurable: true}
```

<br>

### 16.4 프로퍼티 정의

+ 프로퍼티 정의란 새로운 프로퍼티를 추가하면서 프로퍼티 어트리뷰트를 명시적으로 정의하거나, 기존 프로퍼티의 프로퍼티 어트리뷰트를 재정의하는 것을 말한다.
+ Object.defineProperty(객체, 프로퍼티 키, 프로퍼티 디스크립트 객체) 메서드를 사용한다.
+ Object.defineProperties 메서드를 사용하면 여러 개의 프로퍼티를 한번에 정의할 수 있다.
+ 디스크립터 객체의 프로퍼티를 누락시키면 undefined, false 가 기본값이 된다.

```javascript
const person = {};

// 데이터 프로퍼티 정의
Object.defineProperty(person, 'firstName', {
	value: 'Seoyoung',
	writable: true,
	enumerable: true,
	configurable: true
});

Object.defineProperty(person, 'lastName', {
	value: 'Kim'
	// 디스크립터 객체의 프로퍼티를 누락시키면 undefined, false 가 기본값이 된다.
});

// [[Writable]] 의 값이 false 인 경우 값을 변경하면 에러는 발생하지 않고 무시된다.
person.lastName = 'Lee'; 

// [[Enumerable]] 의 값이 false 인 경우 for...in 문이나 Object.keys 등으로 열거할 수 없다.
console.log(Object.keys(person)); // ["firstName"]

// [[Configurable]] 의 값이 false 인 경우 해당 프로퍼티를 삭제할 수 없으며 에러는 발생하지 않고 무시된다.
delete person.lastName;

// [[Configurable]] 의 값이 false 인 경우 해당 프로퍼티를 재정의할 수 없다.
Object.defineProperty(person, 'lastName', { enumerable: true }); // TypeError



// 접근자 프로퍼티 정의
Object.defineProperty(person, 'fullName', {
    get() {
        return `${this.firstName} ${this.lastName}`;
    },
    
    set() {
        [this.firstName, this.lastName] = name.split(' ');
    },
    enumerable: true,
    configurable: true
});

console.log(Object.getOwnPropertyDescriptor(person, 'fullName'));
// fullName {get: f, set: f, enumerable: true, configurable: true}

person.fullName; = 'Jaejun Kim'
console.log(person); // {firstName: "Jaejun", lastName: "Kim"}
```

<br>

### 16.5 객체 변경 방지

+ 자바스크립트는 객체의 변경을 방지하는 다양한 메서드를 제공한다. 
+ 객체 확장 금지 : 추가 X, 삭제 O, 재정의 O, 쓰기 O, 읽기 O
+ 객체 밀봉 : 추가 X, 삭제 X, 재정의 X, 쓰기 O, 읽기 O
+ 객체 동결 : 추가 X, 삭제 X, 재정의 X, 쓰기 X, 읽기 O

#### 16.5.1 객체 확장 금지

+ Object.preventExtensions 메서드는 객체의 확장을 금지한다. 프로퍼티의 동적 추가와 Object.defineProperty 메서드로 추가 금지를 의미한다.
+ Object.isExtensible 메서드로 확인할 수 있다.

```javascript
const person = { name: 'Kim' };

Object.preventExtensions(person); // 확장 금지 객체로 선언
console.log(Object.isExtensible(person)); // false 확장이 불가능함

person.age = 20; // 동적 추가 금지, 무시, strict mode 에서는 에러
Object.defineProperty(person, 'age', { value: 20 }); // TypeError 메서드로 추가 금지

delete person.name; // 추가는 금지되지만 삭제는 가능
```

#### 16.5.2 객체 밀봉

+ Object.seal 메서드는 객체를 밀봉한다. 프로퍼티 추가 및 삭제와 재정의 금지를 의미하며 읽기와 쓰기(갱신)만 가능하다.
+ Object.isSealed 메서드로 확인할 수 있다.
+ 밀봉된 객체는 configurable 이 false 다.

```javascript
const person = { name: 'Kim' };

Object.seal(person);
console.log(Object.isSealed(person)); // true 밀봉이 되어 있음

Object.defineProperty(person, 'name', { configurable: true });
// TypeError 재정의가 금지된다.

person.name = 'Lee'; // 프로퍼티 값 갱신은 가능하다.
```

#### 16.5.3 객체 동결

+ Object.freeze 메서드는 객체를 동결한다. 프로퍼티 추가 및 삭제와 재정의, 갱신 금지를 의미하며 읽기만 가능하다.
+ Object.isFrozen 메서드로 확인할 수 있다.
+ 동결된 객체는 writable 과 configurable 이 false 다.

```javascript
const person = { name: 'Kim' };

Object.freeze(person);
console.log(Object.isFrozen(person)); // true 동결이 되어 있음
```

#### 16.5.4 불변 객체

+ 얕은 변경 방지로 직속 프로퍼티만 변경이 방지되고 중첩 객체까지는 영향을 주지 못한다.
+ 객체의 중첩 객체까지 동결해 변경이 불가능한 읽기 전용의 불변 객체를 구현하려면 객체를 값으로 갖는 모든 프로퍼티에 대해 재귀적으로 Object.freeze 메서드를 호출해야 한다.

```javascript
const person = {
	name: 'Kim',
	address: { city: 'Suwon'}
};

Object.freeze(person);
console.log(Object.isFrozen(person.address)); // false
// 직속 프로퍼티만 동결되고 중첩 객체는 동결되지 않는다.

person.address.city = 'Busan';
console.log(person); // {name: "Kim", address: {city: "Busan"}}
// 동결되지 않은 중첩 객체는 변경이 가능해진다.


function deepFreeze(target) {
    if (target && typeof target === 'object' && !Object.isFrozen(target)) {
        Object.freeze(target);
        Object.keys(target).forEach(key => deepFreeze(target[key]));
        // 열거 가능한 프로퍼티 키를 배열로 반환하고 forEach 메서드는 배열의 각 요소에 대해 콜백 함수를 실행한다.
    }
    return target;
}

const person = {
	name: 'Kim',
	address: { city: 'Suwon'}
};

deepFreeze(person);
console.log(Object.isFrozen(person.address)); // true
// 중첩 객체까지 동결한다.

person.address.city = 'Busan';
console.log(person); // {name: "Kim", address: {city: "Suwon"}}
// 중첩 객체는 동결되어 변경이 불가능해진다.
```

<br>

<br>

<br>

# 17장 생성자 함수에 의한 객체 생성

### 17.1 Object 생성자 함수

+ new 연산자와 Object 생성자 함수를 호출하면 빈 객체를 생성해 반환한다. 빈 객체에 프로퍼티와 메서드를 추가해 객체를 완성할 수 있다.
+ 인스턴스 : 생성자 함수에 의해 생성된 객체
+ Object 생성자 함수 이외에도 String, Number, Boolean, Function, Array, Date, RegExp, Promise 등의 빌트인 생성자 함수를 제공한다.
+ 특별한 이유가 없다면 객체 리터럴을 사용하는 것이 더 간편하다.

```javascript
const person = new Object();

person.name = 'Kim';
person.sayHello = function() {
	console.log('Hi! My Name is ' + this.name);
};

console.log(person); // {name: "Kim", sayHello: f}

const boolObj = new Boolean(true);
console.log(boolObj); // Boolean {true}

const func = new Function('x', 'return x * x');
console.log(func); // f anonymous(x) { return x * x }

const date = new Date();
console.log(date); // 현재 날짜 시간
```

<br>

### 17.2 생성자 함수

#### 17.2.1 객체 리터럴에 의한 객체 생성 방식의 문제점

+ 객체 리터럴에 의한 객체 생성 방식은 단 하나의 객체만 생성한다. 동일한 프로퍼티를 갖는 객체를 여러개 생성해야 하는 경우 매번 같은 프로퍼티를 기술해야 하기 때문에 비효율적이다.
+ 프로퍼티는 객체마다 프로퍼티 값은 다를 수 있지만 메서드는 내용이 동일한 경우가 일반적이다.

#### 17.2.2 생성자 함수에 의한 객체 생성 방식의 장점

+ 객체를 생성하기 위한 탬플릿처럼 생성자 함수를 사용해 프로퍼티 구조가 동일한 객체 여러개를 간편하게 생성할 수 있다.
+ 인스턴스를 생성하기 위한 클래스처럼 생성자 함수를 사용할 수 있다.
+ this : 객체 자신의 프로퍼티나 메서드를 참조하기 위한 자기 참조 변수
+ 일반 함수와 동일한 방법으로 생성자 함수를 정의하고 new 연산자와 함께 호출하면 해당 함수는 생성자 함수로 동작한다. 그렇지 않으면 일반 함수로 동작한다.

```javascript
function Circle(radius) {
	this.radius = radius;
	this.getDiameter = function () {
		return 2 * this.radius;
	};
} // 함수 선언문으로 자체 종결성을 갖는다.

// 인스턴스의 생성
const circle1 = new Circle(5); // 반지름이 5인 circle 객체를 생성
const circle2 = new Circle(10); // 반지름이 10인 circle 객체를 생성

const circle3 = circle(15); // 일반 함수로 동작한다.
console.log(circle3); // undefined 일반 함수로 동작한 circle 은 반환문이 없으므로 암묵적으로 undefined 를 반환한다.
console.log(radius); // 15 circle 내의 this 는 전역 객체를 가리킨다.
```

#### 17.2.3 생성자 함수의 인스턴스 생성 과정

+ 생성자 함수 내부의 코드를 살펴보면 this 에 프로퍼티를 추가하고 필요에 따라 전달된 인수를 프로퍼티의 초기값으로 할당해 인스턴스를 초기화 한다. 하지만 인스턴스를 생성하고 반환하는 코드는 보이지 않는다.
+ 자바스크립트 엔진은 암묵적인 처리를 통해 인스턴스를 생성하고 반환한다.

1. ##### 인스턴스 생성과 this 바인딩

   + 암묵적으로 빈 객체(인스턴스) 가 생성되고 생성된 인스턴스는 this 에 바인딩된다.
   + this 바인딩은 this 와 this 가 가리킬 객체를 연결하는 것이다.
   + 런타임 이전에 실행된다.

2. ##### 인스턴스 초기화

   - 생성자 함수의 코드가 한줄씩 실행되어 this 에 바인딩되어 있는 인스턴스를 초기화한다.
   - 인스턴스에 프로퍼티나 메서드를 추가하고 인수로 전달받은 초기값을 프로퍼티에 할당해 초기화하거나 고정값을 할당한다.

3. ##### 인스턴스 반환

   - 생성자 함수 내부의 모든 처리가 끝나면 완성된 인스턴스와 바인딩된 this 가 암묵적으로 반환된다.
   - this 가 아닌 다른 객체를 명시적으로 반환하면 return 문에 명시한 객체가 반환되므로 반드시 return 문을 생략해야 한다.

```javascript
function Circle(radius) {
	// 1. 암묵적으로 인스턴스가 생성되고 this 에 바인딩된다.
	
	// 2. this 에 바인딩되어 있는 인스턴스를 초기화한다.
	this.radius = radius;
	this.getDiameter = function () {
		return 2 * this.radius;
	};
	// 3. 암묵적으로 this 를 반환한다.
}
```

#### 17.2.4 내부 메서드 [[Call]] 과 [[Construct]]

+ 함수 선언문 또는 함수 표현식으로 정의한 함수는 일반적인 함수나 생성자 함수로 호출할 수 있다. 
+ 함수는 객체이므로 일반 객체와 동일하게 동작하고 내부 슬롯과 내부 메서드를 모두 가지고 있다.
+ 함수는 일반 객체와 달리 호출할 수 있다.
+ [[Environment]], [[FormalParameters]], [[Call]], [[Construct]] 같은 내부 메서드를 추가로 가지고 있다.
+ 일반 함수로 호출되면 [[Call]], new 연산자와 함께 생성자 함수로 호출되면 [[construct]] 가 호출된다.
+ 함수 객체는 호출할 수 있는 callable 이면서 생성자 함수로서 호출할 수 있는 constructor 와 호출할 수 있는 callable 이면서 생성자 함수로서 호출할 수 없는 non-constructor 로 나누어 진다.

#### 17.2.5 constructor 와 non-constructor 의 구분

+ constructor : 함수 선언문, 함수 표현식, 클래스
+ non-constructor : 메서드(ES6 메서드 축약 표현), 화살표 함수
+ 생성자 함수로서 호출될 것을 기대하고 정의하지 않는 일반 함수 (callable 이면서 constructor) 에 new 연산자를 붙여 호출하면 생성자 함수처럼 동작한다.

```javascript
function foo() {} // 함수 선언문
const bar = function () {}; // 함수 표현식
const baz = {
	x: function () {}
}; // 프로퍼티 x의 값으로 할당된 것은 일반 함수로 정의된 함수다. 

new foo(); // foo {}
new bar(); // bar {}
new baz.x(); // x {}
// 모두 constructor 로 new 연산자와 함께 호출할 수 있다.


const arrow = () => {}; // 화살표 함수
const obj = {
	x() {}
}; // ES6 의 메서드 축약 표현

new arrow(); // TypeError
new obj.x(); // TypeError
// non-constructor 로 new 연산자와 함께 호출할 수 없다.
```

#### 17.2.6 new 연산자

+ new 연산자와 함께 호출하는 함수는 constructor 이어야 한다.

```javascript
function add(x, y) {
	return x + y;
}
// 일반 함수

let inst = new add(); // 생성자 함수로 정의하지 않은 일반 함수를 new 연산자와 함께 호출
console.log(inst); // {} 함수가 객체를 반환하지 않으므로 반환문을 무시하고 빈 객체가 생성되어 반환된다.

function createUser(name, role) {
	return { name, role };
}
// 객체를 반환하는 일반 함수

inst = new createUser('Kim', 'admin'); // 일반 함수를 new 연산자와 함께 호출
console.log(inst); // {name: "Kim", role: "admin"} 함수가 생성한 객체를 반환한다.
```

+ new 연산자 없이 생성자 함수를 호출하면 일반 함수로 호출된다.

```javascript
function Circle(radius) {
	this.radius = radius;
	this.getDiameter = function () {
		return 2 * this.radius;
	};
}

const circle = Circle(5); // new 연산자 없이 호출하면 일반 함수로 호출된다.
console.log(circle); // undefined
console.log(radius); // 5 
console.log(getDiameter()); // 10
circle.getDiameter(); // TypeError

// 함수 내부의 this 는 전역 객체 window 를 가리킨다.
// radius 프로퍼티와 getDiameter 메서드는 전역 객체의 프로퍼티와 메서드가 된다.
```

+ 생성자 함수는 일반적으로 첫 문자를 대문자로 기술하는 파스칼 케이스로 명명해 일반 함수와 구분할 수 있도록 노력한다.

#### 17.2.7 new.target

+ 생성자 함수가 new 연산자 없이 호출되는 것을 방지하기 위해 파스칼 케이스 컨벤션을 사용한다 해도 실수 방지를 위해 ES6 에서는 new.target 을 사용한다.

+ this 와 유사하게 constructor 인 모든 함수 내부에서 암묵적인 지역 변수와 같이 사용된다.
+ 함수 내부에서 new.target 을 사용하면 new 연산자와 함께 호출되었는지 확인해 그렇지 않은 경우 new 연산자와 함께 재귀 호출을 통해 생성자 함수로 호출할 수 있다.
+ new 연산자와 함께 호출되면 new.target 은 함수 자신을 가리키고, 일반 함수로 호출되면 undefined 이다.

```javascript
function Circle(radius) {
    // new 연산자와 함께 호출되지 않았다면 undefined 으로 false 이다.
	if (!new.target) {
        // new 연산자와 함께 생성자 함수를 재귀 호출한다.
		return new Circle(radius);
	}
    
	this.radius = radius;
	this.getDiameter = function () {
		return 2 * this.radius;
	};
}

const circle = Circle(5); // new 연산자 없이 호출해도 new.target 을 통해 생성자 함수로서 호출된다.
console.log(circle.getDiameter()); // 10

// new.target 을 통해 생성자 함수로 호출되었기에 radius 와 getDiameter 는 함수 Circle 의 프로퍼티와 메서드가 된다.
```

+ new.target 을 사용할 수 없는 상황 (IE) 에는 스코프 세이프 생성자 패턴을 사용할 수 있다.

```javascript
function Circle(radius) {
    // this 와 Circle 이 바인딩 되어있고 프로토타입에 의해 연결되어 있는지 확인한다.
	if (!(this instanceof Circle)) {
		return new Circle(radius);
	}
	this.radius = radius;
	this.getDiameter = function () {
		return 2 * this.radius;
	};
}

const circle = Circle(5); // new 연산자 없이 호출해도 new.target 을 통해 생성자 함수로서 호출된다.
console.log(circle.getDiameter()); // 10
```

<br>

<br>

<br>

# 18장 함수와 일급 객체

### 18.1 일급 객체

+ 무명의 리터럴로 생성할 수 있다. 즉 런타임에 생성이 가능하다.
+ 변수나 자료구조(객체, 배열 등)에 저장할 수 있다.
+ 함수의 매개변수에 전달할 수 있다.
+ 함수의 반환값으로 사용할 수 있다.
+ 일급 객체로서 함수가 가지는 가장 큰 특징은 일반 객체와 같이 함수의 매개변수에 전달할 수 있으며 함수의 반환값으로 사용할 수 있다는 것이다. 이는 함수형 프로그래밍을 가능케 하는 자바스크립트의 장점 중 하나다.

<br>

### 18.2 함수 객체의 프로퍼티

+ Object.getOwnPropertyDescriptors 메서드로 확인할 수 있다.

#### 18.2.1 arguments 프로퍼티

+ arguments 객체는 함수 호출 시 전달된 인수들의 정보를 담고 있는 순회 가능한(이터러블) 유사 배열 객체이며, 함수 내부에서 지역 변수처럼 사용된다.
+ 선언된 매개변수의 개수보다 인수를 많이 전달한 경우 버려지는 것이 아닌 모든 인수는 암묵적으로 arguments 객체의 프로퍼티로 보관된다.

```javascript
function multiply(x, y) {
	console.log(arguments);
	return x * y;
}

console.log(multiply(1, 2)); // 2
arguments [1, 2, callee: f, Symbol(Symbol.iterator): f]
0: 1
1: 2
callee: f multiply(x, y)
length: 2

console.log(multiply(1, 2, 3)); // 2
arguments [1, 2, 3, callee: f, Symbol(Symbol.iterator): f]
0: 1
1: 2
2: 3
callee: f multiply(x, y)
length: 3
```

+ arguments 객체는 매개변수 개수를 확정할 수 없는 __가변 인자 함수__ 를 구현할 때 유용하다.
+ arguments 객체는 length 프로퍼티가 있는 유사 배열 객체이므로 for 문으로 순회할 수 있다.

```javascript
function sum() {
	let res = 0;
	
	// arguments 객체는 length 프로퍼티가 있는 유사 배열 객체이므로 for 문으로 순회할 수 있다.
	for (let i = 0; i < arguments.length; i++) {
		res += arguments[i];
	}
	return res;
}

console.log(sum()); // 0
console.log(sum(1, 2)); // 3
console.log(sum(1, 2, 3)); // 6
```

#### 18.2.2 caller 프로퍼티

+ ECMAScript 사양에 포함되지 않은 비표준 프로퍼티
+ 함수 자신을 호출한 함수를 가리킨다.

#### 18.2.3 length 프로퍼티

+ 함수를 정의할 때 선언한 매개변수의 개수
+ arguments 객체의 length 프로퍼티는 인자의 개수를 가리키고, 함수 객체의 length 프로퍼티는 매개변수의 개수를 가리킨다.

#### 18.2.4 name 프로퍼티

+ ES5와 ES6에서 동작을 달리한다.
+ ES5 에서 익명 함수 표현식의 name 프로퍼티는 빈 문자열을 값으로 갖는다.
+ ES6 에서 익명 함수 표현식의 name 프로퍼티는 함수 객체를 가리키는 식별자를 값으로 갖는다.

```javascript
var anonymousFunc = function() {};
// ES5 : 빈 문자열
// ES6 : anonymousFunc
```

#### 18.2.5 __ proto __ 접근자 프로퍼티

+ 모든 객체는 [[Prototype]] 이라는 내부 슬롯을 갖는다. 객체지향 프로그래밍의 상속을 구현하는 프로토타입 객체를 가리킨다.
+ 내부 슬롯에는 직접 접근할 수 없고 간접적인 접근 방법을 제공하는 경우에 한해 간접적으로 접근할 수 있다.

#### 18.2.6 prototype 프로퍼티

+ 생성자 함수로 호출할 수 있는 함수 객체, 즉 constructor 만이 소유하는 프로퍼티
+ 함수가 객체를 생성하는 생성자 함수로 호출될 때 생성자 함수가 생성할 인스턴스의 프로토타입 객체를 가리킨다.

```javascript
(function () {}).hasOwnProperty('prototype'); // true
({}).hasOwnProperty('prototype'); // false
```

<br>

<br>

<br>

# 19장 프로토타입

### 19.1 객체지향 프로그래밍

+ 객체지향 프로그래밍 : 독립적인 객체의 집합으로 프로그램을 표현하려는 프로그래밍 패러다임
+ 객체 : 속성을 통해 여러 개의 값을 하나의 단위로 구성한 복합적인 자료구조, 상태 데이터 (프로퍼티)와 동작 (메서드) 을 하나의 논리적인 단위로 묶은 복합적인 자료구조

<br>

### 19.2 상속과 프로토타입

+ 상속 : 어떤 객체의 프로퍼티나 메서드를 다른 객체가 상속받아 그대로 사용할 수 있는 것
+ 자바스크립트는 프로토타입을 기반으로 상속을 구현해 불필요한 중복을 제거함 === 코드의 재사용

```javascript
function Circle(radius) {
	this.radius = radius;
	this.getArea = function () {
		return Math.PI * this.radius ** 2;
	};
}

const circle1 = new Circle(1);
const circle2 = new Circle(2);
console.log(circle1.getArea === circle2.getArea); // false

// Circle 생성자 함수는 인스턴스를 생성할 때마다 동일한 동작을 하는 getArea 메서드를 중복 생성하고 모든 인스턴스가 중복 소유한다. 메모리를 낭비한다!!!



function Circle(radius) {
	this.radius = radius;
}

Circle.prototype.getArea = function () {
	return Math.PI * this.radius ** 2;
};

const circle1 = new Circle(1);
const circle2 = new Circle(2);
console.log(circle1.getArea === circle2.getArea); // true

// Circle 생성자 함수가 생성한 모든 인스턴스는 부모 객체의 역할을 하는 프로토타입 Circle.prototype 으로부터 getArea 메서드를 상속받고 모든 인스턴스는 하나의 getArea 메서드를 공유한다.
```

<br>

### 19.3 프로토타입 객체

+ 객체 리터럴에 의해 생성된 객체의 프로토타입 : Object.prototype
+ 생성자 함수에 의해 생성된 객체의 프로토타입 : 생성자 함수의 prototype 프로퍼티에 바인딩된 객체

#### 19.3.1 proto 접근자 프로퍼티

```javascript
__proto__ 접근자 프로퍼티는 상속을 통해 사용된다.
객체가 직접 소유하는 프로퍼티가 아니라 Object.prototype 의 프로퍼티다.

__proto__ 접근자 프로퍼티를 통해 프로토타입에 접근하는 이유
상호 참조에 의해 프로토타입 체인이 생성되는 것을 방지하기 위해서!

__proto__ 접근자 프로퍼티를 코드 내에서 직접 사용하는 것은 권장하지 않는다.
Object.getPrototypeOf : 프로토타입의 참조를 취득
Object.setPrototypeOf : 프로토타입을 교체
```

#### 19.3.2 함수 객체의 prototype 프로퍼티

+ prototype 프로퍼티는 함수 객체만이 소유하고, 생성자 함수가 생성할 인스턴스의 프로토타입을 가리킨다.

+ Object.prototype 으로부터 상속받은 접근자 프로퍼티와 함수 객체만이 가지고 있는 prototype 프로퍼티는 동일한 프로토타입을 가리키지만 이들을 사용하는 주체가 다르다.

```javascript
function Person(name) {
	 this.name = name;
}

const me = new Person('kim');

console.log(Person.prototype === me.__proto__); // true

// 생성자 함수로 생성된 Person 의 프로토타입 프로퍼티와 me 객체의 접근자 프로퍼티는 동일한 프로토타입을 가리킨다.
```

#### 19.3.3 프로토타입의 constructor 프로퍼티와 생성자 함수

+ constructor 프로퍼티는 prototype 프로퍼티로 자신을 참조하고 있는 생성자 함수를 가리킨다.

```javascript
function Person(name) {
	 this.name = name;
}

const me = new Person('kim');

console.log(me.constructor === Person); // true

// me 객체는 프로토타입의 constructor 프로퍼티를 통해 생성자 함수 Person 과 연결된다. me 객체에는 constructor 프로퍼티가 없지만 me 객체의 프로토타입인 Person.prototype 에는 construtor 프로퍼티가 있다. 따라서 me 객체는 프로토타입인 Person.prototype 의 constructor 프로퍼티를 상속받아 사용할 수 있다.
```

<br>

### 19.4 리터럴 표기법에 의해 생성된 객체의 생성자 함수와 프로토타입

+ 리터럴 표기법에 의해 생성된 객체의 생성자 함수는 Object 생성자 함수이다.
+ 객체 리터럴로 생성한 객체와 Object 생성자 함수로 생성한 객체는 생성 과정에 미묘한 차이는 있지만 객체로서 동일한 특성을 갖는다.
+ 함수 리터럴로 생성한 함수와 Function 생성자 함수로 생성한 함수는 생성 과정과 스코프, 클로저 등의 차이가 있지만 결국 함수로서 동일한 특성을 갖는다.

```javascript
const obj = {};

console.log(obj.constructor === Object); // true

function foo() {}

console.log(foo.constructor === Function); // true

// 리터럴 표기법에 의해 생성된 객체도 상속을 위해 프로토타입이 필요하다. 프로토타입은 생성자 함수와 더불어 생성되며 쌍으로 존재한다.
```

<br>

### 19.5 프로토타입의 생성 시점

#### 19.5.1 사용자 정의 생성자 함수와 프로토타입 생성 시점

+ 생성자 함수로서 호출할 수 있는 함수, 즉 construtor 는 함수 정의가 평가되어 함수 객체를 생성하는 시점에 프로토타입도 생성된다.
+ 함수 선언문은 런타임 이전에 자바스크립트 엔진에 의해 먼저 실행되며 이때 프로토타입도 생성된다.
+ 사용자 정의 생성자 함수는 자신이 평가되어 함수 객체로 생성되는 시점에 프로토타입도 생성되며, 생성된 프로토타입의 프로토타입은 언제나 Object.prototype 이다.

#### 19.5.2 빌트인 생성자 함수와 프로토타입 생성 시점

+ 전역 객체가 생성되는 시점에 모든 빌트인 생성자 함수는 생성된다. 

<br>

### 19.6 객체 생성 방식과 프로토타입의 결정

+ 프로토타입은 추상 연산 OrdinaryObjectCreate 에 전달되는 인수에 의해 결정된다. 이 인수는 객체가 생성되는 시점에 객체 생성 방식에 따라 달라진다.

#### 19.6.1 객체 리터럴

+ 객체 리터럴에 의해 생성된 객체는 Object.prototype 을 프로토타입을 갖게 되며 상속받는다. 객체 자체는 constructor 와 hasOwnProperty 메서드 등을 소유하지 않지만, 상속받았으므로 자유롭게 사용할 수 있다.

#### 19.6.2 Object 생성자 함수

+ Object 생성자 함수에 의해 생성된 객체는 Object.prototype 을 프로토타입으로 갖게 되며 상속받는다.

+ 객체 리터럴 방식은 객체 리터럴 내부에 프로퍼티를 추가하지만, Object 생성자 함수 방식은 일단 빈 객체를 생성한 후 프로퍼티를 추가해야 한다.

#### 19.6.3 생성자 함수

+ 사용자 정의 생성자 함수와 더불어 생성된 프로토타입의 프로퍼티는 constructor 뿐이다.
+ 프로퍼티를 추가/삭제해 프로토타입 체인에 반영시킬 수 있다.

<br>

### 19.7 프로토타입 체인

+ 프로토타입 체인 : 자바스크립트는 객체의 프로퍼티에 접근하려고 할 때 해당 객체에 접근하려는 프로퍼티가 없으면 내부 슬롯의 참조를 따라 부모 역할을 하는 프로토타입의 프로퍼티를 순차적으로 검색한다.
+ 생성자 함수에 의해 생성된 객체는 Object.prototype 의 메서드인 hasOwnProperty 를 호출할 수 있다.
+ 프로토타입 체인의 최상위에 위치하는 객체는 언제나 Object.prototype 이다. (체인의 종점)
+ 프로토타입 체인은 상속과 프로퍼티 검색을 위한 메커니즘이다.

```jsx
function Person(name) {
	 this.name = name;
}

Person.prototype.sayHello = functiont() {
	console.log(`Hi! My Name is ${this.name}`);
};

const me = new Person('Kim');

console.log(me.hasOwnProperty('name')); // true

// me 객체는 Person.prototype 의 프로토타입인 Object.prototype 도 상속 받았다.
```

<br>

### 19.8 오버라이딩과 프로퍼티 섀도잉

+ 프로토타입 프로퍼티와 같은 이름의 프로퍼티를 인스턴스에 추가하면 프로토타입 체인을 따라 프로토타입 프로퍼티를 검색해 프로토타입 프로퍼티를 덮어쓰는 것이 아니라 인스턴스 프로퍼티로 추가된다.
+ 하위 객체를 통해 프로토타입의 프로퍼티를 변경 또는 삭제하는 것은 불가능하다.
+ 프로퍼티 섀도잉 : 상속 관계에 의해 프로퍼티가 가려지는 현상
+ 오버라이딩 : 상위 클래스가 가지고 있는 메서드를 하위 클래스가 재정의해서 사용하는 방식

```javascript
const Person = (function() {
	function Person(name) {
		this.name = name;
	}
	
	Person.prototype.sayHello = function() {
		console.log(`안녕하십니까 ${this.name} 님`);
	};
	
	return Person;
}());

const me = new Person('Kim');

me.sayHello = function() {
	console.log(`안녕하냐 ${this.name} 아`);
};

me.sayHello(); // 안녕하냐 Kim 아

delete me.sayHello;
me.sayHello(); // 안녕하십니까 Kim 님
```

<br>

### 19.9 프로토타입의 교체

+ 부모 객체인 프로토타입을 동적으로 변경할 수 있다.

+ 생성자 함수의 prototype 프로퍼티를 통한 교체 : 생성자 함수의 prototype 프로퍼티가 교체된 프로토타입을 가리킨다.
+ 인스턴스에 의한 프로토타입 교체 : 생성자 함수의 prototype 프로퍼티가 교체된 프로토타입을 가리키지 않는다.
+ 프로토타입을 교체하면 constructor 프로퍼티와 생성자 함수 간의 연결이 파괴된다.
+ 프로토타입 교체를 통해 객체 간의 상속 관계를 동적으로 변경하는 것은 번거로우므로 직접 교체하지 않는다. -> 직접 상속, 클래스 사용

<br>

### 19.10 instanceof 연산자

+ instanceof : 이항 연산자로 좌변에 객체를 가리키는 식별자, 우변에 생성자 함수를 가리키는 식별자를 피연산자로 받는다.
+ 생성자 함수의 prototype 프로퍼티를 통해 프로토타입이 교체되어 constructor 프로퍼티와 생성자 함수 간의 연결이 파괴되어도 생성자 함수의 prototype 프로퍼티와 프로토타입 간의 연결은 파괴되지 않으므로 instanceof 는 영향을 받지 않는다.

```javascript
객체 instanceof 생성자 함수

function Person(name) {
	this.name = name;
}

const me = new Person('Kim');

console.log(me instanceof Person); // true
console.log(me instanceof Object); // true

const parent = {};

// 프로토타입의 교체
Object.setPrototypeOf(me, parent);

console.log(Person.prototype === parent); // false
console.log(parent.constructor === Person); // false
console.log(me.constructor === Person); // false
console.log(me instanceof Person); // false
console.log(me instanceof Object); // true

// 프로토타입으로 교체한 parent 객체를 Person 생성자 함수의 프로토타입 프로퍼티에 바인딩하면 true 로 평가된다. 
// Person.prototype = parent;
```

<br>

### 19.11 직접 상속

#### 19.11.1 Object.create 메서드에 의한 직접 상속

+ Object.create(생성할 객체의 프로토타입으로 지정할 객체, 생성할 객체의 프로퍼티 키와 디스크립터 객체로 이루어진 객체)
+ 객체를 생성하면서 직접적으로 상속을 구현한다.
+ 프로토타입 체인의 종점에 위치하는 객체는 Object.prototype 의 빌트인 메서드를 사용할수 없기에 간접적으로 호출하는 것이 좋다.

```javascript
let obj = Object.create(null);
console.log(Object.getPrototypeOf(obj) === null); // true

obj = Object.create(Object.prototype);
obj = Object.create(Object.prototype, {
	x: { value: 1, writable: true, enumerable: true, configuration: true }
});

console.log(Object.prototype.hasOwnProperty.call(obj, 'a')); // true
```

#### 19.11.2 객체 리터럴 내부에서 proto 에 의한 직접 상속

+ Object.create 메서드에 의한 직접 상속은 여러 장점이 있지만 두번째 인자로 프로퍼티를 정의하는 것은 번거롭다.

```javascript
const myProto = { x: 10 };

// 아래의 코드와 같다.
const obj = {
	y: 20,
	__proto__: myProto
};

/* const obj = Object.create(myProto, {
	y: { value: 20, writable: true, enumerable: true, configuration: true }
});
*/
```

<br>

### 19.12 정적 프로퍼티/메서드

+ 정적 프로퍼티/메서드 : 생성자 함수로 인스턴스를 생성하지 않아도 참조/호출할 수 있는 프로퍼티/메서드
+ Object.create 메서드는 정적 메서드로 생성자 함수가 생성한 객체(인스턴스)로 호출할 수 없다.
+ 생성자 함수에 프로토타입을 추가하고 프로토타입 메서드를 호출하려면 인스턴스를 생성해야 하는데 정적 메서드는 인스턴스를 생성하지 않아도 호출할 수 있다.
+ 종류 : is, isEtentsible, isFrozen, isSealed, keys, preventExtensions 등
+ 특정 클래스의 인스턴스가 아닌 전체에 필요한 기능을 만들 때 사용해, 프로그램의 응집도를 높일 수 있다.

```javascript
const obj = Object.create({ name: 'Kim'});

obj.hasOwnProperty('name'); // false
// 정적 메서드는 인스턴스화 되면 호출할 수 없다.

function Foo() {}

Foo.prototype.x = function(){
	console.log('x');
};
const foo = new Foo();
foo.x(); // x
// 프로토타입 메서드를 호출하려면 인스턴스를 생성해야 한다.

Foo.x = function(){
	console.log('x');
};
Foo.x(); // x
// 정적 메서드는 인스턴스를 생성하지 않아도 호출할 수 있다.
```

<br>

### 19.13 프로퍼티 존재 확인

#### 19.13.1 in 연산자

+ 객체 내에 특정 프로퍼티가 존재하는지 여부를 확인
+ key in object
+ 객체가 속한 프로토타입 체인 상에 존재하는 모든 프로토타입에서 검색한다.

```javascript
const person = {
	name: 'Kim',
	address: 'Suwon'
};

console.log('name' in person); // true
console.log('age' in person); // false

console.log('toString' in person); // true
// in 연산자가 person 객체가 속한 프로토타입 체인 상에 존재하는 모든 프로토타입에서 toString 프로퍼티를 검색했기 때문이다.
```

+ ES6 에서 도입된 Reflect.has 메서드를 이용할 수도 있다.

```javascript
console.log(Reflect.has(person, 'name')); // true
```

#### 19.13.2 Object.prototype.hasOwnProperty 메서드

+ 인수로 전달받은 프로퍼티 키가 객체 고유의 프로퍼티 키인 경우에만 true 를 반환하고 상속받은 프로토타입의 프로퍼티 키인 경우 false 를 반환한다.

```javascript
console.log(person.hasOwnProperty('name')); // true
console.log(person.hasOwnProperty('inString')); // false
```

<br>

### 19.14 프로퍼티 열거

#### 19.14.1 for...in 문

+ 객체의 모든 프로퍼티를 순회하며 열거하려면 for...in 문을 사용한다.
+ for (변수선언문 in 객체) {...}
+ 상속받은 프로토타입의 프로퍼티까지 열거하지만, toString 과 같은 Object.prototype 의 프로퍼티가 열거되지 않는다. [[Enumerable]] 의 값이 false 이기 때문이다.
+ 객체의 프로토타입 체인 상에 존재하는 모든 프로토타입의 프로퍼티 중에서 프로퍼티 어트리뷰트 [[Enumerable]] 의 값이 true 인 프로퍼티를 순회하며 열거한다.
+ 프로퍼티 키가 심벌인 프로퍼티는 열거하지 않는다.

```javascript
const person = {
	name: 'Kim',
	address: 'Suwon'
};

for (const key in person) {
	console.log(key + ': ' + person[key]);
} 
// name: Kim, address: Suwon
```

+ 상속받은 프로퍼티는 제외하고 객체 자신의 프로퍼티만 열거하려면 Object.prototype.hasOwnProperty 메서드를 사용해 확인해야 한다.

```javascript
const person = {
	name: 'Kim',
	address: 'Suwon',
	__proto__: { age: 20 }
};

for (const key in person) {
	if (!person.hasOwnProperty(key)) continue;
	console.log(ket + ': ' + person[key]);
} 
// name: Kim, address: Suwon
// 상속받은 프로퍼티는 열거되지 않는다.
```

+ 배열에는 for...in 문을 사용하지 말고 일반적인 for 문이나 for...of 문, Array.prototype.forEach 메서드를 사용한다.

```javascript
const arr = [1, 2, 3];
arr.x = 10; // 배열도 객체이므로 프로퍼티를 가질 수 있다.

// for...in 문
for (const i in arr) {
	console.log(arr[i]); // 1 2 3 10
};
// 프로퍼티 x 도 출력된다.

// 일반적인 for 문
for (let i = 0; i < arr.length; i++) {
    console.log(arr[i]); // 1 2 3
};

// forEach 메서드는 요소가 아닌 프로퍼티는 제외한다.
arr.forEach(v => console.log(v)); // 1 2 3

// for...of 는 변수 선언문에서 선언한 변수에 키가 아닌 값을 할당한다.
for (const value of arr) {
    console.log(value); // 1 2 3
};
```

#### 19.14.2 Object.keys/values/entries 메서드

+ 객체 자신의 고유 프로퍼티만 열거하기 위해서 사용
+ Object.keys 메서드 : 객체 자신의 열거 가능한 프로퍼티 키를 배열로 반환한다.
+ Object.values 메서드 : 객체 자신의 열거 가능한 프로퍼티 값을 배열로 반환한다.
+ Object.entries 메서드 : 객체 자신의 열거 가능한 프로퍼티 키와 값의 쌍을 배열에 담아 반환한다.

```javascript
const person = {
	name: 'Kim',
	address: 'Suwon',
	__proto__: { age: 20 }
};

console.log(Object.keys(person)); // ["name", "address"]

// ES8 에서 도입된 Object.values 메서드
console.log(Object.values(person)); // ["Kim", "Suwon"]

// ES8 에서 도입된 Object.entries 메서드
console.log(Object.entries(person)); // [["name", "Kim"], ["address", "Suwon"]]

Object.entries(person).forEach(([key, value]) => console.log(key, value));
/*
name Kim
address Suwon
*/
```

<br>

<br>

<br>

# 20장 strict mode

### 20.1 strict mode 란?

+ 잠재적인 오류를 발생시키기 어려운 개발 환경을 만들고 그 환경에서 개발하는 것이 안전하다.
+ 린트 도구 : 정적 분석 기능을 통해 소스코드를 실행하기 전에 문법적 오류와 잠재적 오류를 찾아내고 원인을 리포팅해주는 도구
+ ES6 에서 도입된 클래스와 모듈은 기본적으로 strict mode 가 적용된다.

<br>

### 20.2 strict mode 의 적용

+ 스코프의 선두에 'use strict'; 를 추가한다.
+ 선두에 추가하지 않으면 제대로 동작하지 않는다.

```javascript
// 전역에 추가하는 예
'use strict';

function foo() {
	x = 10; // ReferenceError
}
foo();


// 함수 코드 내에 추가하는 예
function foo() {
    'use strict';
    
    x = 10; // ReferenceError
}
foo();
```

<br>

### 20.3 사용 범위

+ 전역에 적용한 strict mode 는 스크립트 단위로 적용되고, 오류를 발생시킬 수 있다.
+ 함수 단위로 적용한 strict mode 는 외부 참조시 구분하기 어렵기 때문에 오류를 발생시킬 수 있다.
+  즉시 실행 함수로 스크립트 전체를 감싸서 스코프를 구분한다.

<br>

### 20.4 strict mode 가 발생시키는 에러

+ 암묵적 전역 : 선언하지 않은 변수를 참조하면 ReferenceError 가 발생한다.
+ 변수, 함수, 매개변수의 삭제 : delete 연산자로 삭제하면 SyntaxError 가 발생한다.
+ 매개변수 이름의 중복 : 매개변수 이름을 중복해 사용하면 SyntaxError 가 발생한다.
+ with 문의 사용 : with 문은 전달된 객체를 스코프 체인에 추가한다. 동일한 객체의 프로퍼티를 반복해서 사용할 때 이름을 생략할 수 있어서 간편하지만 사용하지 않는 것이 좋다.
+ 변수를 꼭 선언하고, delete 연산자를 사용하지 않고, 매개변수 이름을 중복하지 않고, with 문 사용을 피하자.

<br>

<br>

<br>

# 21장 빌트인 객체

### 21.1 표준 빌트인 객체

+ Object, String, Number, Boolean, Symbol, Date, Math, RegExp, Array, Map/Set, WeakMap/WeakSet, Function, Promise, Reflect, Proxy, JSON, Error 등 40 여개
+ 생성자 함수 객체 : 프로토타입 메서드와 정적 메서드를 제공
+ Math, Reflect, JSON : 정적 메서드만 제공

```javascript
// Stirng 생성자 함수에 의한 String 객체 생성
// strObj 인스턴스의 프로토타입은 String.prototype 이다.
const strObj = new String('Kim'); // String {"Kim"}
console.log(typeof strObj); // object
console.log(Object.getPrototypeOf(strObj) === String.prototype); // true
```

<br>

### 21.2 원시값과 래퍼 객체

+ 원시값은 객체가 아니므로 프로퍼티나 메서드를 가질 수 없는데도 원시값인 문자열이 마치 객체처럼 동작한다.
+ 원시값에 대해 객체처럼 마침표 표기법으로 접근하면 자바스크립트 엔진이 일시적으로 원시값을 연관된 객체를 생성해 생성된 객체로 프로퍼티에 접근하거나 메서드를 호출하고 다시 원시값으로 되돌린다.
+ 래퍼 객체 (wrapper object) : 문자열, 숫자, 불리언 값에 대해 객체처럼 접근하면 생성되는 임시 객체
+ 문자열, 숫자, 불리언, 심벌은 암묵적으로 생성되는 래퍼 객체에 의해 마치 객체처럼 사용할 수 있으며 표준 빌트인 객체의 프로토타입 메서드 또는 프로퍼티를 참조할 수 있다.
+ new 연산자와 함께 String, Number, Boolean 생성자 함수를 호출해 인스턴스를 생성할 필요가 없다.
+ null, undefined 는 래퍼 객체를 생성하지 않아서 객체처럼 사용하면 안된다.

```javascript
const str = 'hello';

// 원시 타입인 문자열이 래퍼 객체인 String 인스턴스로 변환된다.
console.log(str.length); // 5
console.log(str.toUpperCase()); // HELLO

// 래퍼 객체로 프로퍼티에 접근하거나 메서드를 호출한 후 다시 원시값으로 되돌린다.
console.log(typeof str); // string
```

<br>

### 21.3 전역 객체

+ 전역 객체 : 코드가 실행되기 이전 단계에 자바스크립트 엔진에 의해 어떤 객체보다도 먼저 생성되는 특수한 객체이며 어떤 객체에도 속하지 않은 최상위 객체
+ 전역 객체는 개발자가 의도적으로 생성할 수 없고 전역 객체의 프로퍼티를 참조할 때 생략할 수 있다.
+ 브라우저 환경에서는 window 또는 self, this, frames / Node.js 환경에서는 global
+ ES11 에서 통일된 식별자인 globalThis 가 도입되었다.

+ var 키워드로 선언한 전역 변수와 선언하지 않은 변수에 값을 할당한 암묵적 전역, 전역 함수는 전역 객체의 프로퍼티가 된다.

```javascript
var foo = 1;
console.log(window.foo); // 1

bar = 2;
console.log(window.bar); // 2

function bax() { return 3; }
console.log(window.baz()); // 3
```

+ let 과 const 키워드로 선언한 전역 변수는 전역 객체의 프로퍼티가 아닌, 전역 렉시컬 환경의 선언적 환경 레코드 내에 존재한다.

```javascript
let foo = 1;
console.log(window.foo); // undefined
```

+ 암묵적 전역 : 선언하지 않은 식별자에 값을 할당하면 전역 객체의 프로퍼티가 된다. 변수 선언 없이 전역 객체의 프로퍼티로 추가된 프로퍼티는 변수가 아니므로 변수 호이스팅이 발생하지 않는다. delete 로 삭제할 수 있다.

```javascript
console.log(x); // undefined
console.log(y); // ReferenceError

var x = 1;

function foo() {
	y = 2; // 변수 선언 없이 전역 객체의 프로퍼티로 추가되었기 때문에 호이스팅이 발생하지 않는다.
}
foo();

console.log(x + y); // 3

delete y; // 프로퍼티는 삭제된다.
delete x; // 전역 변수는 삭제되지 않는다.
```

#### 21.3.1 빌트인 전역 프로퍼티

+ Infinity : 무한대

+ NaN : Not-a-Number

```javascript
console.log(window.NaN); // NaN
console.log(Number('xyz')); // NaN
console.log(typeof NaN); // number
```

+ undefined

```javascript
console.log(typeof undefined); // undefined
```

#### 21.3.2 빌트인 전역 함수 (전역 객체의 메서드)

+ eval : 자바스크립트 코드를 나타내는 문자열을 인수로 전달받는다. 사용자로부터 입력받은 콘텐츠를 실행하는 것은 보안에 매우 취약하며, 자바스크립트 엔진에 의해 최적화가 수행되지 않으므로 일반적인 코드 실행에 비해 속도가 느리다. 사용금지!
+ isFinite : 전달받은 인수가 유한수이면 true, 무한수이면 false 를 반환한다. 숫자가 아닌 경우 숫자로 타입 변환한 후 검사하고 인수가 NaN 로 평가된다면 false 를 반환한다.

```javascript
isFinite(0); // true
isFinite('10'); // true
isFinite(null); // true (null = 0)
isFinite('Hello'); // false
```

+ isNaN : 전달받은 인수가 NaN 인지 검사해 NaN 이면 true, 숫자이면 false 를 반환한다. 인수 타입이 숫자가 아닌 경우 숫자로 타입 변환 한다.

```javascript
isNaN(NaN); // true
isNaN('ten'); // true
isNaN(undefined); // true
isNaN({}); // true

isNaN(10); // false
isNaN('1557'); // false
isNaN(' '); // false (공백은 0)
isNaN(true); // false
```

+ parseFloat : 전달받은 문자열 인수를 부동 소수점 숫자, 즉 실수로 해석해 반환한다.

```javascript
parseFloat('3.14'); // 3.14
parseFloat('90 3 26'); // 90
parseFloat('Hello world 99'); // NaN

// 공백으로 구분된 문자열은 첫번째만 변환한다.
// 첫번째 문자를 변환할 수 없다면 NaN 를 반환한다.
```

+ parseInt : 전달받은 문자열 인수를 정수로 해석해 반환한다.

```javascript
parseInt('10'); // 10

// 10을 2진수로 해석하고 결과를 10진수 정수로 반환한다.
parseInt('10', 2); // 2
parseInt('10', 8); // 8

// 첫번째 인수로 전달한 문자열의 첫 문자가 숫자로 변환될 수 없다면 NaN 를 반환한다.
parseInt('20', 2); // NaN
// 두번째 문자부터 해당 진수가 아닌 문자라면 무시되고 해석된 정수값만 반환한다.
parseInt('102', 2); // 2

// 10진수 숫자를 해당 기수의 문자열로 변환해 반환하고 싶을 경우
const x = 15;
x.toString(2); // '1111'
parseInt(x.toString(2), 2); // 15
```

+ encodeURI / decodeURI
+ encodeURIComponent / decodeURIComponent

<br>

<br>

<br>

# 22장 this

### 22.1 this 키워드

+ this : 자신이 속한 객체 또는 자신이 생성할 인스턴스를 가리키는 자기 참조 변수다. this 를 통해 자신이 속한 객체 또는 생성할 인스턴스의 프로퍼티나 메서드를 참조할 수 있다.

```javascript
function Circle(radius) {
	this.radius = radius;
}
// this 는 생성자 함수가 생성할 인스턴스를 가리킨다.

Circle.prototype.getDiameter = function() {
	return 2 * this.radius;
};
// this 는 생성자 함수가 생성할 인스턴스를 가리킨다.

const circle = new Circle(5);
console.log(circle.getDiameter()); // 10
```

+ this 바인딩은 함수 호출 방식에 의해 동적으로 결정된다.
+ 하지만 this 는 객체의 메서드 내부 또는 생성자 함수 내부에서만 의미가 있다.

```javascript
console.log(this); // window

function square(number) {
	console.log(this); // window
	return number * number;
}
square(2);
// 일반 함수 내부에서 this 는 전역 객체를 가리킨다. 

const person = {
	name: 'Kim',
	getName() {
		console.log(this); // person 객체를 가리킨다.
		return this.name;
	}
};
console.log(person.getName());

// this 는 함수가 호출되는 방식에 따라 this 바인딩이 동적으로 결정된다.
```

<br>

### 22.2 함수 호출 방식과 this 바인딩

+ this 바인딩은 함수가 어떻게 호출되었는지에 따라 동적으로 결정된다.

#### 22.2.1 일반 함수 호출

+ 전역 함수나 중첩 함수, 콜백 함수를 일반 함수로 호출하면 함수 내부의 this 에는 전역 객체가 바인딩된다. 

```javascript
function foo() {
	console.log("foo's this: ", this); // window
	function bar() {
		console.log("bar's this: ", this); // window
	}
	bar();
}
foo();
```

+ strict mode 가 적용된 상태에서는 undefined 가 바인딩된다.

```javascript
function foo() {
	'use strict';
	
	console.log("foo's this: ", this); // undefined
}
foo();
```

+ 메서드 내에서 정의한 중첩 함수 또는 메서드에게 전달한 콜백 함수가 일반 함수로 호출될 때 this 가 전역 객체를 바인딩하는 것은 문제가 있다. 외부 함수인 메서드와 중첩 함수 또는 콜백 함수의 this 가 일치하지 않는다는 것은 중첩 함수나 콜백 함수를 헬퍼 함수로 동작하기 어렵게 만든다.
+ 메서드 내부의 중첩 함수나 콜백 함수의 this 바인딩을 메서드의 this 바인딩과 일치시키기 위해서는 function.prototype.bind 메서드를 이용한다.

```javascript
var value = 1;

const obj = {
	value: 100,
	foo() {
		setTimeout(function() {
			console.log(this.value);
		}.bind(this),100);
	}
};
obj.foo();

// obj 객체의 메서드로서 foo 함수를 호출한 것
// bind 메서드를 이용하면 콜백 함수의 this 바인딩이 전역 객체를 가리키지 않는다.
```

#### 22.2.2 메서드 호출

+ 메서드 내부의 this 는 메서드를 소유한 객체가 아닌 메서드를 호출한 객체에 바인딩 된다.

```javascript
const person = {
	name: 'Kim',
	getName() {
		return this.name;
	}
};

console.log(person.getName()); // Kim

const anotherPerson = {
	name: 'Lee'
};

anotherPerson.getName = person.getName;

console.log(anotherPerson.getName()); // Lee
// getName 메서드를 소유한 person 이 아닌 호출한 anotherPerson 에 바인딩 되었다.
```

+ 프로토타입 메서드 내부에서 사용된 this 도 일반 메서드처럼 해당 메서드를 호출한 객체에 바인딩 된다.

```javascript
function Person(name) {
	this.name = name;
}

Person.prototype.getName = function() {
	return this.name;
};

const me = new Person('Kim');
console.log(me.getName()); // Kim

Person.prototype.name = 'Lee';
console.log(Person.prototype.getName()); // Lee
```

#### 22.2.3 생성자 함수 호출

+ 생성자 함수 내부의 this 에는 생성자 함수가 생성할 인스턴스가 바인딩 된다.
+ new 연산자와 함께 호출하지 않으면 일반 함수로 동작해 전역 객체를 가리킨다.

```javascript
function Circle(radius) {
	this.radius = radius;
    this.getDiameter = function () {
        return 2 * this.radius;
    };
}
// this 는 생성자 함수가 생성할 인스턴스를 가리킨다.

const circle = new Circle(5);
console.log(circle.getDiameter()); // 10
```

#### 22.2.4 Function.prototype.apply/call/bind 메서드에 의한 간접 호출

<br>

<br>

<br>

# 23장 실행 컨텍스트

### 23.1 소스코드의 타입

+ 전역 코드 -> 전역 실행 컨텍스트
+ 함수 코드 -> 함수 실행 컨텍스트
+ 모듈 코드 -> 모듈 실행 컨텍스트

### 23.2 소스코드의 평가와 실행

+ 소스코드의 평가 : 실행 컨텍스트를 생성하고 변수, 함수 등의 선언문만 먼저 실행해 생성된 변수나 함수 식별자를 키로 실행 컨텍스트가 관리하는 스코프에 등록한다.
+ 소스코드의 실행 : 런타임이 시작되고 소스코드 실행에 필요한 정보, 즉 변수나 함수의 참조를 실행 컨텍스트가 관리하는 스코프에서 검색해 취득한다. 그리고 변수 값의 변경 등 소스코드의 실행 결과는 다시 실행 컨텍스트가 관리하는 스코프에 등록된다.

```javascript
var x;
x = 1;

// 소스코드의 평가 : x 는 실행 컨텍스트가 관리하는 스코프에 등록되고 undefined 로 초기화된다.
// 소스코드의 실행 : x 변수가 선언된 변수인지 실행 컨텍스트가 관리하는 스코프에서 확인하고, 값을 할당해 할당 결과를 실행 컨텍스트에 등록한다.
```

### 23.3 실행 컨텍스트의 역할

```javascript
const x = 1;
const y = 2;

function foo(a) {
	const x = 10;
	const y = 20;
	console.log(a + x + y); // 130
}

foo(100);

console.log(x + y); // 3

/* 
1. 전역 코드 평가 : 전역 코드를 실행하기 위해 선언문이 먼저 실행되고 생성된 전역 변수와 전역 함수가 실행 컨텍스트가 관리하는 전역 스코프에 등록된다. 
2. 전역 코드 실행 : 런타임이 시작되고 전역 변수에 값이 할당되고 함수가 호출된다. 함수가 호출되면 전역 코드의 실행을 중단하고 실행 순서를 변경해 함수 내부로 진입한다.
3. 함수 코드 평가 : 함수 코드 실행 준비를 위해 매개변수와 지역 변수 선언문이 실행되고 매개변수와 지역 변수가 실행 컨텍스트가 관리하는 지역 스코프에 등록된다. 함수 내부에서 arguments 객체가 생성되어 지역 스코프에 등록되고 this 바인딩도 결정된다.
4. 함수 코드 실행 : 런타임이 시작되고 함수 코드가 실행 된다. console.log 메서드를 호출하기 위해 스코프 체인을 통해 검색하고 전역 객체의 프로퍼티이기 때문에 전역 스코프를 통해 검색된다. console.log 메서드가 종료되면 함수 코드 실행 과정이 종료되고 함수 호출 이전으로 돌아가 전역 코드 실행을 계속한다. 
*/
```

+ 코드가 실행되려면 스코프를 구분해 식별자와 바인딩된 값이 관리되어야 한다. 중첩 관계에 의해 스코프 체인을 형성해 식별자를 검색할 수 있어야 하고, 전역 객체의 프로퍼티도 전역 변수처럼 검색할 수 있어야 한다.
+ 실행 컨텍스트 : 소스코드를 실행하는데 필요한 환경을 제공하고 코드의 실행 결과를 실제로 관리하는 영역이며 식별자를 등록하고 관리하는 스코프와 코드 실행 순서 관리를 구현한 내부 매커니즘으로 모든 코드는 실행 컨텍스트를 통해 실행되고 관리된다.
+ 렉시컬 환경 (식별자와 스코프) / 실행 컨텍스트 스택 (코드 실행 순서)

### 23.4 실행 컨텍스트 스택

+ 코드가 실행되는 시간의 흐름에 따라 실행 컨텍스트 스택에 실행 컨텍스트가 추가(push) 되고 제거(pop) 된다.
+ Running execution context : 실행 컨텍스트 스택의 최상위에 존재하는 실행 컨텍스트

### 23.5 렉시컬 환경

+ 렉시컬 환경 : 식별자와 식별자에 바인딩된 값, 상위 스코프에 대한 참조를 기록하는 자료구조로 실행 컨텍스트를 구성하는 컴포넌트다. 또한 스코프를 구분해 식별자를 등록하고 관리하는 저장소 역할을 하는 렉시컬 스코프의 실체다.
  - 환경 레코드 (Environment Record) : 스코프에 포함된 식별자를 등록하고 식별자에 바인딩된 값을 관리하는 저장소
  - 외부 렉시컬 환경에 대한 참조 (Outer Lexical Environment Reference) : 해당 실행 컨텍스트를 생성한 소스코드를 포함하는 상위 코드의 렉시컬 환경, 즉 상위 스코프를 말한다.

### 23.6 실행 컨텍스트의 생성과 식별자 검색 과정

```javascript
var x = 1;
const y = 2;

function foo(a) {
	var x = 3;
	const y = 4;
	
	function bar(b) {
		const z = 5;
		console.log(a + b + x + y + z);
	}
	bar(10);
}

foo(20); // 42
```

#### 23.6.1 전역 객체 생성

+ 전역 코드가 평가되기 전 전역 객체가 생성되고 빌트인 전역 프로퍼티, 빌트인 전역 함수, 표준 빌트인 객체가 추가된다. 프로토타입 체인의 일원으로 Object.prototype 을 상속받는다.

#### 23.6.2 전역 코드 평가

+ 전역 실행 컨텍스트 생성 : 전역 실행 컨텍스트를 생성해 실행 컨텍스트 스택에 푸시한다.
+ 전역 렉시컬 환경 생성 : 전역 렉시컬 환경을 생성하고 전역 실행 컨텍스트에 바인딩한다.
  - 전역 환경 레코드 생성
    - 객체 환경 레코드 생성 : var 키워드로 선언한 전역 변수와 함수 선언문으로 정의한 전역 함수, 빌트인 전역 프로퍼티와 빌트인 전역 함수, 표준 빌트인 객체를 관리한다. BindingObject 라고 부르는 객체와 연결되어 전역 객체의 프로퍼티와 메서드가 된다.
    - 선언적 환경 레코드 생성 : let, const 키워드로 선언한 전역 변수를 관리한다. 개념적인 블록 내에 존재하며 런타임에 실행 흐름이 변수 선언문에 도달하기 전까지 일시적 사각지대 (TDZ) 에 빠지게 된다.
  - this 바인딩 : 전역 환경 레코드와 함수 환경 레코드에만 존재한다.
  - 외부 렉시컬 환경에 대한 참조 : 상위 스코프를 가리키며 평가중인 코드가 전역 코드일때는 null 이 할당된다.

#### 23.6.3 전역 코드 실행

+ 전역 코드가 실행되기 시작하고 변수 할당문이 실행되어 변수 x, y 에 값이 할당된다. foo 함수가 호출되면 실행 컨텍스트의 렉시컬 환경의 환경 레코드에서 식별자를 검색한다. 전역 렉시컬 환경에서 검색할 수 없다면 참조 에러를 발생시킨다.

#### 23.6.4 foo 함수 코드 평가

+ 함수 실행 컨텍스트 생성 : 함수 렉시컬 환경이 완성된 다음 함수 실행 컨텍스트는 실행 컨텍스트에 푸시된다.
+ 함수 렉시컬 환경 생성 : 함수 렉시컬 환경을 생성하고 foo 함수 실행 컨텍스트에 바인딩한다.
  - 함수 환경 레코드 생성 : 매개변수, arguments 객체, 함수 내부에서 선언한 지역 변수와 중첩 함수를 등록하고 관리한다.
  - this 바인딩 : foo 함수는 일반 함수로 호출되었으므로 this 는 전역 객체를 가리킨다. [[ThisValue]] 내부 슬롯에 전역 객체가 바인딩된다.
  - 외부 렉시컬 환경에 대한 참조 : foo 함수는 전역 코드에 정의된 전역 함수로, 외부 렉시컬 환경에 대한 참조에는 전역 렉시컬 환경의 참조가 할당된다. 





























