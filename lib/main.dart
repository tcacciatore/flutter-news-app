import 'package:flutter/material.dart';
import './model/Article.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(NewsAppWidget());

class NewsAppWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewsAppState();
  }
}

class NewsAppState extends State<NewsAppWidget> {

  // Declare the api key for https://newsapi.org.
  static const API_KEY = "cbf0a7963df34c15a6c6ea38ba5da326";
  static const API_URL = "https://newsapi.org/v2";
  static const API_TOP_HEADLINE_URL = "top-headlines";


  // States.
  bool _isLoading = true;
  var _articles = [];

  _fetchPost() async {

    var articles = [];
    final url = '$API_URL/$API_TOP_HEADLINE_URL?country=fr&apiKey=$API_KEY';
    print("requesting to $url");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      print(response.body);
      final responseMap = json.decode(response.body);
      final articlesJson = responseMap["articles"];

      // convert each json object to dart object.
      articlesJson.forEach((article) {
        articles.add(Article.fromJson(article));
      });



    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }

    setState(() {
      _isLoading = false;
      this._articles = articles;

    });
  }

  Widget _buildListViewArticle() {

    // Get fake articles.
    var articles = [
    Article(author: "Le parisien",title:  "Accident sur l'A1"),
    Article(author: "Paris Match",title:  "Rzaaia"),
    Article(author: "Le Figaro",title:  "ss zdajid eizde"),
    Article(author: "Le parisien",title:  "Nawak !")

    ];


    return ListView.builder(
      itemCount: this._articles != null ? this._articles.length : 0,
      itemBuilder: (context, pos) {
      final currentArticle = this._articles[pos];
      return Column(children: <Widget>[
        Text(currentArticle.title),
        Divider(),
    ],);
    },);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'news',
      home: Scaffold(
        appBar: AppBar(
          title: Text('news'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh),
            onPressed: () {
              print("Loading articles...");
              _fetchPost();
            },)
          ],
        ),
        body: Center(
        child: _isLoading ? CircularProgressIndicator() : _buildListViewArticle(),),
      ),
    );
  }
}
