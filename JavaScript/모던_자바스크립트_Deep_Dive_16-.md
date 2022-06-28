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
arguments [1, 2,callee: f, Symbol(Symbol.iterator): f]
0: 1
1: 2
callee: f multiply(x, y)
length: 2

console.log(multiply(1, 2, 3)); // 2
arguments [1, 2, 3callee: f, Symbol(Symbol.iterator): f]
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

+ 생성자 함수로 호출할 수 있는 함수 객체, 즉 constuctor 만이 소유하는 프로퍼티
+ 함수가 객체를 생성하는 생성자 함수로 호출될 때 생성자 함수가 생성할 인스턴스의 프로토타입 객체를 가리킨다.

```javascript
(function () {}).hasOwnProperty('prototype'); // true
({}).hasOwnProperty('prototype'); // false
```

<br>

<br>

<br>

# 19장 프로토타입































