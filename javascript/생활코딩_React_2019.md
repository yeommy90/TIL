# 생활코딩 - React

### React 개발 환경 구축

+ cmd 실행

  ```react
  node.js 설치
  npm install -g create-react-app
  react-app directory 만들기
  cd /경로
  create-react-app . // 현재 폴더를 root로
  npm run start / ctrl+c
  ```

  ```jsx
  node.js 설치
  react-app directory 만들기
  npx create-react-app . // 현재 폴더를 root로
  npm start
  ```

+ src > App.js

  ```javascript
  import React, { Component } from 'react';
  
  class App extends Component {
  	render() {
  		return (
  			<div className="App">
              	Hello, React!!!!
  			</div>
  		);
  	}
  }
  ```

+ App.css index.css 삭제

+ 배포하기

  ```jsx
  npm run build
  npx serve -s build // 사용자가 어떤 경로로 들어오더라도 index.html 을 서비스함
  ```


<br>

<br>

### React Component 만들기

+ 태그의 속성을 이용해 효율적인 컴포넌트 제작 가능

```jsx
// Subject.js
class Subject extends Component {
	render() {
		return (
			<header>
        		<h1>{this.props.title}</h1>
        		{this.props.sub}
    		</header>
            <header>
        		<h1>WEB</h1>
        		world wide web!!!
    		</header> // 태그의 속성을 사용해 간단하게 제작
		);
	}
}


// App.js
class App extends Component {
    render() {
        return (
        	<div className="App">
            	<Subject title="WEB" sub="world wide web!!!"></Subject>
            </div>
        );
    }
}
```

<br>

<br>

### React Component 분리하기

```jsx
import React, { Component } from 'react';

class TOC extends Component {
  render() {
    return (
      <nav>
        <ul>
          <li><a href="1.html">HTML</a></li>
          <li><a href="2.html">CSS</a></li>
          <li><a href="3.html">JavaScript</a></li>
        </ul>
      </nav>
    );
  }
}

export default TOC;

```

<br>

<br>

### React State

+ State : 개발자 입장에서 Component 를 이루는 중요한 요소
+ Component 가 실행될 때 render() 함수보다 먼저 실행되서 초기화 시켜 줄 코드를 constructor() 함수 내부에 작성
+ 외부에서 알 필요가 없는 정보를 은닉
+ props 나 state 가 바뀌면 render() 함수가 다시 실행되고 다시 로딩된다.

```jsx
class App extends Component {
  constructor(props){
    super(props);
    this.state = {
      Subject:{title:'WEB', sub:'world wide web!!!'},
      contents:[
        {id:1, title:'HTML', desc:'HTML is for information'},
        {id:2, title:'CSS', desc:'CSS is for design'},
        {id:3, title:'JavaScript', desc:'JavaScript is for interactive'}
      ]
    }
  }
  render() {
    return (
      <div className="App">
        <Subject
          title={this.state.Subject.title}
          sub={this.state.Subject.sub}>
        </Subject>
        <TOC data={this.state.contents}></TOC>
        <Content title="HTML" desc="HTML is HyperText Markup Language."></Content>
      </div>
    );
  }
}
```

```jsx
class TOC extends Component {
  render() {
    var lists = [];
    var data = this.props.data;
    var i = 0;
    while(i < data.length){
      lists.push(<li><a href={"/content/"+data[i].id}>{data[i].title}</a></li>);
      i = i + 1;
    }
    return (
      <nav>
        <ul>
          {lists}
        </ul>
      </nav>
    );
  }
}
```

<br>

<br>

### React State Event

+ 동적 페이지 생성

```jsx
class App extends Component {
  constructor(props){
    super(props);
    this.state = {
      mode:'welcome',
      Subject:{title:'WEB', sub:'world wide web!!!'},
      welcome:{title:'Welcome', desc:'Hello, React@__@'},
      contents:[
        {id:1, title:'HTML', desc:'HTML is for information'},
        {id:2, title:'CSS', desc:'CSS is for design'},
        {id:3, title:'JavaScript', desc:'JavaScript is for interactive'}
      ]
    }
  }
  render() {
    var _title, _desc = null;
    if(this.state.mode === 'welcome'){
      _title = this.state.welcome.title;
      _desc = this.state.welcome.desc;
    } else if(this.state.mode === 'read'){
      _title = this.state.contents[0].title;
      _desc = this.state.contents[0].desc;
    }
    return (
      <div className="App">
        <Subject
          title={this.state.Subject.title}
          sub={this.state.Subject.sub}>
        </Subject>
        <TOC data={this.state.contents}></TOC>
        <Content title={_title} desc={_desc}></Content>
      </div>
    );
  }
}
```

