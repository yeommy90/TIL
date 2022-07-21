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











