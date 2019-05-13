import 'package:flutter/material.dart';
import './model/Article.dart';
import './views/ArticleCell.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detail.dart';

/// Entry point for the app.
///
/// Provide the widget here.
void main() => runApp(NewsAppWidget());

/// Main widget
class NewsAppWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewsAppState();
  }
}

class NewsAppState extends State<NewsAppWidget> {
  /// Declare the api key for https://newsapi.org.
  static const API_KEY = "cbf0a7963df34c15a6c6ea38ba5da326";
  static const API_URL = "https://newsapi.org/v2";
  static const API_TOP_HEADLINE_URL = "top-headlines";

  /// Widget States.
  bool _isLoading = true;
  var _articles = [];

  @override
  initState() {
    super.initState();

    /// Retrieve articles when the widget is starting.
    _fetchArticles();
  }

  /// Fetch articles from a rest API.
  _fetchArticles() async {
    /// Refresh widget states.
    setState(() {
      _isLoading = true;
      this._articles = [];
    });

    var articles = [];

    /// Build the API url.
    final url = '$API_URL/$API_TOP_HEADLINE_URL?country=fr&apiKey=$API_KEY';
    print("requesting to $url");

    /// Get the response from get request.
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // SUCCESS !
      print(response.body);
      final responseMap = json.decode(response.body);
      final articlesJson = responseMap["articles"];

      // convert each json object to dart object.
      articlesJson.forEach((article) {
        articles.add(Article.fromJson(article));
      });
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load articles');
    }

    /// Update states.
    setState(() {
      _isLoading = false;
      this._articles = articles;
    });
  }

  /// Returns the list widget displaying articles.
  Widget _buildListViewArticle() {
    return

        /// This listview is bound to _articles state.
        ListView.builder(
      itemCount: this._articles != null ? this._articles.length : 0,
      itemBuilder: (context, pos) {
        final currentArticle = this._articles[pos];

        return Card(
          elevation: 2,
          margin: EdgeInsets.all(16),
          child: FlatButton(
            child: ArticleCell(currentArticle),
            padding: EdgeInsets.all(0),

            /// If the user is selecting a cell,
            /// push a new widget.
            onPressed: () {
              print("User selected the row at index $pos");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailWidget(currentArticle)));
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'news',
      home: Scaffold(
        appBar: AppBar(
          title: Text('news'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                print("Loading articles...");
                _fetchArticles();
              },
            )
          ],
        ),

        /// Display the articles list
        /// or a circular progress indicator if loading
        body: Center(
          child: _isLoading
              ? CircularProgressIndicator()
              : _buildListViewArticle(),
        ),
      ),
    );
  }
}
