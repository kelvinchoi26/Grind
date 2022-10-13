# Grind
진정한 헬창을 위한 운동 일지 앱

## 진행하면서 학습한 내용
---
<details>
<summary>Realm Migration</summary>
<div markdown="1">

사용자가 마이그레이션 전에 백업한 데이터가 있으면 복원할 떄도 마이그레이션 작업이 필요하나요?

- 이전 코드들을 다 가지고 있어야됨, 최대한 migration하는 경우가 없게 해야됨..
- 복구할 때 migration 진행

만약 현재 앱에서 migration 진행한다면 백업/복구 기능은 없애야 될 수 있다

디버깅/개발 할 때 deleteRealmIfMigrationNeeded 플래그 활용하면 편함

- 출시할 때는 없애줘야함

```swift
extension AppDelegate {
        func aboutRealmMigration() {
                //deleteRealmIfMigrationNeeded: Migration이 필요한 경우 기존 램 삭제 (Realm Browser 닫고 다시 열기!)
                
                // 현재의 스키마 버전 = 2번째 버전
                let config = Realm.Configuration(schemaVersion: 2) { migration, oldSchemaVersion in
            
                        if oldSchemaVersion < 1 {
        
                        }

                        if oldSchemaVersion < 2 {
        
                        }

                }

        Realm.Configuration.defaultConfiguration = config
        
        }

}
```
- appDelegate에서 사용자의 schemaVersion 확인
- 위처럼 각 블럭마다 대응을 해줘야함 else if 없이 (avoid nesting)
    - else if로 처리하면 참인 경우 해당 블록만 실행하고 끝냄
    - 하지만 각 버전마다 configuration이 다르기 때문에 2인 경우 1과 2의 블록들을 다 적용시켜줘야함
- migration을 진행하게 되면 그 이전 버전 위에 덮어쓰는 형태이기 때문에 해당 코드는 지우지 않고 끝까지 가져가야함

</div>
</details>
---
## 개발일지
---
<details>
<summary>2022-09-13</summary>
<div markdown="1">

- 전체적인 코드 구조 잡기 - BaseViewController / BaseCollectionViewCell
- 탭바 설정 - 통계/홈/설정
- healthKit / fatSecretAPI - API 요청 테스트

</div>

<summary>2022-09-14</summary>
<div markdown="1">

- 기획서 수정
    - 운동/식단 팁 말풍선 추가
    - 음식 개수 체크 추가 (개수 or 그램 수)
    - 이모티콘 선택 모달 화면 추가
- .gitignore 추가
- 사진 찍은 다음에 이미지 Documents 폴더에 저장하는 코드 구현 필요!
    - fileManager 활용 - 수업 내용 체크!
- 스키마 구조 잡기

</div>

<summary>2022-09-15</summary>
<div markdown="1">

- 온보딩 페이지에 목표 체중, 목표 섭취칼로리, 목표 활동칼로리 입력
- 말풍선에 위 목표치에 따라 텍스트 띄우기 (내일 문구 추가 예정!)
    - 친절한 앱이 아니기 때문에 헬린이들에게도 도움이 될만한 문구 준비 중!
- SwiftLint 컨벤션 미완성, 조금 더 고민해보고 적용해보기!
- 무료 폰트 다운로드 후 적용, 컬러 다크모드 대응 후 적용!
    - 만약 중국어 지원을 하게 된다면 새로운 폰트 필요!
- 홈 뷰에서는 두 section의 컬렉션 뷰와 커스텀 뷰, 레이블 하나로 구성할 예정
- 홈 UI 미완성

### 내일 계획

- 홈 화면 UI 완성 후 healthKit으로 불러온 활동칼로리 화면에 적용 예정 (Realm 필요!)
- 음식 검색 API도 화면에 적용해보자!

</div>

<summary>2022-09-18</summary>
<div markdown="1">

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

</div>

<summary>2022-09-19</summary>
<div markdown="1">

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

</div>

<summary>2022-09-20</summary>
<div markdown="1">

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

</div>

<summary>2022-09-21</summary>
<div markdown="1">

### 진행사항

- 위 아래로 swipe했을 때 fsCalendar가 보이게 하는 기능 구현
- fsCalendar의 didSelect 기능 구현
    - 해당 날짜 선택했을 때 해당 날짜의 realm 객체를 불러와서 label들에 정보들을 reload
    - 해당 날짜에 정보가 입력 안 된 경우(realm 객체가 존재하지 않는 경우) realm 객체를 추가해줘야 오류가 안 뜬다

