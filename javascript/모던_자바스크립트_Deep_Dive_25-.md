# 25장 클래스

### 25.1 클래스는 프로토타입의 문법적 설탕인가?

+ 자바스크립트에서는 클래스 없이도 생성자 함수와 프로토타입을 통해 객체지향 언어의 상속을 구현할 수 있다.
+ ES6 에서는 자바나 C# 와 같은 클래스 기반 객체지향 프로그래밍에 익숙한 프로그래머가 더욱 빠르게 학습할 수 있도록 클래스 기반 객체지향 프로그래밍 언어와 매우 흡사한 새로운 객체 생성 매커니즘을 제시한다.
+ 클래스와 생성자 함수는 모두 프로토타입 기반의 인스턴스를 생성하지만 클래스는 생성자 함수보다 엄격하며 몇 가지 차이가 있다.
  - 클래스를 new 연산자 없이 호출하면 에러가 발생 / 생성자 함수는 일반 함수로 호출
  - 클래스는 상속을 지원하는 extends, super 키워드를 제공 / 생성자 함수는 없음
  - 클래스는 호이스팅이 발생하지 않음 / 생성자 함수는 함수 선언문으로 정의되면 함수 호이스팅이, 함수 표현식으로 정의되면 변수 호이스팅이 발생
  - 클래스 내의 모든 코드는 암묵적으로 strict mode 가 지정되어 해제 불가능 / 생성자 함수는 지정되지 않음
  - 클래스의 constructor, 프로토타입 메서드, 정적 메서드는 모두 프로퍼티 어트리뷰트 [[Enumerable]] 의 값이 false 이며 열거되지 않음
+ 클래스는 생성자 함수 기반의 객체 생성 방식보다 상속 관계 구현을 더욱 간결하고 명료하게 한다.
+ 새로운 객체 생성 메커니즘으로 보자

<br>

### 25.2 클래스 정의

+ 클래스는 class 키워드를 사용해 정의한다.
+ 클래스는 표현식으로도 정의할 수 있고 함수이며 값처럼 사용할 수 있는 일급 객체다.
+ 클래스와 생성자 함수의 정의 방식은 형태적인 면에서 유사하다.

```javascript
class Person {
	constructor(name) {
		this.name = name;
	}
	
	sayHi() {
		console.log(`Hi! my name is ${this.name}`);
	}
	
	static sayHello() {
		console.log('Hello!');
	}
}

const me = new Person('Kim');

console.log(me.name); // Kim
me.sayHi(); // Hi! my name is Kim
person.sayHello(); // Hello!
```

<br>

### 25.3 클래스 호이스팅

+ 클래스 선언문으로 정의한 클래스는 함수 선언문과 같이 런타임 이전에 평가되어 함수 객체를 생성한다.
+ 클래스 선언문은 호이스팅이 발행하지만 let, const 키워드로 선언한 변수처럼 호이스팅 된다. -> 일시적 사각지대

<br>

### 25.4 인스턴스 생성

+ 클래스는 인스턴스를 생성하는 것이 유일한 존재 이유이므로 반드시 new 연산자와 함께 호출해야 한다.

```javascript
class Person {}

const me = Person(); // TypeError
```

+ 클래스 표현식으로 정의된 클래스의 경우 클래스를 가리키는 식별자를 사용해 인스턴스를 생성해야 한다.

```javascript
const Person = class MyClass {};

const me = new Person();

console.log(MyClass); // ReferenceError (클래스 이름은 클래스 몸체 내부에서만 유효한 식별자다.)
```

<br>

### 25.5 메서드

+ 클래스 몸체에서 정의할 수 있는 메서드는 생성자, 프로토타입 메서드, 정적 메서드가 있다.

#### 25.5.1 constructor

+ constructor 는 인스턴스를 생성하고 초기화하기 위한 특수한 메서드다.
+ 클래스가 평가되어 생성된 함수 객체나 클래스가 생성한 인스턴스에는 constructor 메서드가 존재하지 않는다. 메서드로 해석되는 것이 아니라 클래스 정의가 평가되면 constructor 의 기술된 동작을 하는 함수 객체가 생성된다.
+ constructor 는 생략 가능하지만 인스턴스를 초기화하려면 생략해선 안된다.
+ return 문을 반드시 생략해야 한다.

