# 생활코딩 - React

### React 개발 환경 구축

+ cmd 실행

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

```jsx
// App.js

import './App.css';

function Header() {
  return <header>
    <h1><a href="/">WEB</a></h1>
  </header>
}

function Nav() {
  return <nav>
   <ol>
      <li><a href="/read/1">HTML</a></li>
      <li><a href="/read/2">CSS</a></li>
      <li><a href="/read/3">JavaScript</a></li>
   </ol>
   </nav>
}

function Article() {
  return <article>
    <h2>Welcome</h2>
    안뇽안뇽 나는 WEB 이야!
  </article>
}

function App() {
  return (
    <div>
      <Header></Header>
      <Nav></Nav>
      <Article></Article>
    </div>
  );
}

export default App;
```

<br>

<br>

### React props 만들기

+ Props : 상위 컴포넌트에서 하위 컴포넌트로 값을 전달할 때 사용, Read-only
+ State : 개발자를 위한 데이터
+ 컴포넌트를 다시 실행시킬 때 props 와 state 를 사용
+ 동적으로 변화하는 컴포넌트 만들기

+ key : 자동으로 생성한 태그를 추적할 때 근거를 만들기 위해 사용

```jsx
function Nav(props) {
  const lis = [];
  for(let i=0; i<props.topics.length; i++){
    let t = props.topics[i];
    lis.push(<li key={t.id}><a href={"/read/"+t.id}>{t.title}</a></li>)
  }
  return <nav>
   <ol>
      {lis}
   </ol>
   </nav>
}

function Article(props) {
  return <article>
    <h2>{props.title}</h2>
    {props.body}
  </article>
}

function App() {
  const topics = [
    {id:1, title:'HTML', body:'HTML is ...'},
    {id:2, title:'CSS', body:'CSS is ...'},
    {id:3, title:'JavaScript', body:'JavaScript is ...'}
  ]
  return (
    <div>
      <Header title="WEB"></Header>
      <Nav topics={topics}></Nav>
      <Article title="Welcome" body="안녕안녕 나는 WEB 이야!"></Article>
    </div>
  );
}

export default App;
```

<br>

<br>

### React Event 만들기

+ event.preventDefault(); : 페이지 리로딩 금지
+ 화살표 함수 : function() 을 ()=> 으로 변경

```jsx
function Header(props) {
  return <header>
    <h1><a href="/" onClick={(event)=>{
      event.preventDefault();
      props.onChangeMode();
    }}>{props.title}</a></h1>
  </header>
}

function App() {
  const topics = [
    {id:1, title:'HTML', body:'HTML is ...'},
    {id:2, title:'CSS', body:'CSS is ...'},
    {id:3, title:'JavaScript', body:'JavaScript is ...'}
  ]
  return (
    <div>
      <Header title="WEB" onChangeMode={()=>{
        alert("헤더에요오옹");
      }}></Header>
      <Nav topics={topics}></Nav>
      <Article title="Welcome" body="안녕안녕 나는 WEB 이야!"></Article>
    </div>
  );
}
```

+ 목록을 클릭하면 id 값을 띄우기

```jsx
function Nav(props) {
  const lis = [];
  for(let i=0; i<props.topics.length; i++){
    let t = props.topics[i];
    lis.push(<li key={t.id}>
      <a id={t.id} href={"/read/"+t.id} onClick={(event)=>{
        event.preventDefault();
        props.onChangeMode(event.target.id); // 선택된 목록의 id 값을 가져옴
      }}>{t.title}</a>
    </li>)
  }
  return <nav>
   <ol>
    {lis}
   </ol>
   </nav>
}

function App() {
  const topics = [
    {id:1, title:'HTML', body:'HTML is ...'},
    {id:2, title:'CSS', body:'CSS is ...'},
    {id:3, title:'JavaScript', body:'JavaScript is ...'}
  ]
  return (
    <div>
      <Header title="WEB" onChangeMode={()=>{
        alert("헤더에요오옹");
      }}></Header>
      <Nav topics={topics} onChangeMode={(id)=>{
        alert(id); // 선택된 목록의 값을 인수 id 로 가져옴
      }}></Nav>
      <Article title="Welcome" body="안녕안녕 나는 WEB 이야!"></Article>
    </div>
  );
}
```

<br>

<br>

### React State 만들기

+ state : 개발자를 위한 내부의 값
+ state 를 사용하지 않으면 값이 변경되어도 재실행되지 않음
+ {useState} hook 사용
+ 목록을 누를 때마다 모드를 변경하고 그 모드에 맞는 title 과 body 를 출력하기

```jsx
import {useState} from 'react';

function App() {
  // const _mode = useState('WELCOME');
  // const mode = _mode[0]; 0번째 값은 초기값, 이름 상관 없음
  // const setMode = _mode[1]; 1번째 값은 변경되는 값을 저장, 이름 상관 없음
  const [mode, setMode] = useState('WELCOME');
  const topics = [
    {id:1, title:'HTML', body:'HTML is ...'},
    {id:2, title:'CSS', body:'CSS is ...'},
    {id:3, title:'JavaScript', body:'JavaScript is ...'}
  ]
  let content = null;
  if(mode === 'WELCOME'){
    content = <Article title="Welcome" body="안녕안녕 나는 WEB 이야!"></Article>
  } else if(mode === 'READ') {
    content = <Article title="Read" body="안녕안녕 나는 Read 야!"></Article>
  }
  return (
    <div>
      <Header title="WEB" onChangeMode={()=>{
        setMode('WELCOME'); // 변경 후 재실행
      }}></Header>
      <Nav topics={topics} onChangeMode={(id)=>{
        setMode('READ'); // 변경 후 재실행
      }}></Nav>
      {content}
    </div>
  );
}
```

+ 모드가 'READ' 일 때, 각 id 값에 맞는 title 과 body 를 출력하기

```jsx
function Nav(props) {
  const lis = [];
  for(let i=0; i<props.topics.length; i++){
    let t = props.topics[i];
    lis.push(<li key={t.id}>
      <a id={t.id} href={"/read/"+t.id} onClick={(event)=>{
        event.preventDefault();
        props.onChangeMode(Number(event.target.id)); // 태그 내에서 받아온 값은 문자열 저장됨
      }}>{t.title}</a>
    </li>)
  }
  return <nav>
   <ol>
    {lis}
   </ol>
   </nav>
}

function App() {
  const [mode, setMode] = useState('WELCOME');
  const [id, setId] = useState(null);
  const topics = [
    {id:1, title:'HTML', body:'HTML is ...'},
    {id:2, title:'CSS', body:'CSS is ...'},
    {id:3, title:'JavaScript', body:'JavaScript is ...'}
  ]
  let content = null;
  if(mode === 'WELCOME'){
    content = <Article title="Welcome" body="안녕안녕 나는 WEB 이야!"></Article>
  } else if(mode === 'READ'){
    let title, body = null;
    for(let i=0; i<topics.length; i++){
      if(topics[i].id === id){
        title = topics[i].title;
        body = topics[i].body;
      }
    }
    content = <Article title={title} body={body}></Article>
  }
  return (
    <div>
      <Header title="WEB" onChangeMode={()=>{
        setMode('WELCOME');
      }}></Header>
      <Nav topics={topics} onChangeMode={(_id)=>{
        setMode('READ');
        setId(_id);
      }}></Nav>
      {content}
    </div>
  );
}

```

















