# iruri

본 프로젝트는 Flutter를 이용해 구현된 프로젝트이며 Flutter에 관한 정보는 아래에서 확인할 수 있습니다.

# Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Package 

Flutter는 다양한 패키지를 지원합니다. 패키지는 유저들에 의해 제작된 패키지일 수 있고 Flutter 제작진에 의해 만들어진 패키지일 수 있습니다. 관련 문서는 패키지를 배포한 곳에서 각자 Github Repository가 있기 때문에 읽어보시면 이해가 잘 되실 겁니다. 따라서 React나 React-Native에서 사용한 것 처럼 패키지들의 버전들 사이에 호환성 문제가 발생할 수 있으며 이를 유지보수해주어야합니다.

## Android

안드로이드는 크게 많은 제한사항을 두지 않는 편입니다. 어떤 패키지를 추가할 때 현재 인터넷을 이용한 작업이나 카메라관련 작업은 설정을 해두었기 때문에 그 이외에 작업할 사항이 있다면 이를 수정해야할 필요가 있습니다. `iruri/android/app/src/main/AndroidManifest.xml` 에서 수정할 수 있습니다.

## iOS

iOS는 많은 제한사항을 두고 있습니다. 현재는 애뮬레이터에서만 실행해 데모 애플리케이션을 만들어 왔기 때문에 별도로 Xcode에서 계정 인증이 필요합니다. 인터넷이나 카메라 이외에 작업을 하는 경우 `iruri/ios/Runner/Info.plist` 에서 수정하거나 Xcode에서 직접 수정해야합니다. 그리고 간혹 iOS 빌드를 진행할 때 오류가 발생하는데 이때는 flutter 환경과 pod 환경이 맞지 않을 수 있습니다. 아래와 같이 진행하면 일반적인 문제는 해결됩니다.

- flutter 환경 clean
``` bash
flutter clean
```
- ios directory 백업
이때 `/ios` 디렉토리를 따로 백업해두시는 것을 추천합니다.
`/ios` 디렉토리를 프로젝트에서 제거를 한 뒤,
``` bash
flutter build ios
```
그리고 Podfile에 맞게 환경설정을 해줍니다.
``` bash
cd ios && pod install
```

# Directory

