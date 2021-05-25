import 'dart:convert';

/**
 *  image는 데이터베이스에서 가져올 때 Buffer가 저장되는 곳 입니다.
 *  imagePath는 post할 때 데이터베이스에 저장되는 경로입니다.
 *  DateTime을 모두 String으로 변경하였습니다.
 *  Period class가 추가되었습니다.
 * 
 *  @seunghwanly 
 */
class Article {
  final String id; // needs to be converted to <ObjectID>
  final List<String> members;
  final List<String> contracts;
  final Detail detail;
  final String imagePath;
  final String image;

  Article(
      {this.id,
      this.contracts,
      this.members,
      this.detail,
      this.imagePath,
      this.image});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        id: json['_id'],
        image: json['image'],
        contracts:
            json['contracts'] != null ? List.from(json['contracts']) : [],
        members: json['members'] != null ? List.from(json['members']) : [],
        imagePath: json['imagePath'],
        detail: Detail.fromJson(json['detail']));
  }

  // for posting new article
  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'members': members,
        'contracts': contracts,
        'detail': detail.toJson()
      };
}

// Detail Class
class Detail {
  final String status;
  // final DateTime reportedDate;
  // final DateTime dueDate;
  final String reportedDate;
  final String dueDate;
  final Period period;
  final Condition condition;
  final Content content;
  final String writer;
  final String location;
  final Applicant applicant;

  Detail(
      {this.applicant,
      this.condition,
      this.content,
      this.dueDate,
      this.location,
      this.period,
      this.reportedDate,
      this.status,
      this.writer});

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
      period: Period.fromJson(json['period']),
      applicant: Applicant.fromJson(json['applicant']),
      reportedDate: json['reportedDate'],
      dueDate: json['dueDate'],
      status: json['status'],
      condition: Condition.fromJson(json['condition']),
      content: Content.fromJson(json['content']),
      writer: json['writer'],
      location: json['location']);

  Map<String, dynamic> toJson() => {
        'period': period.toJson(),
        'applicants': applicant.toJson(),
        // 'reportedDate': DateFormat("yyyy-MM-ddTHH:mm:ss").format(reportedDate),
        // 'dueDate': DateFormat("yyyy-MM-ddTHH:mm:ss").format(dueDate),
        "reportedDate": reportedDate,
        "dueDate": dueDate,
        'status': status,
        'condition': condition.toJson(),
        'content': content.toJson(),
        'writer': writer,
        'location': location
      };
}

// Condition Class
class Condition {
  final String projectType;
  final String contractType;
  final String wage;

  Condition({this.contractType, this.projectType, this.wage});

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
      contractType: json['contractType'],
      projectType: json['projectType'],
      wage: json['wage']);

  Map<String, String> toJson() =>
      {'contractType': contractType, 'projectType': projectType, 'wage': wage};
}

// Content Class
class Content {
  final String title;
  final String desc;
  final List<String> tags;
  final List<String> genres;
  final String prefer;

  Content({this.desc, this.title, this.prefer, this.tags, this.genres});

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        tags: List.from(json['tags']),
        genres: List.from(json['genres']),
        desc: json['desc'],
        prefer: json['prefer'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'tags': tags,
        'genres': genres,
        'desc': desc,
        'prefer': prefer,
        'title': title
      };
}

class Period {
  // final DateTime from;
  // final DateTime to;
  final String from;
  final String to;

  Period({this.from, this.to});

  factory Period.fromJson(Map<String, dynamic> json) => Period(
      // from: DateTime.parse(json['from']), to: DateTime.parse(json['to'])
      from: json['from'],
      to: json['to']);

  Map<String, String> toJson() => {
        // 'from': DateFormat("yyyy-MM-ddTHH:mm:ss").format(from),
        // 'to': DateFormat("yyyy-MM-ddTHH:mm:ss").format(to)
        "from": from,
        "to": to
      };
}

class Applicant {
  final List<String> writeMains; // 메인글
  final List<String> writeContis; // 글콘티
  final List<String> drawMains; // 메인그림
  final List<String> drawContis; // 그림콘티
  final List<String> drawDessins; // 그림뎃셍
  final List<String> drawLines; // 선화
  final List<String> drawChars; // 캐릭터
  final List<String> drawColors; // 채색
  final List<String> drawAfters; // 후보정

  Applicant(
      {this.drawAfters,
      this.drawChars,
      this.drawColors,
      this.drawContis,
      this.drawDessins,
      this.drawLines,
      this.drawMains,
      this.writeContis,
      this.writeMains});

  factory Applicant.fromJson(Map<String, dynamic> json) => Applicant(
        writeMains: List<String>.from(json['writeMains']),
        writeContis: List<String>.from(json['writeContis']),
        drawMains: List<String>.from(json['drawMains']),
        drawContis: List<String>.from(json['drawContis']),
        drawDessins: List<String>.from(json['drawDessins']),
        drawChars: List<String>.from(json['drawChars']),
        drawColors: List<String>.from(json['drawColors']),
        drawAfters: List<String>.from(json['drawAfters']),
        drawLines: List<String>.from(json['drawLines']),
      );

  Map<String, dynamic> toJson() => {
        "writeMains": jsonEncode(writeMains),
        "writeContis": jsonEncode(writeContis),
        "drawMains": jsonEncode(drawMains),
        "drawContis": jsonEncode(drawContis),
        "drawDessins": jsonEncode(drawDessins),
        "drawChars": jsonEncode(drawChars),
        "drawColors": jsonEncode(drawColors),
        "drawAfters": jsonEncode(drawAfters),
        "drawLines": jsonEncode(drawLines)
      };
}