#### 25.5.2 프로토타입 메서드

+ 생성자 함수를 사용해 인스턴스를 사용하는 경우 프로토타입 메서드를 생성하기 위해서는 명시적으로 prototype 을 추가해야 한다.
+ 클래스 몸체에서 정의한 메서드는 기본적으로 프로토타입 메서드가 된다.
+ 클래스는 생성자 함수와 마찬가지로 프로토타입 기반의 객체 생성 메커니즘이다.

#### 25.5.3 정적 메서드

+ 정적 메서드는 인스턴스를 생성하지 않아도 호출할 수 있는 메서드를 말한다.
+ 생성자 함수에서는 명시적으로 메서드를 추가해야 한다. (Person.sayHi = func...)
+ 클래스에서는 메서드에 static 키워드를 붙이면 된다.
+ 정적 메서드는 프로토타입 메서드처럼 인스턴스로 호출하지 않고 클래스로 호출한다. 인스턴스의 프로토타입 체인 상에는 클래스가 존재하지 않기 때문에 인스턴스로 클래스의 메서드를 상속받을 수 없다.

```javascript
Person.sayHi(); // Hi!

const me = new Person('Kim');
me.sayHi(); // TypeError
```

#### 25.5.4 정적 메서드와 프로토타입 메서드의 차이

+ 자신이 속해 있는 프로토타입 체인이 다르다.
+ 정적 메서드는 클래스로, 프로토타입 메서드는 인스턴스로 호출한다.
+ 정적 메서드는 인스턴스 프로퍼티를 참조할 수 없지만 프로토타입 메서드는 인스턴스 프로퍼티를 참조할 수 있다.
+ 메서드 내부에서 인스턴스 프로퍼티를 참조할 필요가 있다면 this 를 사용해야 하며 이런 경우 -> 프로토타입 메서드로 정의해야 한다.
+ 메서드 내부에서 인스턴스 프로퍼티를 참조해야 할 필요가 없다면 this 를 사용하지 않게 된다.

#### 25.5.5 클래스에서 정의한 메서드의 특징

+ 메서드 축약 표현 사용
+ 콤마 필요 없음
+ 암묵적으로 strict mode 로 실행
+ 열거 불가능
+ 내부 메서드 [[Construct]] 를 갖지 않는 non-constructor, new 연산자와 함께 호출할 수 없다.

<br>

### 25.6 클래스의 인스턴스 생성 과정

+ 인스턴스 생성과 this 바인딩 : new 연산자와 함께 클래스를 호출하면 암묵적으로 빈 객체가 생성된다. 이때 클래스가 생성한 인스턴스의 프로토타입으로 클래스의 prototype 프로퍼티가 가리키는 객체가 설정된다. constructor 내부의 this 는 클래스가 생성한 인스턴스를 가리킨다.
+ 인스턴스 초기화 : this 에 바인딩되어 있는 인스턴스에 프로퍼티를 추가하고 construtor 가 인수로 전달받은 초기값으로 인스턴스의 프로퍼티를 초기화 한다.
+ 인스턴스 반환 : 인스턴스가 바인딩된 this 가 암묵적으로 반환된다.

```javascript
class Person {
	constructor(name) {
	// 1. 암묵적으로 인스턴스가 생성되고 this 에 바인딩된다.
	console.log(this); // Person {}
	console.log(Object.getPrototypeOf(this) === Person.prototype); // true
	
	// 2. this 에 바인딩되어 있는 인스턴스를 초기화한다.
		this.name = name;
	// 3. 완성된 인스턴스가 바인딩된 this 가 암묵적으로 반환된다.
	}
```

<br>

### 25.7 프로퍼티

#### 25.7.1 인스턴스 프로퍼티

+ 인스턴스 프로퍼티는 반드시 constructor 내부에서 정의해야 한다.
+ constructor 내부에서 this 에 추가한 프로퍼티는 언제나 클래스가 생성한 인스턴스의 프로퍼티가 된다.

#### 25.7.2 접근자 프로퍼티

