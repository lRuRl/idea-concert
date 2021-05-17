/*
 *  게시글 : article document -> DB와 맞추기
 *
 */

class Article {
  final String id; // needs to be converted to <ObjectID>
  final List<String> members;
  final List<String> contracts;
  final Detail detail;
  final String imagePath;

  Article({this.id, this.contracts, this.members, this.detail, this.imagePath});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        id: json['_id'],
        contracts: List.from(json['contracts']),
        members: List.from(json['members']),
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
  final DateTime reportedDate;
  final DateTime dueDate;
  final Period period;
  final Condition condition;
  final Content content;
  final String writer;
  final String location;
  final List<String> applicants;

  Detail(
      {this.applicants,
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
      applicants: List.from(json['applicants']),
      reportedDate:
          DateTime.parse(json['reportedDate']), // "2021-04-21T00:02:00.000Z"
      dueDate: DateTime.parse(json['dueDate']),
      status: json['status'],
      condition: Condition.fromJson(json['condition']),
      content: Content.fromJson(json['content']),
      writer: json['writer'],
      location: json['location']);

  Map<String, dynamic> toJson() => {
        'period': period.toJson(),
        'applicants': applicants,
        'reportedDate': reportedDate.toIso8601String(),
        'dueDate': dueDate.toIso8601String(),
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

  Map<String, dynamic> toJson() =>
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
  final DateTime from;
  final DateTime to;

  Period({this.from, this.to});

  factory Period.fromJson(Map<String, dynamic> json) => Period(
      from: DateTime.parse(json['from']), to: DateTime.parse(json['to']));

  Map<String, dynamic> toJson() =>
      {'from': from.toIso8601String(), 'to': to.toIso8601String()};
}
