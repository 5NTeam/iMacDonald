# 🚔 5NTeam 

## <img src="https://github.com/user-attachments/assets/d8170c2c-8429-4464-a4ce-6553d13f7649" width="40"> Introduction to the Project

![진짜최종 001](https://github.com/user-attachments/assets/74f7672a-0f78-4b6a-aefa-a4d50a0e2e1d)

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

## 🍆 Branch Rules & Strategies

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

## 📓 Github 커밋 컨벤션 가이드 (이모지 버전) 

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

## ⚽️ Troubleshooting

### 🚨 1. 메인뷰 오토레이아웃 문제
- **문제**: 메뉴를 담은 카드뷰가 메인뷰에 배치될 때 구성요소들의 오토레이아웃이 틀어지는 문제 발생
- **해결**: 카드뷰 구성 요소들을 카드뷰의 비율로 설정하여 해결
```swift
make.height.equalToSuperview().multipliedBy(0.6)
```

### 🚨 2. 카드뷰의 BoderColor가 동적으로 업데이트되지 않는 문제
- **문제**: `layer.borderColor`가 동적으로 업데이트 되지 않는 문제가 발생
- **해결**: iOS 버전에 맞는 보더 컬러 업데이트 로직을 구현하여 해결
```swift
// MARK: - Dark Mode Handling
    /// 다크모드 변경 감지 시 호출되는 메서드
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateBorderColor()
        }
    }
    
    /// 테마에 따른 테두리 색상 업데이트 메서드
    private func updateBorderColor() {
        self.layer.borderColor = UIColor(named: "CardViewShadowColor")?.cgColor
    }
    
    /// iOS 17 이상에서 테마 변경 감지 설정 메서드
    private func registerTraitChangeHandler() {
        if #available(iOS 17.0, *) {
            registerForTraitChanges([UITraitUserInterfaceStyle.self]) { (self: Self, previousTraitCollection: UITraitCollection) in
                self.updateBorderColor()
            }
        }
    }
```

### 🚨 3. 테이블뷰 Index out of range
- **문제**: 테이블뷰에서 셀을 제거하는 액션에서 삭제 순서(row.index)에 따라 앱이 크래시되는 현상 발생
- **해결**: 셀 제거 액션을 수정하고 테이블뷰에서 제거된 행을 삭제하는 코드를 사용하여 오류 해결
```swift
cart.remove(at: row) // 삭제 액션 실행시 배열에서 인덱스 제거

// 테이블뷰에서 제거한 행을 삭제
tableView.deleteRows(at: [IndexPath(row: row, section: 0)], with: .none)
```

### 🚨 4. 다크모드/라이트모드 전환시에도 뷰 배경색상이 변하지 않음
- **문제**: 다크모드나 라이트모드로 설정을 변경해도 뷰의 배경색이 고정되어 변하지 않음
- **해결**: 배경색상의 컬러를 `UIColor.systemBackground`로 사용하거나 `Asset`에서 색상을 정의하여 사용

### 🚨 5. 메인뷰 스크롤 영역 침범
- **문제**: 메인뷰에서 테이블뷰가 보이지 않을 때도 테이블뷰가 차지하는 영역만큼 스크롤이 되지 않는 문제 발생
- **해결 1**: 테이블뷰의 `height`를 0으로 설정하고 셀이 업데이트 될 때만 `height` 값이 늘어나도록 설정 -> `height` 값이 계속 0으로 고정되어 테이블뷰가 터치되지 않는 문제 발생
- **해결 2**: 테이블뷰를 `Hidden`으로 설정하고 셀이 추가될 때만 보이도록 설정 -> 테이블뷰 셀이 1개일 때도 테이블뷰 영역 전체가 메인뷰에 영향을 미쳐 스크롤되지 않는 현상 발생
- **해결 3**: 튜터님께 피드백을 받아 `hitTest`메소드를 활용하여 테이블뷰의 셀이 비어있지 않을 때만 터치가 가능하도록 설정.
```swift
 /// 터치 이벤트 처리를 위한 메서드
    /// 테이블뷰 영역 외의 터치는 무시하도록 구현
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !tableView.frame.contains(point) else {
            return super.hitTest(point, with: event)
        }
        return nil
    }
``` 
