# 생활코딩 - React

### React 개발 환경 구축

+ cmd 실행

  ```react
  node.js 설치
  npm install -g create-react-app
  react-app directory 만들기
  cd /경로
  create-react-app . // 현재 폴더를 root로
  ```

+ visual studio code 실행

  ```
  npm run start / ctrl+c
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

  ```
  npm run build
  npm install -g serve
  npx serve -s build
  ```


<br>

<br>

### React Component 만들기

+ 태그의 속성을 이용해 효율적인 컴포넌트 제작 가능

```jsx
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