### 이슈

- fsCalendar scope이 week인 경우 height을 0으로 설정해도 Calendar의 타이틀이 뷰에 보인다
    - 해결: height이 0인 경우 isHidden을 true로 설정, 아닌 경우 false로 해서 자연스럽게 보여지게 했다.

</div>

<summary>2022-09-22</summary>
<div markdown="1">

- Realm의 primary key를 날짜로 할 수는 없는가?..
    - 혹시나 같은 날에 객체가 여러 개 생길 경우를 대비하기 위해..

### 이슈

- 해당 날짜에 정보가 입력 안 된 경우의 조건처리를 안 해주니 fetch를 했을 때 RLMException 에러가 발생한다
    - fsCalendar의 didSelect에 날짜에 정보가 없는 경우 해당 날짜의 객체를 add해줘서 에러 발생을 방지했다.

</div>

<summary>2022-09-23</summary>
<div markdown="1">

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

</div>

<summary>2022-09-24</summary>
<div markdown="1">

- 어디에 weak 키워드를 사용해야 memory leak를 방지할 수 있을까?..
- 기록 뷰컨에 tapman 사용해서 체중과 칼로리를 나눠줘볼까?..
- 다들 캘린더를 접었다 필때 PanGesture를 사용하심

</div>

<summary>2022-09-25</summary>
<div markdown="1">

- 그램수를 어떻게 입력 받을지 고민…
    - 해당 음식의 단위를 그램으로 고정해도 괜찮을까?
    - 우선은 그램을 고정 단위로 Realm 객체를 생성하자
- 오늘부로 api 활용하는 것은 포기하고… 그냥 칼로리 직접 입력하는 것으로 바꿈
- 대신 음식 사진 찍는 기능 추가
- 음식의 칼로리, 양, 탄단지 입력하면 collectionView 형태로 보이게 됨 (RecordViewController의 오른쪽 tab에)
- 알림 기능, 유튜브 추천 추가

</div>

<summary>2022-09-26</summary>
<div markdown="1">

- YPImagePicker로 카메라 찍기, 갤러리에서 가져오기 구현
- DailyRecord Realm에 Food 배열 객체를 추가해서 하루의 식단 정보를 추가
- 새로 영양정보 입력하는 뷰컨 UI 완성
- RecordVC에 tabman 적용해서 새로운 탭에 식단 사진과 정보를 담고있는 CollectionView 추가 예정

</div>

<summary>2022-09-27</summary>
<div markdown="1">

- 식단 정보 입력 VC UI 구현 + YPImagePicker 적용

### 이슈

- WalkThrough VC이 dismiss 될 때 HomeVC의 viewWillAppear이 호출이 안 되는 이슈가 있어서 홈화면에서 체중이 업데이트가 안 됐었다.
    - WalkThroughVC의 modalPresentationStyle을 .fullScreen으로 바꾸면 새로운 VC이 띄워지는 효과 때문에 viewWillAppear이 호출되게 된다.

</div>

<summary>2022-09-28</summary>
<div markdown="1">

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

</div>

<summary>2022-09-29</summary>
<div markdown="1">

- 홈화면의 Realm을 통한 UI 업데이트 문제 해결
- 첫 실행 시, 해당 날짜의 객체가 안 불러지는 문제 해결
- Realm 관련 데이터 전달 문제 완전 해결

</div>

<summary>2022-10-02</summary>
<div markdown="1">

- Charts 그래프를 그릴 때 마다 아래 두 가지 오류가 발생했다
    - type 'chartdataset' does not conform to protocol 'rangereplaceablecollection'
    - unavailable instance method 'replacesubrange(_:with:)' was used to satisfy a requirement of protocol 'rangereplaceablecollection'
- Charts의 설치 버전을 최신 버전으로 바꾸니까 모든 런타임에러가 해결이 되었고 설치할 때 Charts만 선택해서 설치하면 추가적인 오류 발생을 방지할 수 있다(ChartsDynamic 선택 해제)
- 통계 탭의 그래프를 정상적으로 출력하고 있다
    - 다만 x축의 값을 더 알아보기 쉽게 수정할 필요가 있어보임 (Double값밖에 못 들어가는지, String값 넣을 수 있는지 질문)
