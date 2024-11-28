# 🚔 5NTeam 

## <img src="https://github.com/user-attachments/assets/d8170c2c-8429-4464-a4ce-6553d13f7649" width="40"> Introduction to the Project

![iMacDoanld PPL 001](https://github.com/user-attachments/assets/053d8eec-c163-4adf-b6aa-de25665c737d)

**Project Topic**: 한 페이지 안에 모바일 키오스크 구현하기

**Project Name**: iMacDonald

**Project Period**: 11/25 ~ 11/29 12:00

**Wire Frame**: 🔗[Figma](https://www.figma.com/design/z1Kn7wwKqEdRgjZT9Xq1vR/5N-Team-Project-UI?node-id=0-1&node-type=canvas&t=DqoP7y3TQDK7pOPl-0)

_iMacDonald?_

- 간단하고 발음하기 쉬운 구조
- 익숙한 두 요소 (i + MacDonald)의 조합으로 높은 회상성
- `i` 접두사는 apple의 네이밍 컨벤션을 연상시킴 (iPhone, iPad, iMac 등)
- IT기술과 전종적인 패스트푸드의 결합을 상징

## 👥 Team Members & Roles

| 팀장🎯 | 🎨 디자인/개발 | ⚡️ 개발/품질 | ⚡️ 개발/품질 | 👨‍💻 개발 총괄 |
| :-: | :-: | :-: | :-: | :-: |
| **유태호** | **김손겸** | **황석범** | **양정무** | **장상경** |
| iOS 개발, 프로그램 설계, 프로젝트 관리 | UI/UX 디자인, iOS 개발, 인터페이스 구현 | iOS 개발, 품질 관리(QC), 버그 수정 및 테스트 | iOS 개발, 데이터베이스 설계, 데이터 모델링 | iOS 개발, 코드 리뷰, 기술 지원 |

## 🎯 Project Goals

### 프로젝트 구현 목표

![image](https://github.com/user-attachments/assets/5dcdd2f2-81da-4eee-bda3-4cf7208c487d)

### 팀 핵심 목표
- 👨‍💻 각자 최소 1개의 기능 독립적 구현
- ⚖️ 팀원 간 균등한 업무량 분배
- 📈 개인 실력 향상
- 🤝 협업 경험 축적

### 기대 효과
- 🎓 실무 경험 획득
- 🔄 전체 개발 프로세스 이해
- 💪 개인 역량 강화
- 🤼 팀워크 향상

## 🍆Branch Rules & Strategies

![image](https://github.com/user-attachments/assets/dbb0346b-c378-43e2-9c3b-ba04d6e59d20)

1. **main 브랜치에 프로젝트 기본 세팅**
    - README 작성
    - .gitignore 파일 작성
    - 프로젝트 파일 생성(Xcode)
    - 코드베이스 기본 세팅(스토리보드 삭제, info 설정 등)
    - 프로젝트 Asset 추가(이미지, 컬러세트 등)
    - 프로젝트 디렉토리 분리(각 역할 별로 분리)
    
2. **dev 브랜치 생성(main 브랜치를 기준으로)**
    - 메인 브랜치에 만들어진 내용을 복제
    - 작업 브랜치(Default)를 dev 브랜치로 설정
    
3. **팀원별 원격 브랜치 분리**
    - dev 브랜치를 기준으로 원격 브랜치를 분리
    - 세부적인 작업 내용은 로컬 브랜치로 분리
  
4. **PR-Merge 전략**
    - PR을 작성할 때는 신규 내용, 변경 내용, 문제점 등을 상세히 작성
    - 팀원 모두는 PR에 대해 코멘트를 작성
    - Merge는 팀원 모두가 Approve 해야만 가능

5. **모든 작업 완료 후 test 브랜치를 생성**
    - dev 브랜치의 내용을 test 브랜치로 복제
    - test 브랜치에서 프로젝트 버그 확인 및 수정
    - 필요에 따라 hotFix 브랜치를 생성하여 운영

6. **완성된 프로젝트를 main에 전달**
    - test 브랜치에서 버그 등을 수정 후 최종 완성된 프로젝트를 main 브랜치에 전달
    - 불필요한 브랜치 삭제
    - README 수정

## 📓Github 커밋 컨벤션 가이드 (이모지 버전) 

### 기본 커밋 타입 
- ✨ `feat` : 새로운 기능 추가
- 🐝 `fix` : 버그 수정 
- 📝 `docs` : 문서 수정
- 💄 `style` : 코드 포맷팅, 세미콜론 누락, 코드 변경이 없는 경우
- ♻️ `refactor` : 코드 리팩토링
- ✅ `test` : 테스트 코드, 리팩토링 테스트 코드 추가
- 🎨 `chore` : 빌드 업무 수정, 패키지 매니저 수정

### 자주 사용되는 추가 타입
- 🚀 `deploy` : 배포
- ⚡️ `perf` : 성능 개선
- 🔧 `config` : 설정 파일 수정
- 📦 `build` : 빌드 관련 수정
- 🔀 `merge` : 합병
- ⏪️ `revert` : 되돌리기

