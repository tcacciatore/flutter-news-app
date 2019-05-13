import 'package:flutter/material.dart';
import './model/Article.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailWidget extends StatelessWidget {
  final Article article;

  /// Default image in case the article image is missing.
  static const String DEFAULT_IMAGE =
      "https://news.delta.com/sites/all/themes/delta_news_hub_omega/images/Apple_News_Icon.png";

  /// The widget constructor.
  DetailWidget(this.article);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'detail',
      home: Scaffold(
        appBar: AppBar(

            /// Top bar button
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),

                /// If the user is selecting the back button,
                /// it pops the current widget.
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text('Detail')),

        body:
        SingleChildScrollView(child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Text(
                this.article.title != null ? this.article.title : "",
                style: TextStyle(fontSize: 25),
              ),

              /// Load the article image asynchronously
              /// Display a circular progress indicator during the
              /// loading.
              CachedNetworkImage(
                imageUrl: this.article.urlToImage != null
                    ? this.article.urlToImage
                    : DEFAULT_IMAGE,
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    Image.asset('images/news_icon.png'),
              ),

              /// Display the article content.
              Text(
                this.article.content != null ? this.article.content : "",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              )
            ],
          ),
        ),)

      ),
    );
  }
}