- 내일 설정 탭만 완성하면 1.0 버전을 출시할 수 있게 될 것 같다!

</div>

<summary>2022-10-03</summary>
<div markdown="1">

- 통계 탭 UI 수정
- 체중 입력했을 때 소수점 아래 한 자리까지 반올림된 형태로 realm에 업데이트되게 구현
- 활동칼로리 property에 저장해서 reloadLabel때 마다 활동칼로리가 업데이트되게 구현
- 오늘의 운동 view에 카메라 저장하고 보여주는 기능 추가
- Advice Label에 메시지가 viewWillAppear마다 랜덤으로 바뀌게 구현

### 이슈

- 캘린더 스와이프 하면 띄워진다는 표시 or 안내 필요
- 체중 변화 view를 삭제함
    - 그래프로 이미 차이를 볼 수 있고, 직전 기록된 날의 기록을 가져오기 어려워서 삭제하게 됨
- Terminating app due to uncaught exception 'RLMException', reason: 'Realm accessed from incorrect thread.’
    - 활동칼로리를 클로저로 받아온 다음 realm 객체에서도 수정을 진행하려하면 잘못된 쓰레드에 접근했다는 에러가 뜸
    - 아직 객체가 수정이 되기전에 불러와서 오류가 발생하는 것이 아닌가라는 추측 (한 스레드 내에서 수정하고 읽어오는건 불가능)
    - 우선 property에 활동칼로리 저장해서 reloadLabel때 마다 업데이트 되게 구현 (추후에 GCD에 대해서 더 공부한 뒤에 수정을 해보려고 합니다)
        - 참고 자료