- [assets](##assets)
- [build](##build)
- [android](##android)
- [ios](##ios)
- [lib](##lib)
- [web](##web)

## assets
애플리케이션 내장에서 사용되는 이미지나 폰트와 같은 것을 저장해 사용하는 디렉토리입니다. `/assets`에 추가할 경우에는 항상 `pubspec.yaml`을 업데이트 해주어야합니다.
``` yaml
 assets:
    - Icon-192.png
```
위와 같이 추가하고자 이미지 파일을 작성해야합니다.

## build
애플리케이션을 build 했을 때 해당 디렉토리에 저장됩니다. 배포할 경우 build에 모든 사항이 저장된다고 생각하시면 됩니다.

## android
Android 관련 설정이나 내부설정을 담당하는 곳입니다. Flutter가 크로스 플랫폼이기 때문에 패키지를 사용하는 경우에는 이를 모두 관리를 해주기 때문에 특별한 경우 이외에는 수정하지 않습니다.

## ios
iOS 관련 설정이나 내부설정을 담당하는 곳입니다. Flutter가 크로스 플랫폼이기 때문에 패키지를 사용하는 경우에는 이를 모두 관리해주지만, iOS와 같은 경우에는 `info.plist`를 수정하는 경우가 종종 발생합니다.

## lib
애플리케이션의 모든 코드를 담당하고 있는 디렉토리입니다. 해당 디렉토리는 크게
- components
- model
- pages
- util
- main.dart
- provider.dart
- routes.dart
로 구성되어있습니다.

### components
components는 **재사용되는 UI 컴포넌트**를 주로 담으려고 하였습니다. 예를 들어 TextField의 style이나 자주 사용되는 TextStyle 그리고 디자인 가이드에서 제안해주신 색이나 padding 및 margin을 재사용할 수 있도록 해당 디렉토리에 담았습니다.

component에 디자인 가이드에서 제안해주신 사항들을 모두 제작하려 했으나 시간이 따라주지 못하였고 팀원들과의 소통이 부족했는지 제작된 UI 컴포넌트들이 한 부분에서만 재사용되는 그런 현상이 있었습니다. 몇개 수정해 사용하고 있지만 중간 중간 코드에 그렇지 못한 코드들이 있어 참고해주시면 됩니다.😅

### model
model은 애플리케이션과 Server와 공통적으로 갖는 모델들을 담은 디렉토리입니다. 크게는 Article과 User가 있습니다. 이들은 모두 하나의 class가 아닌 sub-class의 집합으로 구성하여 최대한 책임을 분리하였습니다. 그리고 모두 `fromJson( )`과 `toJson( )`이란 함수를 구현하여 API 요청 및 응답 시 사용할 수 있도록 간편화 하였습니다.

Flutter의 model 사용은 장점이자 단점입니다. 지속적으로 update되는 model일 경우에는 model을 작성해서 사용하는 것 보다는 Map 구조로 데이터를 조회하는 것이 더 효율적입니다. 하지만 변동되는 것이 작은 편이라면 model을 사용하는 것이 더 효율적이라고 생각합니다.

### pages
위에서 제작한 component들을 재사용해 각 페이지를 제작한 곳입니다. 현재는 home, personal, signup, state 총 4개의 분류로 되어 있고 해당 디렉토리에서는 각자 맡은 화면의 레이아웃과 `Future` 함수들을 담고 있습니다. 일종의 view 역할을 해주는 곳 입니다.

### util
util은 클라이언트가 서버로 요청을 보낼 때 사용하는 함수들을 각 class를 만들어 구현하였습니다. `ArticleAPI`는 게시글 관련되 API를 모두 담아 `interface.dart`에 선언되어있는 값들을 통해 서버에게 요청을 합니다. `UserAPI`도 마찬가지 입니다.

해당 디렉토리는 클라이언트에게 모든 데이터가 준비되었을 때 서버로 요청을 보내는 작업을 하며, 그 이전의 작업들은 `page`에서 하게 됩니다.

### main.dart
애플리케이션이 실행될 때 가장 먼저 실행되는 파일입니다. 
``` dart
void main() {
  runApp(

      /// the main part of provider tree
      /// [CustomRouter] manage nested page routing
      /// [UserState] manage current user, who has signed-in at the first time
      MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CustomRouter()),
      ChangeNotifierProvider(create: (context) => UserState())
    ],
    child: MyApp(),
  ));
}
```
현재는 MultiProvider를 사용해서 두개의 Provider를 사용하고 있습니다. Provider는 Flutter에서 상태관리를 하기에 적합하고 쉬운 패키지입니다. Flutter에서 직접 제공하고 있으며 쉽게 설명하자면 가장 상위 노드에 상태들을 집합시켜 하위 노드에 있는 class나 function 내에서 접근하여 사용할 수 있습니다. 보안성의 문제도 있을 수 있지만 이는 Provider 내 class를 고도화 한다면 보안 이슈를 해결할 수 있을 거라 생각합니다.😀

### provider.dart
현재 `CustomRouter`와 `UserState` 두 개의 Provider를 담고 있는 파일입니다. 자세한 설명은 주석으로 작성해두었습니다.

### routes.dart
이 파일은 사용자가 앱 내에서 터치를 해서 페이지 이동을 할 경우 android의 ViewPager와 비슷한 역할을 하기위해 제가 직접 만든 기능입니다. 해당 [PR은 여기로](https://github.com/lRuRl/idea-concert/pull/7) 가시면 확인하실 수 있습니다. `routes.dart`를 통해서 원하는 이동할 수 있는 페이지를 아래와 같이 작성을 한 뒤 하 사용하면 `bottomNavigator`를 아래에 상시 배치시키고 사용할 수 있습니다.

## web
해당 애플리케이션을 web으로도 사용할 수 있습니다. 현재 Flutter는 Web 2.0이 출시되었기 때문에 애플리케이션에서 사용하는 패키지를 수정해서 웹에서도 호환되도록 수정한다면 web으로도 충분히 배포 가능합니다. 

아래는 제가 제작한 Flutter 웹 사이트입니다.
- [Flutter로 배포한 웹 예시 확인하기 - 1](https://seunghwanly.github.io/#/)
- [Flutter로 배포한 웹 예시 확인하기 - 2](https://fintech.yonsei.ac.kr/#/)

---

문의사항은 아래 이메일로 연락을 주시거나 새로운 Issue를 열어주세요.😀

<p align="end">
작성자 : @seunghwanly (seunghwanly@gmail.com)
</p>