+ getter 는 호출하는 것이 아니라 프로퍼티처럼 참조하는 형식으로 사용하며 참조 시에 내부적으로 getter 가 호출된다.
+ setter 는 호출하는 것이 아니라 프로퍼티처럼 값을 할당하는 형식으로 사용하며 할당 시에 내부적으로 setter 가 호출된다.
+ 클래스의 메서드는 기본적으로 프로토타입 메서드가 된다. 따라서 클래스의 접근자 프로퍼티 또한 인스턴스 프로퍼티가 아닌 프로토타입의 프로퍼티가 된다.

#### 25.7.3 클래스 필드 정의 제안

+ 클래스 필드 : 클래스 기반 객체지향 언어에서 클래스가 생성할 인스턴스의 프로퍼티를 가리키는 용어, 변수처럼 사용됨
+ 자바스크립트의 클래스 몸체에는 메서드만 선언할 수 있고 자바와 유사하게 클래스 필드를 선언하면 문법 에러가 발생하지만 최신 브라우저에서 선제적으로 구현해 놓았다. 표준 사양으로 승급이 확실시 된다.

#### 25.7.4 private 필드 정의 제안

+ 자바스크립트의 인스턴스 프로퍼티는 언제나 public 이다.
+ #private 으로 private 필드를 정의할 수 있는 새로운 표준 사양이 제안되어 있다.
+ private 필드는 반드시 클래스 몸체에 정의해야 한다. constructor 에 정의하면 SyntaxError 가 발생한다.

```javascript
class Person {
	#name = '';
	
	constructor(name) {
		this.#name = name;
	}
}

const me = new Person('Kim');

console.log(me.#name); // SyntaxError
```

#### 25.7.5 static 필드 정의 제안

+ static 키워드를 사용한 정적 필드 정의가 구현되어 있다.

<br>

### 25.8 상속에 의한 클래스 확장

#### 25.8.1 클래스 상속과 생성자 함수 상속

+ 프로토타입 기반 상속은 프로토타입 체인을 통해 다른 객체의 자산을 상속받는 개념
+ 상속에 의한 클래스 확장은 기존 클래스를 상속받아 새로운 클래스를 확장하여 정의하는 것
+ 예를 들어 동물을 추상화한 animal, 새를 추상화한 bird, 사자를 추상화한 lion 이 있을 때, 새와 사자는 동물에 속하므로 animal 클래스의 속성을 그대로 사용하면서 자신만의 고유한 속성을 추가해 확장할 수 있다.

```javascript
class Animal {
	constructor(age, weight) {
		this.age = age;
		this.weighe = weight;
	}
	eat() { return 'eat'; }
	move() { return 'move'; }
}

class Bird extends Animal {
	fly() { return 'fly'; }
}

const bird = new Bird(1, 5);
```

#### 25.8.2 extends 키워드

+ 수퍼/베이스Base/부모 클래스
+ 서브/파생Derived/자식 클래스
+ 수퍼클래스와 서브클래스는 인스턴스의 프로토타입 체인 뿐 아니라 클래스 간의 프로토타입 체인도 생성한다.

#### 25.8.3 동적 상속

+ extends 키워드는 클래스 뿐 아니라 함수 객체로 평가될 수 있는 모든 표현식을 상속받아 클래스를 확장할 수도 있다. 단, extends 키워드 앞에는 반드시 클래스가 와야한다.
+ 클래스 -> 생성자 함수, 함수 표현식 등

```javascript
function Base1() {}

class Base2 {}

let condition = true;

// 조건에 따라 동적으로 상속 대상을 결정하는 서브클래스
class Derived extends (condition ? Base1 : Base2 ) {}

const derived = new Derived();
```

#### 25.8.4 서브클래스의 constructor

+ 클래스에서 constructor 를 생략하면 암묵적으로 비어있는 constructor 가 정의된다.

#### 25.8.5 super 키워드

+ super 키워드는 함수처럼 호출할 수도 있고 this 와 같이 식별자처럼 참조할 수 있는 특수한 키워드다.
  - super 를 호출하면 수퍼클래스의 constructor 를 호출한다.
  - super 를 참조하면 수퍼클래스의 메서드를 호출할 수 있다.
+ 수퍼클래스에서 추가한 프로퍼티와 서브클래스에서 추가한 프로퍼티를 갖는 인스턴스를 생성하다면 수퍼클래스의 constructor 에 전달할 필요가 있는 인수는 서브클래스의 constructor 에서 호출하는 super 를 통해 전달한다. 인스턴스 초기화를 위해 전달한 인수는 수퍼클래스와 서브클래스에 배분되고 상속 관계의 두 클래스는 서로 협력해 인스턴스를 생성한다.