+ 리로딩 없이 웹 페이지 만들기

```jsx
<header>
	<h1><a href="/" onClick={function(e){
		console.log(e);
		e.preventDefault(); // 현재 태그의 기본값을 막음 -> 리로딩 금지
		this.setState({
            mode:'welcome'
        }); 
		}.bind(this)}>{this.state.Subject.title}</a></h1>
	{this.state.Subject.sub}
</header>

// 함수 내의 this 는 undefined 되어 있으므로 함수 바깥에 .bind(this) 함수 사용하기
// a 태그의 기본값은 리로딩이므로 e.preventDefault() 함수 사용하기
// state 를 선언한 컨스트럭트 바깥에서 state 의 값을 변경할 때는 this.state.mode = 'welcome' 가 아닌 this.setState() 함수 사용하기,,, 리액트 입장에서는 바뀐줄 몰라용
```

+ 이벤트를 직접 만들기

```jsx
<Subject
	title={this.state.Subject.title}
	sub={this.state.Subject.sub}
	onChangePage={function(){
		this.setState({
			mode:'welcome'
		});
	}.bind(this)}  
>
</Subject>

// Subject.js
class Subject extends Component {
  render() {
    return (
      <header>
        <h1><a href="/" onClick={function(e){
          e.preventDefault();
          this.props.onChangePage();
        }.bind(this)}>{this.props.title}</a></h1>
        {this.props.sub}
      </header>
    );
  }
}

// 이벤트를 실행하는 함수인 onChangePage() 를 만들고 그 함수를 this.props.onChangePage() 함수로 사용하기
```

+ State 에 선택한 객체의 id 값을 추가해 내용을 변경하는 함수 만들기

```jsx
selected_content_id: 2, // 기본값 생성

render() {
    var _title, _desc = null;
    if(this.state.mode === 'welcome'){
      _title = this.state.welcome.title;
      _desc = this.state.welcome.desc;
    } else if(this.state.mode === 'read'){
      var i = 0;
      while(i < this.state.contents.length){
        var data = this.state.contents[i];
        if(data.id === this.state.selected_content_id) {
          _title = data.title;
          _desc = data.desc;
          break;
        }
        i = i + 1;
      }
    }
    return (
      <div className="App">
        <TOC 
          onChangePage={function(id){
            this.setState({
              mode:'read',
              selected_content_id: Number(id)
            });
          }.bind(this)}
          data={this.state.contents}>
        </TOC>
        <Content title={_title} desc={_desc}></Content>
      </div>
    );
  }

// TOC.js
while(i < data.length){
      lists.push(
      <li key={data[i].id}>
        <a 
        href={"/content/"+data[i].id}
        data-id={data[i].id}
        onClick={function(e){
          e.preventDefault();
          this.props.onChangePage(e.target.dataset.id);
        }.bind(this)}
        >{data[i].title}</a>
      </li>);
      i = i + 1;
}

// e.target 은 이벤트가 발생한 a 태그를 가리키고 dataset 은 data- 접두사로 시작하는 속성, id 는 data-id 의 id 를 가리킨다.
// 선택한 객체의 id 값을 인수로 저장해놓고 실행
```

+ 상위 -> 하위 컴포넌트는 props 로 전달
+ 하위 -> 상위 컴포넌트는 하위 컴포넌트에서 event 로 상위 컴포넌트의 state 를 호출, state 값 수정

<br>

<br>

### React Create

+ Control 컴포넌트 생성 후 CRUD 를 각각 onClick event 로 생성
+ App.js 파일 내 Control 컴포넌트에서는 onChangeMode 사용

```jsx
<Control onChangeMode={function(_mode){
   this.setState({
      mode:_mode
   });
}.bind(this)}></Control>
```

+ onSubmit : HTML 태그가 가지고 있는 고유 기능, submit 버튼 누를 때 발생하는 이벤트

