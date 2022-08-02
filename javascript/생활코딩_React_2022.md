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

+ key : 자동으로 생성한 태그를 추적할 때 근거를 만들기 위해 사용, 리액트에게 약속된 prop 을 부여함으로써 원활하게 돌아가게 함

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

// topics 를 App 내에 만드는 이유 : 공통된 부분을 Nav 에 넣고 자주 바뀔 수 있는 topics 데이터는 App 내에 만든다. 바뀌지 않는다면 Nav 에 넣어도 된다.
```

<br>

<br>

### React Event 만들기

+ event.preventDefault(); : 페이지 리로딩 금지
+ 화살표 함수 : function() 을 ()=> 으로 변경
+ Header 에 onClick 이 발생하면 onChangeMode 로 알람을 띄운다.

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

+ 목록을 클릭하면 각 id 값을 알람으로 띄우기

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
  // const mode = _mode[0]; 0번째 인수는 초기값, 이름 상관 없음
  // const setMode = _mode[1]; 1번째 인수는 값이 변경되는 함수, 이름 상관 없음
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

<br>

<br>

### React CREATE

+ usetState : 객체나 배열을 추가할 때에는 기존 값을 복제한 변수를 만들고 그 변수에 값을 추가한다.

+ onClick 시 mode 가 CREATE 인 컴포넌트 생성
+ Create 컴포넌트에는 기본 form, input, submit 태그를 사용
+ form 태그의 onSubmit 에 onCreate 함수를 props  로 전달해 title 과 body 로 값을 전달받는다.

```jsx
function Create(props) {
  return <article>
    <h2>Create</h2>
    <form onSubmit={(event)=>{
      event.preventDefault();
      const title = event.target.title.value;
      const body = event.target.body.value;
      props.onCreate(title, body);
    }}>
      <p><input type="text" name="title" placeholder="title"></input></p>
      <p><textarea name="body" placeholder="body"></textarea></p>
      <p><input type="submit" value="Create"></input></p>
    </form>
  </article>
}

else if(mode === 'CREATE'){
    content = <Create onCreate={(title, body)=>{
         
    }}></Create>
}

<a href="/create" onClick={(event)=>{
	event.preventDefault();
	setMode('CREATE');
}}>Create</a>
```

+ 전달받은 title, body 에 id 를 추가해 newTopic 을 만든다.
+ 기존 topics 에 newTopic 을 추가하는 setTopics 를 만들고 useState 로 변환한다.
+ onCreate 후 setMode, setId, setNextId 를 변경한다.

```jsx
function App() {
  const [mode, setMode] = useState('WELCOME');
  const [id, setId] = useState(null);
  const [nextId, setNextId] = useState(4);
  const [topics, setTopics] = useState([
    {id:1, title:'html', body:'html is ...'},
    {id:2, title:'css', body:'css is ...'},
    {id:3, title:'javascript', body:'javascript is ...'}
  ]);
  
else if(mode === 'CREATE'){
    content = <Create onCreate={(title, body)=>{
      const newTopic = {id:nextId, title:title, body:body};
      const newTopics = [...topics];
      newTopics.push(newTopic);
      setTopics(newTopics);
      setMode('READ');
      setId(nextId);
      setNextId(nextId+1);
    }}></Create>
  }
```

<br>

<br>

### React UPDATE

+ 모드가 READ 일 때만 보이고 onClick 시 모드가 UPDATE 로 바뀌는 Update 컴포넌트를 만든다.
+ 모드가 UPDATE 일 때, 선택된 title 과 body 를 기본값으로 가져오고 onUpdate 시 변경할 함수를 만든다.

```jsx
contextControl = <li><a href={"/update/"+id} onClick={event=>{
      event.preventDefault();
      setMode('UPDATE');
    }}>Update</a></li>
    
else if(mode === 'UPDATE'){
    let title, body = null;
    for(let i = 0; i<topics.length; i++){
      if(topics[i].id === id){
        title = topics[i].title;
        body = topics[i].body;
      } 
    }
    content = <Update title={title} body={body} onUpdate={(title, body)=>{

    }}></Update>

<ul>
	<li><a href="/create" onClick={(event)=>{
	event.preventDefault();
	setMode('CREATE');
	}}>Create</a></li>
	{contextControl}
</ul>
```

+ props 로 가져온 title 과 body 는 Read-Only 이므로 useState 로 변환해 사용한다.	
+ 폼이 onChange 되면 setTitle 을 현재 value 로 변경한다.

```jsx
function Update(props) {
  const [title, setTitle] = useState(props.title);
  const [body, setBody] = useState(props.body);
  return <article>
    <h2>Update</h2>
    <form onSubmit={(event)=>{
      event.preventDefault();
      const title = event.target.title.value;
      const body = event.target.body.value;
      props.onUpdate(title, body);
    }}>
      <p><input type="text" name="title" placeholder="title" value={title} 
      onChange={event=>{
        setTitle(event.target.value);
      }}></input></p>
      <p><textarea name="body" placeholder="body" value={body} onChange={event=>{
        setBody(event.target.value);
      }}></textarea></p>
      <p><input type="submit" value="Update"></input></p>
    </form>
  </article>
}
```

+ onSubmit -> onUpdate 될 때, updatedTopic 에 변경된 title 과 body 를 저장한다.
+ topics 는 배열이므로 newTopics 변수를 만들어 배열을 저장한다.
+ 현재 id 와 newTopics 의 id 가 같을 때, updatedTopic 으로 변경한다.

```jsx
else if(mode === 'UPDATE'){
    let title, body = null;
    for(let i = 0; i<topics.length; i++){
      if(topics[i].id === id){
        title = topics[i].title;
        body = topics[i].body;
      } 
    }
    content = <Update title={title} body={body} onUpdate={(title, body)=>{
      const newTopics = [...topics];
      const updatedTopic = {id:id, title:title, body:body};
      for(let i=0; i<newTopics.length; i++){
        if(newTopics[i].id === id){
          newTopics[i] = updatedTopic;
          break;
        }
      }
      setTopics(newTopics);
      setMode('READ');
    }}></Update>
  }
```

<br>

<br>

### React DELETE

+ <></> 빈 태그를 사용한다.
+ READ 모드에서 바로 삭제할 것이므로 contextControl 변수에 추가한다.

```jsx
contextControl = <>
      <li><a href={"/update/"+id} onClick={event=>{
        event.preventDefault();
        setMode('UPDATE');
      }}>Update</a></li>
      <li><input type="button" value="Delete" onClick={()=>{
        const newTopics = [];
        for(let i=0; i<topics.length; i++){
          if(topics[i].id !== id){
            newTopics.push(topics[i]);
          }
        }
        setTopics(newTopics);
        setMode('WELCOME');
      }}></input></li>
    </>
```





