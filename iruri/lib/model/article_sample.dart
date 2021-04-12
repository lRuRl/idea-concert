import 'package:iruri/model/article.dart';

// sample data
// img path : 'https://i.ibb.co/1vXpqVs/flutter-logo.jpg'
// 'http://ideaconcert.com/resources/common/images/character_careers.png'
// 'https://picsum.photos/250?image=9'

List<Article> articleSampleData = [
  Article(
      id: '1',
      members: [],
      contracts: [],
      detail: Detail(
        status: '신청중',
        reportedDate: DateTime(2021, 04, 21, 00, 02),
        dueDate: DateTime(2021, 04, 30, 23, 59),
        periods: [
          DateTime(2021, 05, 01, 00, 00),
          DateTime(2021, 11, 01, 00, 00)
        ],
        condition: Condition(
            contractType: '외주', projectType: '일부계약', wage: '2,100,000'),
        content: Content(
            introduction: '그림 작가 공고',
            desc: '앞으로 접시를 10개씩 닦습니다.',
            tags: ['콘티', '데생'],
            prefer: '서울시 송파구 거주',
            imagePath: 'https://i.ibb.co/1vXpqVs/flutter-logo.jpg'),
        writer: '글쓴이',
        location: '서울 송파구 오금동',
        applicants: [],
      )),
  Article(
      id: '2',
      members: [],
      contracts: [],
      detail: Detail(
        status: '신청중',
        reportedDate: DateTime(2021, 04, 21, 00, 02),
        dueDate: DateTime(2021, 04, 30, 23, 59),
        periods: [
          DateTime(2021, 05, 01, 00, 00),
          DateTime(2021, 11, 01, 00, 00)
        ],
        condition: Condition(
            contractType: '외주', projectType: '일부계약', wage: '2,100,000'),
        content: Content(
            introduction: '그림 작가 공고',
            desc: '앞으로 접시를 10개씩 닦습니다.',
            tags: ['글', '데생', '채색'],
            prefer: '서울시 송파구 거주',
            imagePath:
                'https://cdn.pixabay.com/photo/2015/05/10/22/32/letter-761653_960_720.jpg'),
        writer: '글쓴이',
        location: '서울 송파구 잠실3동',
        applicants: [],
      )),
  Article(
      id: '3',
      members: [],
      contracts: [],
      detail: Detail(
        status: '신청중',
        reportedDate: DateTime(2021, 04, 21, 00, 02),
        dueDate: DateTime(2021, 04, 30, 23, 59),
        periods: [
          DateTime(2021, 05, 01, 00, 00),
          DateTime(2021, 11, 01, 00, 00)
        ],
        condition: Condition(
            contractType: '외주', projectType: '일부계약', wage: '9,100,000'),
        content: Content(
            introduction: '그림 작가 공고',
            desc: '앞으로 접시를 1000개씩 닦습니다.',
            tags: ['그림', '캐릭터', '채색'],
            prefer: '서울시 강남구 거주',
            imagePath:
                'https://images.unsplash.com/photo-1526498460520-4c246339dccb?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1650&q=80'),
        writer: '쓰니',
        location: '서울 강남구 일원동',
        applicants: [],
      )),
  Article(
      id: '4',
      members: [],
      contracts: [],
      detail: Detail(
        status: '신청중',
        reportedDate: DateTime(2021, 04, 21, 00, 02),
        dueDate: DateTime(2021, 04, 30, 23, 59),
        periods: [
          DateTime(2021, 05, 01, 00, 00),
          DateTime(2021, 11, 01, 00, 00)
        ],
        condition: Condition(
            contractType: '외주', projectType: '전속계약', wage: '91,100,000'),
        content: Content(
            introduction: '그림 및 글 작가 공고',
            desc: '석유 캐는 만화',
            tags: ['그림', '캐릭터', '채색', '글', '콘티'],
            prefer: '서울시 서초구 거주',
            imagePath: 'https://picsum.photos/250?image=9'),
        writer: '쓰니',
        location: '서울 서초구 반포동',
        applicants: [],
      ))
];