```jsx
<form action="/create_process" method="POST"
	onSubmit={function(e){
		e.preventDefault();
		this.props.onSubmit(
            e.target.title.value,
            e.target.desc.value)
	}.bind(this)}
>

// submit 이벤트 발생 시 폼태그 내의 title 과 desc 가 저장되는 곳은 e.target.title(desc).value
```

+ push 는 원본을 바꾸고 concat 은 원본을 변경한 새로운 변수가 생성됨, 성능 개선시 매우 어려움

```jsx
else if(this.state.mode === 'create'){
	_article = <CreateContent onSubmit={function(_title, _desc){
	// add content to this.state.contents
	this.max_content_id += 1;
	var _contents = this.state.contents.concat(
		{id:this.max_content_id, title:_title, desc:_desc}
	);
	this.setState({
		contents:_contents
	});
}.bind(this)}></CreateContent>

// max_content_id 는 ui 에 필요없는 정보이기에 this.state 에 저장하지 않고 바깥에서 객체로 선언
```

+ shouldComponentUpdate() 함수 : TOC 목록의 변화가 없음에도 render() 함수가 실행되는 것은 비합리적, true 일 때 render() 함수 실행, false 일 때 render() 함수 실행되지 않음

```jsx
shouldComponentUpdate(newProps, newState){
	if (this.props.data === newProps.data) {
		return false; // 현재 데이터와 새로운 데이터가 같을 경우, render 함수 실행되지 않음
	}
	return true; // 현재 데이터와 새로운 데이터가 다를 경우, render 함수 실행
}
```

+ Array.from(a) : 새로운 배열을 만들고 복제할 때 사용
+ Object.assign({}, a) : 새로운 객체를 만들고 복제할 때 사용

```jsx
var newContents = Array.from(this.state.contents);
newContens.push(
	{id:this.max_content_id, title:_title, desc:_desc}
);
this.setState({
	contents:newContents
});

var a = {name:"seoyoung"};
var b = Object.assign({}, a);
console.log(a, b, a===b); // {name:"seoyoung"}, {name:"seoyoung"}, false
```

+ 원본의 변형과 교체를 잘 구분합시다.

<br>

<br>

### React Update

+ UpdateContent 내의 data 로 현재 선택된 content 의 값을 불러옴

```jsx
else if(this.state.mode === 'update'){
	_content = this.getReadContent();
	_article = <UpdateContent data={_content} onSubmit={function(_title, _desc){
	// add content to this.state.contents
	this.max_content_id += 1;
	var _contents = this.state.contents.concat(
		{id:this.max_content_id, title:_title, desc:_desc}
	);
	this.setState({
		contents:_contents
	});
}.bind(this)}></UpdateContent>
}
```

+ UpdateContent 컴포넌트 내에서 각 input 에 title 과 desc 의 값을 불러옴

```jsx
constructor(props){
    super(props);
    this.state = {
      title:this.props.data.title,
      desc:this.props.data.desc
    }
    this.inputFormHandler = this.inputFormHandler.bind(this);
  }
  inputFormHandler(e){
    this.setState({[e.target.name]:e.target.value});
  }

<p>
	<input 
		type="text" 
		name="title" 
		placeholder='title'
		value={this.state.title} // props 는 read only 이기 때문에 state 로 받아야 함
		onChange={this.inputFormHandler}
        /* onChange={function(e){
            this.setState({title:e.target.value});
        }.bind(this)} */
	></input>
</p>
<textarea 
	name="desc" 
	placeholder='description'
	value={this.state.desc}
	onChange={this.inputFormHandler}
></textarea>
```

+ Form 에 hidden 타입을 가진 input 을 추가하고 state 에 id 값도 추가

```jsx
<input type="hidden" name="id" value={this.state.id}></input>
```

+ Array.from 으로 복제 후 선택된 id 값에 맞는 contents 를 수정

```jsx
else if(this.state.mode === 'update'){
      _content = this.getReadContent();
      _article = <UpdateContent data={_content} onSubmit={
        function(_id, _title, _desc){
          var _contents = Array.from(this.state.contents);
          var i = 0;
          while(i < _contents.length){
            if(_contents[i].id === _id) {
              _contents[i] = {id:_id, title:_title, desc:_desc};
              break;
            }
            i = i + 1;
          }
        this.setState({
          contents:_contents,
          mode:'read'
        });
      }.bind(this)}></UpdateContent>
    }
```

<br>

<br>

### React Delete

+ 
