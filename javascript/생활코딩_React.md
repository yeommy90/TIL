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

  