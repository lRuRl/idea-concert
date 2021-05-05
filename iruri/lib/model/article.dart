/*
 *  게시글 : article document -> DB와 맞추기
 *
 */

class Article {
  final String id; // needs to be converted to <ObjectID>
  final List<String> members;
  final List<String> contracts;
  final Detail detail;
  
  Article(
      {this.id,
      this.contracts,
      this.members,
      this.detail});
}

// Detail Class
class Detail {
  final String status;
  final DateTime reportedDate;
  final DateTime dueDate;
  final List<DateTime> periods;
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
      this.periods,
      this.reportedDate,
      this.status,
      this.writer});
}

// Condition Class
class Condition {
  final String projectType;
  final String contractType;
  final String wage;

  Condition({this.contractType, this.projectType, this.wage});
}

// Content Class
class Content {
  final String title;
  final String desc;
  final List<String> tags;
  final String prefer;
  final String imagePath;

  Content(
      {this.desc, this.imagePath, this.title, this.prefer, this.tags});
}
