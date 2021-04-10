class Article {
  final String imagePath; // thumbnail image path
  final String title; // article title in bold text
  final List<String> tags; // article prefered tags as list
  final String writer; // article written by
  final String dueDate; // show dueDate in red color

  Article({this.dueDate, this.imagePath, this.tags, this.title, this.writer});
}