```javascript
class Base {
	constructor(a, b) {
		this.a = a;
		this.b = b;
	}
}

class Derived extends Base {
	constructor(a, b, c) {
		super(a, b);
		this.c = c;
	}
}

const derived = new Derived(1, 2, 3); 

/* 주의사항
1. 서브클래스에서 constructor 를 생략하지 않는 경우 반드시 super 를 호출해야 한다. (ReferenceError)
2. 서브클래스에서 super 를 호출하기 전에는 this 를 참조할 수 없다.
3. super 는 반드시 서브클래스의 constructor 에서만 호출한다. (SyntaxError)
*/
```

+ 서브클래스의 프로토타입 메서드 내에서 선언한 super 는 수퍼클래스의 프로토타입 메서드를 가리킨다.

```javascript
class Base {
	constructor(name) {
		this.name = name;
	}

	sayHi() {
		return `Hi! ${this.name}`;
	}
}

class Derived extends Base {
	sayHi() {
		return `${super.sayHi()}. how are u?`;
	}
}

const derived = new Derived('Kim');
```

#### 25.8.6 상속 클래스의 인스턴스 생성 과정

+ 자바스크립트 엔진은 클래스를 평가할 때 수퍼와 서브를 구분하기 위해 내부 슬롯 [[ConstructorKind]] 를 갖고 'base', 'derived' 의 값을 갖는다. 다른 클래스를 상속받지 않는 클래스(수퍼)는 base, 다른 클래스를 상속받는 클래스(서브)는 derived 로 설정된다. 
+ 서브클래스의 super 호출 : 서브클래스가 new 연산자와 함께 호출되면 서브클래스 내부의 super 키워드가 함수처럼 호출된다. 자신이 직접 인스턴스를 생성하지 않고 수퍼클래스에게 인스턴스 생성을 위임한다. 수퍼클래스의 constructor 를 호출하는 super 가 호출되지 않으면 인스턴스를 생성할 수 없다.
+ 수퍼클래스의 인스턴스 생성과 this 바인딩 : 수퍼클래스의 constructor 내부의 코드가 실행되기 전에 암묵적으로 빈 객체를 생성하고 this 가 바인딩된다. 이때 인스턴스는 수퍼클래스가 생성했지만, new 연산자와 호출된 클래스는 서브클래스이므로 new.target 이 가리키는 함수는 서브클래스가 된다. 결국 생성된 인스턴스의 프로토타입은 수퍼클래스가 아닌 서브클래스의 prototype 프로퍼티가 가리키는 객체가 된다.
+ 수퍼클래스의 인스턴스 초기화 : this 에 바인딩 되어 있는 인스턴스에 프로퍼티를 추가하고 constructor 가 인수로 전달받은 초기값으로 인스턴스의 프로퍼티를 초기화한다.
+ 서브클래스 constructor 로의 복귀와 this 바인딩 : super 의 호출이 종료되고 서브클래스로 돌아와 super 가 반환한 인스턴스를 this 에 바인딩해 그대로 사용한다. super 가 호출되지 않으면 인스턴스가 생성되지 않고 this 바인딩도 할 수 없다. 서브클래스의 constructor 에서 super 를 호출하기 전에는 this 를 참조할 수 없다. super 호출 이후에 constructor 내부의 초기화를 진행하자!!!
+ 서브클래스의 인스턴스 초기화 : super 호출 이후, this 에 바인딩되어 있는 인스턴스에 프로퍼티를 추가하고 constructor 가 인수로 전달받은 초기값으로 인스턴스의 프로퍼티를 초기화한다.
+ 인스턴스 반환 : 클래스의 모든 처리가 끝나면 완성된 인스턴스가 바인딩된 this 가 암묵적으로 반환된다.

```javascript
class Rectangle {
	constructor(width, height) {
        
        console.log(this); // ColorRectangle {}
        console.log(new.target); // ColorRectangle
        
		this.width = width;
		this.height = height;
	}
	
	getArea() {
		return this.width * this.height;
	}
	
	toString() {
		return `width = ${this.width}, height = ${this.height}`;
	}
}

class ColorRectangle extends Rectangle {
	constructor(width, height, color) {
		super(width, height);
		this.color = color;
	}
	
    // 메서드 오버라이딩
	toString() {
		return super.toString() + `, color = ${this.color}`;
	}
}

const colorRectangle = new ColorRectangle(2, 4, 'red');

console.log(colorRectangle);
console.log(colorRectangle.getArea()); // 8
```