[Reading updated Realm ThreadSafeReference on ba...anycodings](https://www.anycodings.com/1questions/2559560/reading-updated-realm-threadsafereference-on-background-queue)

</div>

<summary>2022-10-04</summary>
<div markdown="1">

- 초기화 해버리면 Realm 오류가 발생해서 나중에 추가
- 그래프 양 옆 레이블 잘리는거 수정
- 설정 뷰의 건강 앱 접근권한 변경 → 기능 수정 필요함
    - 처음에 권한 승인 안 한 상태에서 승인한 상태로 바꾸려고 할 때 requestAuthorization이 실행 되지 않는 오류가 있음

</div>

<summary>2022-10-05 Grind 1.0 버전 출시!</summary>
<div markdown="1">

### **업데이트 예정 기능**
---
램 데이터 암호화에 대해서 찾아보자

첫 실행때 식단 추가하면 crash 발생

작은 화면일 경우 홈 셀이 살짝 겹쳐보이는 느낌

온보딩 페이지에 페이지네이션 구현

런치 스크린 추가

</div>

<summary>2022-10-08</summary>
<div markdown="1">

- 조금 더 조건처리를 꼼꼼하게 할 필요는 있을 것 같다 - ex. 칼로리 입력 받을 때 정수만 받을 수 있게
- 일부 화면에서 reloadLabel()이 여러 번 실행됨

### 다음 날에 HomeVC을 불러왔을 때 발생하는 Crash

```swift
Last Exception Backtrace:
0   CoreFoundation                        0x7ff800427368 __exceptionPreprocess + 226
1   libobjc.A.dylib                       0x7ff80004dbaf objc_exception_throw + 48
2   Grind                                    0x10328470c RLMThrowResultsError(NSString*) + 620
3   Grind                                    0x103285895 auto translateRLMResultsErrors<-[RLMResults objectAtIndex:]::$_7>(-[RLMResults objectAtIndex:]::$_7&&, NSString*) + 117
4   Grind                                    0x1032857a9 -[RLMResults objectAtIndex:] + 105
5   Grind                                    0x103400c54 Results.subscript.getter + 228
6   Grind                                    0x102f98742 HomeViewController.reloadLabel() + 546 (HomeViewController.swift:167)
7   Grind                                    0x102f98519 HomeViewController.tasks.didset + 25 (HomeViewController.swift:29)
8   Grind                                    0x102f984e5 HomeViewController.tasks.setter + 117
9   Grind                                    0x102f9a59a HomeViewController.checkInitialRun() + 730 (HomeViewController.swift:121)
10  Grind                                    0x102f9a25f HomeViewController.viewDidLoad() + 95 (HomeViewController.swift:51)
11  Grind                                    0x102f9ab9c @objc HomeViewController.viewDidLoad() + 28
12  UIKitCore                                0x1127e1ffa -[UIViewController _sendViewDidLoadWithAppearanceProxyObjectTaggingEnabled] + 80
13  UIKitCore                                0x1127e74b0 -[UIViewController loadViewIfRequired] + 1128
14  UIKitCore                                0x112712d7e -[UINavigationController _updateScrollViewFromViewController:toViewController:] + 162
15  UIKitCore                                0x1127130c2 -[UINavigationController _startTransition:fromViewController:toViewController:] + 227
16  UIKitCore                                0x1127140c3 -[UINavigationController _startDeferredTransitionIfNeeded:] + 863
17  UIKitCore                                0x112715468 -[UINavigationController __viewWillLayoutSubviews] + 136
18  UIKitCore                                0x1126f304c -[UILayoutContainerView layoutSubviews] + 207
19  UIKitCore                                0x1136fc913 -[UIView(CALayerDelegate) layoutSublayersOfLayer:] + 2305
20  QuartzCore                            0x7ff8088f8cb8 CA::Layer::layout_if_needed(CA::Transaction*) + 526
21  QuartzCore                            0x7ff808904191 CA::Layer::layout_and_display_if_needed(CA::Transaction*) + 65
22  QuartzCore                            0x7ff80881821d CA::Context::commit_transaction(CA::Transaction*, double, double*) + 623
23  QuartzCore                            0x7ff80884fa56 CA::Transaction::commit() + 714
24  UIKitCore                                0x1130f431c __34-[UIApplication _firstCommitBlock]_block_invoke_2 + 34
25  CoreFoundation                        0x7ff800386cb1 __CFRUNLOOP_IS_CALLING_OUT_TO_A_BLOCK__ + 12
26  CoreFoundation                        0x7ff80038646a __CFRunLoopDoBlocks + 406
27  CoreFoundation                        0x7ff800380dc8 __CFRunLoopRun + 948
28  CoreFoundation                        0x7ff800380637 CFRunLoopRunSpecific + 560
29  GraphicsServices                      0x7ff809c0f28a GSEventRunModal + 139
30  UIKitCore                                0x1130d4425 -[UIApplication _run] + 994
31  UIKitCore                                0x1130d9301 UIApplicationMain + 123
32  libswiftUIKit.dylib                      0x10839ac02 UIApplicationMain(_:_:_:_:) + 98
33  Grind                                    0x102fa3328 static UIApplicationDelegate.main() + 104
34  Grind                                    0x102fa32b7 static AppDelegate.$main() + 39
35  Grind                                    0x102fa33a8 main + 24
36  dyld_sim                                 0x107e7b2bf start_sim + 10
37  dyld                                     0x11798d52e start + 462
```

- 새로운 Date를 불러올 때 realm쪽에서 오류가 발생하는 것으로 추정됨
- 문제 해결: viewDidLoad가 실행될 때 마다 실행되는 checkInitialRun(첫 실행인지 확인하는 함수)에 realm 객체를 불러오는 기준 날짜를 업데이트 해주지 않아서 발생한 crash
    - 해결 방법: 현재 날짜를 불러온 이후 해당 날짜에 realm 객체가 아직 생성이 되지 않은 경우 아래와 같이 객체 생성한 다음에 tasks를 업데이트 해줌

```swift
private func checkInitialRun() {
    if !userDefaults.bool(forKey: "NotFirst") {
            
        let walkThrough = WalkThroughViewController()
        walkThrough.modalPresentationStyle = .fullScreen
            
        walkThrough.completionHandler = { tasks in
            self.tasks = tasks
        }
            
        self.present(walkThrough, animated: true)
    } else {
        // ***오류 코드***
        // self.tasks = repository.fetch(by: currentDate)
            
        currentDate = Date()
            
        let newTasks = repository.fetch(by: currentDate)
            
        // 해당 선택된 날짜에 realm 객체가 아직 생성이 안 된 경우
        if newTasks.count == 0 {
            let record = DailyRecord(date: currentDate, weight: 0.0, caloriesBurned: 0, caloriesConsumed: 0, didWorkout: false, workoutRoutine: nil, workoutTime: nil, food: foodList)
                
            repository.addRecord(item: record)
            tasks = repository.fetch(by: currentDate)
        } else {
            tasks = repository.fetch(by: currentDate)
        }
    }
}
```

### 첫 실행시 식단 추가했을 때 발생하는 Crash

```swift
Last Exception Backtrace:
0   CoreFoundation                        0x7ff800427368 __exceptionPreprocess + 226
1   libobjc.A.dylib                       0x7ff80004dbaf objc_exception_throw + 48
2   Grind                                    0x10df9970c RLMThrowResultsError(NSString*) + 620
3   Grind                                    0x10df9a895 auto translateRLMResultsErrors<-[RLMResults objectAtIndex:]::$_7>(-[RLMResults objectAtIndex:]::$_7&&, NSString*) + 117
4   Grind                                    0x10df9a7a9 -[RLMResults objectAtIndex:] + 105
5   Grind                                    0x10e115c54 Results.subscript.getter + 228
6   Grind                                    0x10dc80f0b RecordViewController.reloadLabel() + 379 (RecordViewController.swift:84)
7   Grind                                    0x10dc80d89 RecordViewController.tasks.didset + 25 (RecordViewController.swift:22)
8   Grind                                    0x10dc80d55 RecordViewController.tasks.setter + 117
9   Grind                                    0x10dc82d67 closure #1 in RecordViewController.addCalorie() + 55 (RecordViewController.swift:77)
10  Grind                                    0x10dca274b AddFoodViewController.viewWillDisappear(_:) + 347 (AddFoodViewController.swift:44)
11  Grind                                    0x10dca27b2 @objc AddFoodViewController.viewWillDisappear(_:) + 50
12  UIKitCore                                0x123aecb27 -[UIViewController _setViewAppearState:isAnimating:] + 1746
13  UIKitCore                                0x123aed6c7 -[UIViewController __viewWillDisappear:] + 93
14  UIKitCore                                0x1239b9001 __56-[UIPresentationController runTransitionForCurrentState]_block_invoke.411 + 876
15  UIKitCore                                0x12498a7dd -[_UIAfterCACommitBlock run] + 54
16  UIKitCore                                0x12498acdc -[_UIAfterCACommitQueue flush] + 190
17  libdispatch.dylib                     0x7ff80013b7fb _dispatch_call_block_and_release + 12
18  libdispatch.dylib                     0x7ff80013ca3a _dispatch_client_callout + 8
19  libdispatch.dylib                     0x7ff80014c32c _dispatch_main_queue_drain + 1338
20  libdispatch.dylib                     0x7ff80014bde4 _dispatch_main_queue_callback_4CF + 31
21  CoreFoundation                        0x7ff8003869f7 __CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__ + 9
22  CoreFoundation                        0x7ff8003813c6 __CFRunLoopRun + 2482
23  CoreFoundation                        0x7ff800380637 CFRunLoopRunSpecific + 560
24  GraphicsServices                      0x7ff809c0f28a GSEventRunModal + 139
25  UIKitCore                                0x1243d3425 -[UIApplication _run] + 994
26  UIKitCore                                0x1243d8301 UIApplicationMain + 123
27  libswiftUIKit.dylib                      0x113344c02 UIApplicationMain(_:_:_:_:) + 98
28  Grind                                    0x10dcb8328 static UIApplicationDelegate.main() + 104
29  Grind                                    0x10dcb82b7 static AppDelegate.$main() + 39
30  Grind                                    0x10dcb83a8 main + 24
31  dyld_sim                                 0x112b902bf start_sim + 10
32  dyld                                     0x1134cc52e start + 462
```

- AddFoodVC가 Sheet 형태로 보여지다 보니 viewWillAppear, viewDidDisappear에 대한 코드가 실행되지 않아서 발생한 오류
    - 일반적인 해결방법은 Delegate를 활용해서 데이터를 전달하거나, 아예 present 방식이 아닌 navigationController가 embed된 상태로 push를 해줘서 데이터를 전달 받을 수 있게 설계를 바꾸는 것인데 후자를 선택하게 되었습니다.
    
    ```swift
    @objc func addCalorie() {
        let vc = AddFoodViewController()
            
        vc.tasks = self.tasks
        vc.currentDate = self.currentDate
            
        self.navigationController?.pushViewController(vc, animated: true)
    }
    ```
    
    - push를 한 다음 RecordVC의 viewWillAppear 생명주기에 reloadLabel()를 포함해서 AddFoodVC에서 넘어올 때 UI상의 label이 바뀔 수 있게 변경해줌
    - **생명주기를 잘 이해하고 활용하자**

</div>
</details>
