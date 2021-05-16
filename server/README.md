## [Notion 으로 보기](https://www.notion.so/Server-README-md-a9afc6ba9f064ebd857d76bbe82853a8)

# Node.js + Express.js + Mongoose.js 서버구축

[**hopsprings2님의 블로그**](https://velog.io/@hopsprings2/%EA%B2%AC%EA%B3%A0%ED%95%9C-node.js-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%EC%95%84%ED%82%A4%ED%85%8D%EC%B3%90-%EC%84%A4%EA%B3%84%ED%95%98%EA%B8%B0) 로 바로가기

3 Layer Architecture를 기반으로 이번에 사용할 RESTful API 서버를 만들어 보았습니다. 위에 블로그에서 공부를 하고 구축을 해보았는데, 저희 서버에 필요한 것들로 조금씩 변화를 주고 베이스 소스인 [bulletproof-nodejs](https://github.com/santiq/bulletproof-nodejs) 를 참고하였습니다.

## 폴더 구조

```
server
	📄  app.js       # App 시작점
	📁  api          # App에서 사용할 모든 endpoint를 위한 Express route controller
		📁  middleware # isUser, file-upload와 같은 작업을 담당
		📁  route      # endpoint 설정
	📁  config       # dot-env를 통해 필요한 환경변수를 담은 곳
	📁  loaders      # initializer
	📁  models       # 사용될 MongoDB model
	📁  services     # 사용될 비즈니스 로직 !
	📁  types        # service 계층에서 반환되는 타입 정렬
```

## 3 계층 설계 (3 Layer Architecture)란 무엇인가?

관심사 분리 원칙(principle of separation of concerns)를 적용하기 위해서 Business Logic을 API Routes와 분리해줍니다. services란 디렉토리를 따로 만들어서 route에서 분리를 해주었습니다.

```
Controller
↓      ↑
Service Layer
↓      ↑
Data Access Layer
```

```
Express Route Controller
↓      ↑
Service Class
↓      ↑
Mongoose ODM
```

예를 들어서 Express Route Controller 에서는 아래와 같은 작업만 해줍니다.

```jsx
// 2) R[Read]
    router.get('/', async (req, res) => {
        const { status, result } = await articleService.readAll();
        return res.status(status).send(result);
    })
```

articleService 란 service 계층에 선언되있는 service class를 통해서 작업이 이루어지게 됩니다.

```jsx
// read all
    readAll = async () => {
        try {
            // db query
            const res = await Article.find();
            return onGetSuccess(res);
        } catch (error) {
            console.error(error);
            return onGetFailure(err);
        }
    }
```

service 계층으로는 비즈니스 로직이 들어가게 됩니다. client으로 부터 도착한 request에 대해서 먼저 controller 계층에서 해주게 되면 해당 데이터를 가공해서 service 계층으로 전달하게됩니다. 

비즈니스 로직은 Service 계층에 있어야합니다. Service 계층으로 **req**와 **res** 객체를 전달하면 안됩니다. 그리고 `res.status(200).send({ msg : "Good" })` 과 같이 상태 코드 또는 헤더와 같은 HTTP 전송 계층과 관련된 것은 반환하면 안됩니다.

제가 공부한 블로그에서는 Pub/Sub 계층도 사용하면 좋다고 하였지만, handler나 listener를 구현하지 않아서 저는 사용하지 않았습니다.

---

### 해야할 일 (1) : 의존성 주입하기

```jsx
import UserModel from '../models/user';
import CompanyModel from '../models/company';
class UserService {
  constructor(){}
  Sigup(){
    // Caling UserMode, CompanyModel, etc
    ...
  }
}
```

```jsx
export default class UserService {
  constructor(userModel, companyModel){
    this.userModel = userModel;
    this.companyModel = companyModel;
  }
  getMyUser(userId){
    // models available throug 'this'
    const user = this.userModel.findById(userId);
    return user;
  }
}
```

다음과 같이 의존성을 주입해서 사용할 수 있지만, 서비스가 가질 수 있는 종속성의 양이 무한하며 새 인스턴스를 추가할 때 서비스의 모든 인스턴스화를 리팩토링하는 것은 오류를 범할 수 있습니다.  그래서 나온 npm 라이브러리, [typedi](https://www.npmjs.com/package/typedi) 가 있습니다. 해당 라이브러리는 typescript에서 사용하는 것으로 보여 사용하지 않았습니다.

### 해야할 일 (2) : Validator - Middleware 추가하기

이번 RESTful API 에서는 middelware로 따로 validation을 하지 않았고, model 에서도 마찬가지입니다. 우선은 Front-end에서 validation을 진행하는 것으로 하였습니다. 

다만, 필수적으로 들어가야하는 정보들은 설정을 해둔 상태입니다. 2021년 5월 12일 

### 해야할 일 (3) : Pub/Sub 패턴을 사용해 이벤트 발생시키기

백그라운드 작업을 할 때 효과적으로 작업을 할 수 있도록 event를 listen해 작업을 처리하는 것이 유용하다. 아직은 구현을 하지않은 상태입니다.

---

## 📁 config - 설정 및 .env 파일

**dotenv**를 사용하여 port나 API key와 관련된 설정들을 `.env` 파일에 저장하되 절대 `commit` 하지 않습니다. dotenv를 사용할 때는 항상 `dotenv.config();` 를 잊지말아주세요.

```jsx
const dotenv = require('dotenv');
/**
 *  variables of server
 *  author : @seunghwanly
 */
dotenv.config();    // read .env file

exports.config = {
    port: process.env.PORT,
    dbURI : process.env.DB_URI
}
```

현재 설정되어있는 .env 파일은 아래와 같습니다.

```jsx
PORT=3000
DB_URI=mongodb://127.0.0.1:27017/ideaconcert
```

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f4050fbf-f4c7-479f-93aa-210072405418/_2021-05-12__10.03.53.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f4050fbf-f4c7-479f-93aa-210072405418/_2021-05-12__10.03.53.png)

app.js 와 같은 디렉토리에 해당하도록 .env 파일을 생성해주세요.

## 📁 loaders - 간단한 목적들로 구성된 파일

loaders 안에는 현재 두개, Mongoose와 Express를 init하는 작업을 해주었습니다. 

```jsx
// express and mongoose
const expressLoader = require('./express');
const mongooseLoader = require('./mongoose');

module.exports = async(app) => {
    // db
    const mongoConnection = await mongooseLoader();
    console.log("MongoDB has initialized !");
    // express
    await expressLoader(app).then((result) => console.log('Express has initialized !'));
}
```

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/5b730e84-78c8-4ded-beb9-71d26c1e085b/_2021-05-12__9.56.07.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/5b730e84-78c8-4ded-beb9-71d26c1e085b/_2021-05-12__9.56.07.png)

위 코드로 init을 해주게 되면 server 시작과 함께 작동하면서 console.log에 출력해주었습니다.

---

## Database Import Files

[articles.json](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/45b64ed0-e974-41de-af7f-e778ab5c8aa5/articles.json)

[user-images.chunks.json](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/ded01b27-2835-46a4-9ae3-50bc2d5ae6be/user-images.chunks.json)

[user-images.files.json](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/43414ad7-a667-4cdb-a56b-013d443312f6/user-images.files.json)

[users.json](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/e1afc3a8-cb4d-4448-b2e3-612de32597b6/users.json)

---

## Postman API

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/98a76310-446d-4b47-b05b-071072281220/_2021-05-12__10.00.26.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/98a76310-446d-4b47-b05b-071072281220/_2021-05-12__10.00.26.png)

Article 과 User에 대한 API를 만들어서 테스트 해볼 수 있게 설정해두었습니다.

### 주의사항

현재 게시글 같은 경우, 썸네일이 필수적으로 들어가게 설정되어있습니다. 따라서 Postman에서는 thumbnail이 포함되어있지 않으면 에러 메세지가 반환될 것입니다. 

되도록이면 프론트와 연동해서 사용해주세요.

⚠️  현재 기능을 구현하다 필요한 기능이 생기면 바로 연락을 해주세요 🙂

[ideaconcert.postman_collection.json](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/852bdbfd-6ef3-481a-86ff-420d32ac0621/ideaconcert.postman_collection.json)