<br>

<br>

<br>

# 26장 ES6 함수의 추가 기능

### 26.1 함수의 구분

+ ES6 이전의 모든 함수는 callable 이면서 contructor 이다.
+ ES6 이전의 모든 함수는 사용 목적에 따라 명확한 구분이 없으므로 호출 방식에 특별한 제약이 없고 생성자 함수로 호출하지 않아도 프로토타입 객체를 생성한다. 이는 혼란스러우며 실수를 유발할 가능성이 있고 성능에도 좋지 않다.
+ 일반 함수는 함수 선언문이나 함수 표현식으로 정의한 함수 -> constructor
+ 메서드, 화살표 함수 -> non-constructor

<br>

### 26.2 메서드

+ ES6 사양에서 메서드는 메서드 축약 표현으로 정의된 함수만을 의미한다.
+ ES6 메서드는 인스턴스를 생성할 수 없으므로 prototype 프로퍼티가 없고 프로토타입도 생성하지 않는다.
+ ES6 메서드는 super 키워드를 사용할 수 있다. [[HomeObject]]
+ 본연의 기능을 추가하고 의미적으로 맞지 않는 기능은 제거했다. -> 메서드를 정의할 때는 메서드 축약 표현 사용!

```javascript
const obj = {
	x: 1,
	foo() { return this.x; },
	bar: function() { return this.x; }
};
```

<br>

### 26.3 화살표 함수

#### 26.3.1 화살표 함수 정의

+ 화살표 함수는 함수 표현식으로 정의해야 한다.
+ 매개변수가 여러 개인 경우 (), 매개변수가 한 개인 경우 생략, 매개변수가 없는 경우 ()만 사용
+ 함수 몸체 내부의 문이 값으로 평가될 수 있는 표현식인 문이라면 중괄호 생략 가능
+ 객체 리터럴을 반환하는 경우 객체 리터럴을 소괄호 () 로 감싸야 한다.
+ 콜백 함수로 정의할 때 유용

#### 26.3.2 화살표 함수와 일반 함수의 차이

+ 인스턴스를 생성할 수 없는 non-constructor 이기에 prototype 프로퍼티가 없고 프로토타입도 생성하지 않는다.
+ 중복된 매개변수 이름 사용시 SyntaxError 가 발생한다.
+ 함수 자체의 this, arguments, super, new.target 바인딩을 갖지 않는다. 참조하면 스코프 체인을 통해 상위 스코프만을 참조한다.

#### 26.3.3 this

+ 화살표 함수의 this 는 콜백 함수 내부의 this 문제를 해결하기 위해 의도적으로 다르게 설계되었다.
+ 콜백 함수 내부의 this 문제 : 외부 함수와 콜백 함수의 this 가 가리키는 값이 서로 다르다.
+ 클래스 내부의 모든 코드는 strict mode 가 암묵적으로 적용되고 strict mode 에서 일반 함수로서 호출된 모든 함수의 내부 this 는 undefined 가 바인딩된다.

```javascript
class Prefixer {
	constructor(prefix) {
		this.prefix = prefix;
	}
	
	add(arr) {
		return arr.map(function (item) {
			return this.prefix + item;
			// TypeError, map 메서드가 콜백 함수를 일반 함수로서 호출
		});
	}
}

const prefixer = new Prefixer('-webkit-');
console.log(prefixer.add(['transition', 'user-select']));

/*
1. 외부 함수의 this 는 메서드를 호출한 prefix 를 가리킨다.
2. 콜백 함수의 this 는 Array.prototype.map 메서드가 콜백 함수를 일반 함수로서 호출하기에 strict mode 가 암묵적으로 적용된 클래스 내에서는 전역 객체가 아니라 undefined 가 바인딩되므로 TypeError 가 발생한다.
*/
```

+ 해결 방법

