#  트리나 treena
<img src = "https://user-images.githubusercontent.com/64069925/132826551-1623b45b-60b9-48d4-94e1-55e925578fc9.jpeg" width="30%" height="30%">

**자연어 처리 기반 감정 분석, 성장 일기 iOS 애플리케이션🌱**


<img width="1098" alt="스크린샷 2022-03-12 오후 11 14 03" src="https://user-images.githubusercontent.com/64069925/158021628-57ccd182-58a8-4e90-8bfb-a4c99353ad3a.png">

**⭐️ 일기 작성을 통해 감정을 표현하고 해소하며, 즉각적인 감정분석과 나무의 성장을 통해 성취감을 느껴보세요!**

<br />

### 🛠 다운로드
[트리나 앱스토어](https://apps.apple.com/kr/app/%ED%8A%B8%EB%A6%AC%EB%82%98-treena/id1613522990)

<img src = "https://user-images.githubusercontent.com/64069925/158503705-d1a069c8-bede-4795-a2bc-b3949e45e813.PNG" width="30%" height="30%">


<br />

### 🌳 프로젝트 설명
- 사용자는 자신의 감정 변화에 집중하여 감정 단어를 활용하며 감정일기를 씁니다.
- 감정일기 작성을 통해 감정을 표현하고 해소할 수 있으며, 즉각적인 감정분석을 통해 공감하는 멘트와 이미지를 보여줌으로써 사용자에게 위로를 건넵니다.
- 앱을 설치했을 때 심는 씨앗에 '나'를 대입하여 일기를 쓸수록 성장하는 모습을 자라나는 나무로 시각화하여 보여주며, 나무의 성장을 통해 성취감을 느낄 수 있습니다.

<br />


### 팀원🌱🌱

|iOS|인공지능|디자인|
|------|---|---|
| [김송아](https://github.com/asong57) | [나영주](https://github.com/YoungjuNa-KR), [김유리](https://github.com/GlassK) | [류현지](https://github.com/RyuHyeonji) |
<br />

## 🔥 treena_v2 : MVVM + RxSwift 리팩토링 프로젝트
### 🛠 아키텍처 및 디자인 패턴 
- **RxSwift + MVVM 패턴 사용**
  - ViewModel과 View의 Data Bind와 비동기 로직을 RxSwift를 사용하여 구현
  - MVVM 패턴 도입하여 뷰컨트롤러와 뷰는 화면을 그리는 역할에만 집중하고 데이터 관리, 로직의 실행은 뷰모델에서 진행되도록 구성
- **Code base로 UI 구현 (SnapKit 사용)**
- **Feature별 디렉토리 구성**
<br />

### 💪 세부 기능
- 로딩 화면
- 로그인, 회원가입
- 홈화면에는 사용자의 일기 양에 맞추어 성장하는 나무가 보여진다.
- 달력을 통해 원하는 날짜의 일기를 읽을 수 있다.
- 일기를 작성하면 제출된 일기 내용을 토대로 감정을 분석하여 그에 맞는 이미지와 멘트를 건넨다.
- 마이페이지(비밀번호 변경, 회원탈퇴, 로그아웃)
