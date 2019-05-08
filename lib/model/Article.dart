class Article {
  String author = "";
  String title = "";

  Article({this.author, this.title});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      author: json['author'],
      title: json['title'],
    );
  }
}