```javascript
add(arr) {
	const that = this;
	return arr.map(function (item) {
		return this.prefix + item;
	});
}

add(arr) {
    return arr.map(function (item) {
        return this.prefix + item;
    }, this);
}

add(arr) {
    return arr.map(function (item) {
        return this.prefix + item;
    }.bind(this));
}

/*
1. this 를 that 변수로 회피시키고 that 을 참조한다.
2. Array.prototype.map 의 두번째 인수로 this 를 전달한다. (ES6에서 도입된 .map 메서드는 콜백 함수의 문제를 해결하기 위해 도입되었다.)
3. Function.prototype.bind 메서드를 사용해 바인딩한다.
```

+ 화살표 함수 등장!
+ 화살표 함수는 함수  자체의 this 바인딩을 갖지 않는다. 화살표 함수 내부에서 this 를 참조하면 상위 스코프의 this 를 그대로 참조한다. -> lexical this 렉시컬 스코프와 같이 화살표 함수의 this 가 함수가 정의된 위치에 의해 결정된다는 것이다.

```javascript
add(arr) {
	return arr.map(item => this.prefix + item);
}

// 매개변수가 한개라서 () 생략, 값으로 표현되는 표현식인 문이라서 {} 생략 오 ㅏ!
```

+ 함수 내부에서 this 를 참조하면 일반적인 식별자처럼 스코프체인을 통해 상위 스코프에서 this 를 탐색한다.

```javascript
const foo = () => console.log(this);
foo(); // window

// 상위 스코프는 전역이다.
```

+ 내부에서 메서드 정의 -> ES6 메서드
+ 외부에서 동적 추가 -> 일반 함수
+ 클래스 필드 내 메서드 정의 -> ES6 메서드

#### 26.3.4 super

+ 화살표 함수 내부에서 super 를 참조하면 this 와 마찬가지로 상위 스코프의 super 를 참조한다.

#### 26.3.5 arguments

+ arguments 객체는 매개변수의 개수를 확정할 수 없는 가변 인자 함수를 구현할 때 유용하다. 화살표 함수에서는 arguments 바인딩을 갖지 않고 객체를 사용할수 없기 때문에 자신에게 전달된 인수 목록을 확인할 수 없고 상위 함수에게 전달된 인수 목록을 참조하므로 도움이 되지 않는다!
+ Rest 파라미터를 사용해야 한다... 그냥 일반 함수 쓰면 안돼? 간편하군...

<br>

### 26.4 Rest 파라미터

#### 26.4.1 기본 문법

+ Rest 파라미터는 함수에 전달된 인수들의 목록을 배열로 전달받는다.
+ 매개변수 이름 앞에 세개의 점을 붙여서 정의한다.
+ Rest 파라미터에는 매개변수 기본값을 지정할 수 없다.

```javascript
function foo(...rest) {
	console.log(rest); // [1, 2, 3, 4, 5]
}

foo(1, 2, 3, 4, 5);


function foo(param, ...rest) {
	console.log(param); // 1
	console.log(rest); // [2, 3, 4, 5]
}

foo(1, 2, 3, 4, 5);


/*
1. 나머지 매개변수의 목록을 배열로 전달받는다.
2. 전달된 인수들은 매개변수와 Rest 파라미터에 순차적으로 할당된다.
3. 매개변수에 할당된 인수를 제외한 나머지 인수들로 구성된 배열이기에 반드시 마지막 파라미터여야 한다.
4. 단 하나만 선언할 수 있다.
5. length 프로퍼티에 영향을 주지 않는다.
*/
```

#### 26.4.2 Rest 파라미터와 arguments 객체

+ ES6 에서는 rest 파라미터를 이용해 가변 인자 함수의 인수 목록을 배열로 직접 전달받을 수 있다.
+ 화살표 함수로 가변 인자 함수를 구현해야 할 때는 반드시 Rest 파라미터를 사용해야 한다.

```javascript
function sum(...args) {
	return args.reduce((pre, cur) => pre + cur, 0);
}
console.log(sum(1,2,3,4,5)); // 15
```

<br>

### 26.5 매개변수 기본값

+ 함수를 호출할 때 매개변수의 개수만큼 인수를 전달하는 것이 바람직하지만 자바스크립트 엔진은 매개변수의 개수와 인수의 개수를 체크하지 않기 때문에 에러가 발생하지 않는다.
+ 인수가 전달되지 않은 매개변수의 값은 undefined 로 이를 방치하면 의도치 않은 결과가 나온다.

