## Git

+ Version Control System
+ 시간 : 이미 지나간 버전 관리
+ 차원 : 서로 다른 프로젝트



## Git 설치

+ git 버전 확인

```
git --version

git config --global core.autocrlf true
```

+ Git GUI Tool - SourceTree 설치
  - github desktop 은 기능이 많이 없어서 비추

+ VS Code 설치
  - ctrl + ` 터미널 열기
  - ctrl + shift + p -> Select Default Profile -> Git Bash 선택
  - 리눅스 명령어 사용 가능



## CLI vs GUI

+ 공부는 CLI 로 하자!



## Git 설정

+ 사용자 이름과 이메일 주소 설정

```
git config --global user.name "(이름)"

git config --global user.email "(이메일)"
```

+ 기존 브랜치명 변경

```
git config --global init.defaultBranch main
```



## Git 프로젝트 생성

+ git-practice 폴더 생성
+ vs code 터미널에서 명령 실행 (.git 파일을 지우면 git 관리 내역이 삭제되어 돌아갈 수 없음)

```
git init
```

+ 현재 상태 보기

```
git status
```



## Git 에게 맡기지 않을 것들

+ 포함할 필요가 없을 때 - 자동으로 생성, 다운로드 되는 파일들
+ 포함하지 말아야 할 때 - 보안에 민감한 정보를 담은 파일

```
1) vs code 내에 .gitignore 파일 생성
2) 보안이 필요한 파일명 작성
3) git 상태를 확인하면 .gitignore 에 있는 파일 빼고 목록 나열
```

+ .gitignore 형식
  - *.확장자명
  - 폴더명/파일명.확장자명
  - 폴더명/**/파일명.확장자명



## Git 버전 만들기

+ git 파일 담기

```
git add .
```

+ git 버전 만들기

```
git commit -m "변경 내용"
```

+ git 변경사항 확인

```
git log
```

+ vim 모드 : 직접 입력 모드

  - 입력 시작 : i
  - 입력 종료 : esc
  - 저장하고 종료 : :wq
  - 저장없이 종료 : :q

  

## Git 변경사항 버전 만들기

+ 파일 삭제/파일 변경/파일 추가 등 작업

```
git status

git diff (j, k, :q 사용)

git add .

git commit -m "변경 내용"
```

+ 새로 추가된 파일이 없을 때

```
git commit -am "변경 내용"
```



## Git 이전 버전 돌아가기

+ reset : 원하는 시점으로 돌아간 후 이후 내역을 지움
+ revert : 되돌리기 원하는 시점의 커밋을 거꾸로 실행





















