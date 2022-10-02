# Grind
진정한 헬창을 위한 운동 일지 앱

## 개발일지

### 2022-09-13 진행상황
- - -
- 전체적인 코드 구조 잡기 - BaseViewController / BaseCollectionViewCell
- 탭바 설정 - 통계/홈/설정
- healthKit / fatSecretAPI - API 요청 테스트

### 2022-09-14 진행상황
- - -
- 기획서 수정
    - 운동/식단 팁 말풍선 추가
    - 음식 개수 체크 추가 (개수 or 그램 수)
    - 이모티콘 선택 모달 화면 추가
- .gitignore 추가
- 사진 찍은 다음에 이미지 Documents 폴더에 저장하는 코드 구현 필요!
    - fileManager 활용 - 수업 내용 체크!
- 스키마 구조 잡기

### 2022-09-15 진행상황
---
- 온보딩 페이지에 목표 체중, 목표 섭취칼로리, 목표 활동칼로리 입력
- 말풍선에 위 목표치에 따라 텍스트 띄우기 (내일 문구 추가 예정!)
    - 친절한 앱이 아니기 때문에 헬린이들에게도 도움이 될만한 문구 준비 중!
- SwiftLint 컨벤션 미완성, 조금 더 고민해보고 적용해보기!
- 무료 폰트 다운로드 후 적용, 컬러 다크모드 대응 후 적용!
    - 만약 중국어 지원을 하게 된다면 새로운 폰트 필요!
- 홈 뷰에서는 두 section의 컬렉션 뷰와 커스텀 뷰, 레이블 하나로 구성할 예정
- 홈 UI 미완성

내일 계획

- 홈 화면 UI 완성 후 healthKit으로 불러온 활동칼로리 화면에 적용 예정 (Realm 필요!)
- 음식 검색 API도 화면에 적용해보자!


### 2022-09-18 진행상황
---
- 홈화면 UI 완성
- HealthKit API 통신 완료 (테스트 프로젝트에서!)
- HealthKit API 화면과 연결
    - 본 프로젝트에 적용 필요!

### 유의사항

- 운동 이모티콘의 사진은 아직 추가안함!

### 이슈

- workoutView를 깜빡하고 subview에 추가 안해준 것이 이슈의 원인…ㅠ (자주 까먹는다..)

### 내일계획

- fatSecretAPI 통신 완성
- fatSecretAPI 화면과 연결

### 2022-09-19 진행상황
---
### 진행사항

- HealthKit에 관해서 참고한 사이트