```javascript
function sum(x, y) {
	return x + y;
}

console.log(sum(1)); // NaN
```

+ ES6 에서 도입된 매개변수 기본값을 사용하면 함수 내에서 수행하던 인수 체크 및 초기화를 간소화할 수 있다.
+ 매개변수 기본값은 매개변수에 인수를 전달하지 않은 경우와 undefined 를 전달한 경우에만 유효하다.

```javascript
function sum(x = 0, y = 0) {
	return x + y;
}

console.log(sum(1,2)); // 3
console.log(sum(1)); // 1
console.log(sum()); // 0
console.log(sum(undefined)); // 0
console.log(sum(null)); // null
```

<br>

<br>

<br>

# 27장 배열

### 27.1 배열이란?

+ 배열 : 여러 개의 값을 순차적으로 나열한 자료구조, 객체 타입
+ 요소 : 배열이 가지고 있는 값, 원시값, 객체, 함수, 배열 등 자바스크립트에서 값으로 인정하는 모든 것이 가능
+ 배열은 인덱스와 length 프로퍼티를 갖기 때문에 for 문을 통해 순차적으로 요소에 접근할 수 있다.

<br>

### 27.2 자바스크립트 배열은 배열이 아니다

+ 일반적인 의미의 배열 : 각 요소가 동일한 데이터 크기를 가지며 빈틈없이 연속적으로 이어져 있으므로 인덱스를 통해 단 한번의 연산으로 임의의 요소에 접근할 수 있다. 이는 매우 효율적이고 고속으로 동작한다.
+ 자바스크립트의 배열 : 요소를 위한 각각의 메모리 공간은 동일한 크기를 갖지 않아도 되고, 연속적으로 이어져 있지 않을 수도 있다. (희소 배열)
+ 자바스크립트의 배열은 일반적인 배열의 동작을 흉내 낸 특수한 객체다. 인덱스를 나타내는 문자열을 프로퍼티 키로, 배열의 요소를 프로퍼티 값으로 가진다. 
+ 일반적인 배열은 인덱스로 요소에 빠르게 접근 가능하지만 요소를 삽입/삭제 하는 경우에는 효율적이지 않다.
+ 자바스크립트의 배열은 해시 테이블로 구현된 객체이므로 인덱스로 접근하는 경우 성능적인 면에서 느릴수 밖에 없는 구조적인 단점이 있지만 요소를 삽입/삭제하는 경우에는 일반적인 배열보다 빠르다!

<br>

### 27.3 length 프로퍼티와 희소 배열

+ length 프로퍼티의 값은 0~2^32-1 (4,294,967,296-1) 미만의 양의 정수다.
+ length 프로퍼티의 값은 배열에 요소를 추가하거나 삭제하면 자동 갱신된다.

```javascript
const arr = [1,2,3];
console.log(arr.length); // 3

arr.push(4);
console.log(arr.length); // 4

arr.pop();
console.log(arr.length); // 3
```

+ 현재 length 프로퍼티 값보다 작은 값을 할당하면 배열의 길이가 줄어든다.

```javascript
const arr = [1,2,3,4,5];

arr.length = 3;

console.log(arr); // [1,2,3]
```

+ 현재 length 프로퍼티 값보다 큰 값을 할당하면 값은 변경되지만 실제로 늘어나지는 않는다.
+ 자바스크립트는 희소 배열을 문법적으로 허용하지만 배열의 기본적인 개념인 연속적인 값의 집합에 맞지 않으며 성능에도 안 좋은 영향을 준다.

```javascript
const arr = [1];
arr.length = 3;
console.log(arr.length); // 3
console.log(arr); // [1, empty*2]

// 값 없이 비어 있는 요소를 위해 메모리 공간을 확보하지 않으며 빈 요소를 생성하지도 않는다.
```

<br>

### 27.4 배열 생성

#### 27.4.1 배열 리터럴

+ 0개 이상의 요소를 쉼표로 구분해 대괄호로 묶는다.

```javascript
const arr = [1,2,3];
console.log(arr.length); // 3

const arr = [1, ,3];
console.log(arr.length); // 3
console.log(arr); // [1, empty, 3]
console.log(arr[1]); // undefined

// 객체 arr 에 프로퍼티 키가 [1] 인 프로퍼티는 존재하지 않기 때문에 undefined 다.
```

