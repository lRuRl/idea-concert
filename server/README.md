# BACK-END GUIDELINE

본 프로젝트는 3-layer-structure를 공부하면서 구현한 프로젝트이다.
3 계층 구조 관련 게시글은 [**hopsprings2님의 블로그**](https://velog.io/@hopsprings2/%EA%B2%AC%EA%B3%A0%ED%95%9C-node.js-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%EC%95%84%ED%82%A4%ED%85%8D%EC%B3%90-%EC%84%A4%EA%B3%84%ED%95%98%EA%B8%B0)에서 확인할 수 있다.

## init project
1. .env 파일 생성하기
2. npm install

    package.json 이 있는 파일에서 `npm install`을 해주세요. 필요한 패키지가 다운이 됩니다.

현재 프로젝트는 express.js와 mongoose.js를 사용합니다. 그리고 파일을 데이터베이스에 저장하기 위해서 요청은 multipart로 진행하며 서버 내에서는 gridFS 방식을 사용한다.

최대한 유지보수의 비용을 단축하기 위해서 url의 end-point를 담당하는 api 디렉토리와 해당 서비스 작업을 진행하는 service 디렉토리로 나누었다.

어떠한 기능을 추가하거나 API를 수정할 필요가 있는 경우에는 API에서 url의 end-point를 작성하고 이에 해당하는 service를 services 디렉토리 안에서 수정할 수 있다. 

end-point를 담당하는 api > routes 안에서 path 및 서비스로 넘겨주는 parameter를 수정할 수 있다.

그리고 service에서 DB관련 작업을 할 수 있도록 진행한다. 현재 service에서는 multipart 작업을 진행하면서 중복되는 코드가 존재한다.

예를 들어서 현재까지 등록되어있는 전체 글을 읽어오는 경우에는 게시글마다 썸네일이 존재하기 때문에 데이터베이스 내에 존재하는 바이너리 파일을 버퍼로 서버에서 클라이언트로 넘겨준다. 현재 구현되어 있는 함수가 중복되어 사용되고 있다. 

디렉토리 별 설명을 이어가도록 하겠다.

## api
### middleware 
미들웨어는 multer를 사용해서 gridfs를 구현한 코드이다. 현재는 클라이언트 측에서 field 이름을 `file`으로 맞추어 사용하는 코드만 존재한다. 만약에 클라이언트에서 필드값을 수정해 사용할 경우 `multer.js` 내 코드를 수정해서 사용해야한다.

현재 데모 애플리케이션에서는 user와 article이 나누어져 있기때문에 구현되어있는 소스코드는 baseURL을 기준으로 collection이 나누어져 저장된다. 그 중에서도 image와 file로 나뉘기 때문에, 사용자의 포트폴리오와 같은 경우에는 files.files의 collection으로 저장된다. 

요약하자면 collection은 총 user와 article의 collection으로 나뉘며, user의 portfolio는 files란 collection으로 저장이 된다.

- user
    - files.files
    - files.chunks
    - users-images.files
    - users-images.chunks

- article
    - articles-images.files
    - articles-images.chunks

### routes
user와 article의 end-point를 설정한 디렉토리이다. CRUD를 기본으로 API가 구현되어있다. 클라이언트 내 기능은 구현되어 있지 않지만 API 상으로는 구현되있는 기능이 있어 사용하려면 url 내 path를 맞추어 사용할 수 있다. 

현재 소스코드 내에서는 주석으로 어떤 parameter가 요구되며 해당 메소드에 대한 정의가 작성되어 있다.

주의해야할 점은 PATCH를 사용하는 경우이다. 이때 미리 설정되어있는 상태값을 기준으로 코드를 작성했기 때문에 또 다시 명시를 하자면 아래와 같다.

어떤 게시글 내에 업무를 선택해 지원하는 경우는 승인대기(0), 승인거절(-1), 승인완료(1), 계약서대기(2), 계약서작성완료(3) 의 state로 관리를 해주었다. 

## config
dotenv를 사용해서 설정값을 내부에서 관리하고 외부로 노출시키지 않았다. `.env` 내에서 사용될 데이터베이스에 대해서 설정을 해주면된다.

## jobs
해당 디렉토리는 사용하지 않는다.

## loaders
현재 프로젝트 내에서는 express.js와 mongoose.js를 사용하기 때문에 두개의 기능을 init해주는 작업을 해주는 디렉토리이다.

## models
현재 프로젝트 내에서 사용되는 데이터베이스 내 모델들을 담은 곳이다. 현재는 article, file 그리고 user로 이루어져있는데, 이는 수정되어 사용될 수 있다. 수정이 되더라도 추가되는 부분은 service에서 코드를 추가하면 되므로 유지보수 차원에서 효율적이라고 생각했다. 

각 모델 내에서 sub 객체와 같은 경우에는 ObjectID를 생성하지 않도록 하였다.

*file과 같은 경우에는 gridFS로 자동생성되는 내용을 기반으로 모델을 구현하였다.*

## services
본 프로젝트의 작업을 가장 많이 담당하는 소스 코드 부분이다. service 내에서 중복되는 코드는 gridfs를 사용하여 분할된 데이터들을 한번에 담아서 클라이언트에게 반환해주는 작업이 사용될 때 발생한다. 이를 하나의 함수로 축약한다면 더 효율적인 코드가 탄생할 것으로 보인다. 

services 내에서는 DB작업을 함께 진행하므로 기능에 맞는 함수를 사용해야하며 `Array` 파싱으로는 `JSON.parse`를 이용해 클라이언트에서 요청되어서 올때 `jsonEncode()`를 사용하였다. 

중요한 기능 중에 하나는 이미지나 파일과 같이 Buffer로 값을 전달해야할 때 반환되는 result 값안에 buffer로 담아서 전송해야한다. buffer를 만들때는 collection내에 하나의 파일이 권장되는 사이즈를 넘길 경우 여러 파일로 분산되어 저장되기 때문에 이를 모두 합쳐서 전송해주어야한다.

MongoDB에서는 하나의 파일에 대해서 여러 document로 분산되어 저장될 경우, driver가 자동으로 n이란 property에 순번을 매겨서 작업해주기 때문에 이를 참고해서 buffer에 붙여주면 된다. 자세한 내용은 제 블로그에 작성해두었습니다. 

[블로그 바로가기 👉](https://velog.io/@seunghwanly/Flutter-Express.js-MongoDB-%ED%8C%8C%EC%9D%BC-%EC%97%85%EB%A1%9C%EB%93%9CFile-Upload-1)

## subscribers
해당 디렉토리는 사용하지 않는다.

## types
현재는 service에서 사용되는 return 값을 담당하고 있다. 서비스마다 return하는 status 값이 동일한 경우가 많기 때문에, not found | success | failure 이렇게 세개로 나누어서 작동하게 된다. 

예를 들어서 코드를 아래와 같이 작성할 수 있다.
```js
var onPostSuccess = (body) => {
    return {
        status: 200,
        result: {
            message: "[POST] msg received",
            result: body
        }
    };
}
```
반환값은 모두 Object내에서 `status`와 `result`를 담아 반환하도록 하였다. `status` 코드는 크게 `200`, `404` 그리고 `500`을 사용하였고 api > routes에서 요청값으로 올바르지 않을 값이 도착했을 때는 `400`을 반환하도록 하였다. `result`값 안에는 클라이언트가 알아볼 수 있도록 `message`를 설정해 결과가 어떻게 되었는지 알려주고 `result`안에는 요청한 `body`를 같이 반환하였다. 