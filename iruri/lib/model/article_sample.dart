import 'package:iruri/model/article.dart';

// sample data
// img path : 'https://i.ibb.co/1vXpqVs/flutter-logo.jpg'
// 'http://ideaconcert.com/resources/common/images/character_careers.png'
// 'https://picsum.photos/250?image=9'

List<Article> articleSampleData = [
  Article(
      id: '1',
      imagePath: 'https://picsum.photos/250?image=9',
      members: [],
      contracts: [],
      detail: Detail(
        status: '신청중',
        reportedDate: DateTime(2021, 04, 21, 00, 02).toIso8601String(),
        dueDate: DateTime(2021, 04, 30, 23, 59).toIso8601String(),
        period: Period(
            from: DateTime(2021, 05, 01, 00, 00).toIso8601String(),
            to: DateTime(2021, 11, 01, 00, 00).toIso8601String()),
        condition: Condition(
            contractType: '외주', projectType: '전속계약', wage: '91,100,000'),
        content: Content(
          title: '그림 및 글 작가 공고',
          desc: '석유 캐는 만화',
          tags: ['그림', '캐릭터', '채색', '글', '콘티'],
          prefer: '서울시 서초구 거주',
        ),
        writer: '쓰니',
        location: '서울 서초구 반포동',
      ))
];