#### 27.4.2 Array 생성자 함수

+ Array 생성자 함수는 전달된 인수의 개수에 따라 다르게 동작한다.
+ Array 생성자 함수는 new 연산자와 함께 호출하지 않더라도 배열을 생성하는 생성자 함수로 동작한다. 함수 내부에서 new.target 을 확인한다.

```javascript
// 1) 전달된 인수가 1개이고 숫자인 경우 -> 값이 없는 length 가 10 인 배열 생성
const arr = new Array(10);
console.log(arr); // [empty * 10]
console.log(arr.length); // 10

new Array(4294967296); // RangeError
new Array(-1); // RangeError

// 2) 전달된 인수가 없는 경우 빈 배열 생성
new Array(); // []

// 3) 전달된 인수가 2개 이상이거나 숫자가 아닌 경우 인수를 요소로 갖는 배열 생성
new Array(1,2,3); // [1,2,3]
new Array({}); // [{}]
```

#### 27.4.3 Array.of

+ 전달된 인수를 요소로 갖는 배열을 생성

```javascript
// 전달된 인수가 1개이고 숫자더라도 인수를 요소로 갖는 배열 생성
Array.of(1); // [1]
Array.of(1,2,3); // [1,2,3]
Array.of('string'); // ['string']
```

#### 27.4.4 Array.from

+ 유사 배열 객체 또는 이터러블 객체를 인수로 전달받아 배열로 변환

```javascript
Array.from({length:2, 0:'a', 1:'b'}); // ['a','b']
Array.from('Hello'); // ['H','e','l','l','o']

// 두번째 인수로 전달한 콜백 함수를 통해 값을 만들면서 요소를 채울 수 있다.
Array.from({length:3}); // [undefined,undefined,undefined]
Array.from({length:3}, (_,i) => i); // [0,1,2]
```

<br>

### 27.5 배열 요소의 참조

+ 배열의 요소를 참조할 때는 대괄호 표기법을 사용한다. 정수로 평가되는 표현식이라면 인덱스 대신 사용할 수 있다.

```javascript
const arr = [1,2];

console.log(arr[0]); // 1
console.log(arr[3]); // undefined
```

<br>

### 27.6 배열 요소의 추가와 갱신

+ 배열에도 요소를 동적으로 추가할 수 있다.

```javascript
const arr = [0];

arr[1] = 1;
console.log(arr); // [0,1]

arr[100] = 100;
console.log(arr); // [0,1, empty*98, 100]

arr[1] = 10;
console.log(arr); // [0,10, empty*98, 100]

/*
1) 존재하지 않는 인덱스를 사용해 값을 할당하면 새로운 요소가 추가되고 length 프로퍼티 값은 자동 갱신된다.
2) 현재 배열의 length 프로퍼티 값보다 큰 인덱스로 새로운 요소를 추가하면 희소 배열이 된다.
3) 이미 요소가 존재하는 요소에 값을 재할당하면 값이 갱신된다.
```

+ 인덱스는 반드시 0 이상의 정수 또는 정수 형태의 문자열을 사용해야 한다. 그렇지 않으면 프로퍼티가 생성된다. length 프로퍼티 값에도 영향을 주지 않는다.

```javascript
const arr = [];

arr[0] = 1;
arr['1'] = 2;

arr['foo'] = 3;
arr.bar = 4;
arr[1.1] = 5;
arr[-1] = 6;

console.log(arr); // [1,2, foo:3, bar:4, '1.1':5, '-1':6]
console.log(arr.length); // 2
```

<br>

### 27.7 배열 요소의 삭제

+ delete 연산자로 삭제가 가능하지만, 희소 배열이 되어 좋지 않으므로 Array.prototype.splice 메서드를 사용한다.

```javascript
const arr = [1,2,3];

delete arr[1];
console.log(arr); // [1, empty, 3]
console.log(arr.length); // 3

const arr = [1,2,3]

arr.splice(1,1);
console.log(arr); // [1,3]
console.log(arr.length); // 2

// Array.prototype.splice(삭제를 시작할 인덱스, 삭제할 요소 수)
```

<br>

### 27.8 배열 메서드



















