> [**hopsprings2 velog**](https://velog.io/@hopsprings2/%EA%B2%AC%EA%B3%A0%ED%95%9C-node.js-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%EC%95%84%ED%82%A4%ED%85%8D%EC%B3%90-%EC%84%A4%EA%B3%84%ED%95%98%EA%B8%B0)로 바로가기

```
src
│   app.js          # App entry point
└───api             # Express route controllers for all the endpoints of the app
└───config          # Environment variables and configuration related stuff
└───jobs            # Jobs definitions for agenda.js
└───loaders         # Split the startup process into modules
└───models          # Database models
└───services        # All the business logic is here
└───subscribers     # Event handlers for async task
└───types           # Type declaration files (d.ts) for Typescript
```

api 
- routes : ex) '/signup' 과 같은 routing 기능
- middlewares : 예를 들어 헤더 작업이나 사용자를 현재 요청된 사용자로 붙인다는 작업, 신원확인 등
한 마디로 route를 통해서 어떤 결과를 얻는 것이 아닌 중간에 필요한 작업을 하는 곳
가장 좋은 예시는 로그아웃을 할 때 현재 로그인 되있는 사용자의 신원을 확인 하는 것 !

api/route/ 에서 작업을 할 때 req로 값을 celebrate로 넘겨준다면 프론트엔드 dev에서도 API 엔드포인트가 어떻게 되었는지 확인가능하다는 장점이있음
[celebrate](https://github.com/arb/celebrate)