[The HealthKit Comprehendium](https://medium.com/1mgofficial/the-healthkit-comprehendium-7e9e8e03c03e)

- 해외 이용자의 경우 HealthKit의 정보를 불러올 때 Date 설정 어떻게 해야할지 고민!
    - UTC 사용? 검색 필요
- 온보딩 화면에서 유저에게 체중만 입력받아 dailyRecord 객체 최초 생성
    - date(시점)은 현재, 활동칼로리는 healthKit이 연결됐을 때 O, 연결 안 됐을 때는 X
    - 섭취칼로리는 0, 사진/오늘의 운동/컨디션은 nil로 객체 생성
- force unwrapping로 인해 발생할 수 있는 런타임 에러 발생 가능성 없애기
    - do try catch로 에러 발생 관리
- 사용자가 healthKit 접근 허용을 원하지 않는 경우, 헬창들의 평균 활동칼로리인 1000kcal 기본 설정

### 이슈

- Realm으로 날짜에 맞는 활동칼로리 불러올 때
- navigationBar title에 FSCalendar를 여는 버튼 구현하는 방법.. (참고 앱: FatSecret)
- 나중에 설정 앱에 건강 앱 권한 관련 수정할 수 있게 화면 추가

###기타

- 공유하기 기능 추가하면 좋을 것 같다! 코치한테 섭취칼로리/활동칼로리 오늘의 체중 보고 용으로 (사진까지 공유하면 너무 좋을듯하다!)

### 2022-09-20 진행상황
---
### 진행사항

- HealthKit 접근 허용 + 활동칼로리 불러오기 구현 완료
- WalkThrough UI + 빈 값 들어갔을 때 조건 처리 완료

### 이슈

- NavigationTitle(날짜)를 클릭했을 때 FSCalendar를 띄우는 방법!
1. 새로운 ViewController 띄우기 - 값 전달하기 복잡함
2. FSCalendar의 스와이프 기능을 사용해서 구현!
    - viewDidLoad에서는 FSCalendar의 height를 0으로 설정해서 아예 안 보이게
    - 스와이프하면 height 높이를 설정하고 animation까지 추가해주면 구현 가능!

###기타

- 나만의 추천 운동 유튜브를 테이블뷰로 보여주기?

### 2022-09-21 진행상황
---
### 진행사항

- 위 아래로 swipe했을 때 fsCalendar가 보이게 하는 기능 구현
- fsCalendar의 didSelect 기능 구현
    - 해당 날짜 선택했을 때 해당 날짜의 realm 객체를 불러와서 label들에 정보들을 reload
    - 해당 날짜에 정보가 입력 안 된 경우(realm 객체가 존재하지 않는 경우) realm 객체를 추가해줘야 오류가 안 뜬다

### 이슈

- fsCalendar scope이 week인 경우 height을 0으로 설정해도 Calendar의 타이틀이 뷰에 보인다
    - 해결: height이 0인 경우 isHidden을 true로 설정, 아닌 경우 false로 해서 자연스럽게 보여지게 했다.

### 2022-09-22 진행상황
---
- Realm의 primary key를 날짜로 할 수는 없는가?..
    - 혹시나 같은 날에 객체가 여러 개 생길 경우를 대비하기 위해..

### 이슈

- 해당 날짜에 정보가 입력 안 된 경우의 조건처리를 안 해주니 fetch를 했을 때 RLMException 에러가 발생한다
    - fsCalendar의 didSelect에 날짜에 정보가 없는 경우 해당 날짜의 객체를 add해줘서 에러 발생을 방지했다.

### 2022-09-22 진행상황
---
### 진행사항

- 화면을 넘길 때 마다 데이터 전달 구현 (viewWillAppear에 tasks를 업데이트 해줬음)
- 해당 날짜 선택했을 때 label들에 알맞는 데이터 나타내기 구현

### 이슈

- 해당 날짜에 정보가 입력 안 된 경우의 조건처리를 안 해주니 fetch를 했을 때 RLMException 에러가 발생한다
    - fsCalendar의 didSelect에 날짜에 정보가 없는 경우 해당 날짜의 객체를 add해줘서 에러 발생을 방지했다.
- textfield 조건처리 할 때 사용자가 소수점 아래 한 자리까지 치게 만들까 아니면 직접 반올림한 값을 추가할지.. 고민 좀 해보자..
- realm의 primary key를 날짜로 할 수는 없는가?..
    - 혹시나 같은 날에 객체가 여러 개 생길 경우를 대비하기 위해..

### 내일 계획

- 건강 앱에서 활동 칼로리 불러오기
- 음식 검색 VC UI 구성
- fatSecretAPI UI에 적용

### 2022-09-23 진행상황
---
- 어디에 weak 키워드를 사용해야 memory leak를 방지할 수 있을까?..
- 기록 뷰컨에 tapman 사용해서 체중과 칼로리를 나눠줘볼까?..
- 다들 캘린더를 접었다 필때 PanGesture를 사용하심

### 2022-09-25 진행상황
---
- 그램수를 어떻게 입력 받을지 고민…
    - 해당 음식의 단위를 그램으로 고정해도 괜찮을까?
    - 우선은 그램을 고정 단위로 Realm 객체를 생성하자
- 오늘부로 api 활용하는 것은 포기하고… 그냥 칼로리 직접 입력하는 것으로 바꿈
- 대신 음식 사진 찍는 기능 추가
- 음식의 칼로리, 양, 탄단지 입력하면 collectionView 형태로 보이게 됨 (RecordViewController의 오른쪽 tab에)
- 알림 기능, 유튜브 추천 추가

### 2022-09-26 진행상황
--- 
- YPImagePicker로 카메라 찍기, 갤러리에서 가져오기 구현
- DailyRecord Realm에 Food 배열 객체를 추가해서 하루의 식단 정보를 추가
- 새로 영양정보 입력하는 뷰컨 UI 완성
- RecordVC에 tabman 적용해서 새로운 탭에 식단 사진과 정보를 담고있는 CollectionView 추가 예정

### 2022-09-27 진행상황
---
- 식단 정보 입력 VC UI 구현 + YPImagePicker 적용

### 이슈

- WalkThrough VC이 dismiss 될 때 HomeVC의 viewWillAppear이 호출이 안 되는 이슈가 있어서 홈화면에서 체중이 업데이트가 안 됐었다.
    - WalkThroughVC의 modalPresentationStyle을 .fullScreen으로 바꾸면 새로운 VC이 띄워지는 효과 때문에 viewWillAppear이 호출되게 된다.
    
### 2022-09-28 진행상황
---
- DailyRecord 객체에 Food 객체 리스트를 추가
    - 식단 추가/삭제 기능 모두 필요함
- 활동칼로리/섭취칼로리 column의 옵셔널 가능성을 제거했다
    - 기본값 0으로 설정
- 이미지 저장하는 방식
    - 첫번째는 사진을 데이터 타입으로 변환해서 Realm에 저장하는 것이다.
        - 권장하지 않는 방법 - 용량 문제(추정)
    - 두번째는 Document 폴더 내에 저장하는 것이다.
    - realm 객체의 유니크한 키를 경로로 설정하여 저장하기로 했다.

### 이슈

- 선택된 dailyRecord 객체를 recordVC에 이어 foodVC에 까지 전달해야 하는 구조가 너무 비효율적으로 느껴짐…
- 다음 프로젝트는 꼭 MVVM 구조로 해봐야겠다!!
- 시간만 괜찮다면 MVVM 구조 리팩토링 해보고 싶다
- food 객체는 추가가 정상적으로 되는데 dailyRecord 객체의 섭취칼로리에 반영이 잘 되지 않는 이슈 발생
    - 내일 해결 예정
- 생명주기에 대한 공부 더 많이 필요.. 데이터 업데이트 시점에 대한 고민이 너무 많이 필요해보임

### 2022-09-29 진행상황
---
- 홈화면의 Realm을 통한 UI 업데이트 문제 해결
- 첫 실행 시, 해당 날짜의 객체가 안 불러지는 문제 해결
- Realm 관련 데이터 전달 문제 완전 해결

### 2022-10-02 진행상황
--- 
- Charts 그래프를 그릴 때 마다 아래 두 가지 오류가 발생했다
    - type 'chartdataset' does not conform to protocol 'rangereplaceablecollection'
    - unavailable instance method 'replacesubrange(_:with:)' was used to satisfy a requirement of protocol 'rangereplaceablecollection'
- Charts의 설치 버전을 최신 버전으로 바꾸니까 모든 런타임에러가 해결이 되었고 설치할 때 Charts만 선택해서 설치하면 추가적인 오류 발생을 방지할 수 있다(ChartsDynamic 선택 해제)
- 통계 탭의 그래프를 정상적으로 출력하고 있다
    - 다만 x축의 값을 더 알아보기 쉽게 수정할 필요가 있어보임 (Double값밖에 못 들어가는지, String값 넣을 수 있는지 질문)
- 내일 설정 탭만 완성하면 1.0 버전을 출시할 수 있게 될 것 같다!
