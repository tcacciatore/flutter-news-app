import 'package:flutter/material.dart';
import './../model/Article.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ArticleCell extends StatelessWidget {
  final Article article;

  static const String DEFAULT_IMAGE = "https://news.delta.com/sites/all/themes/delta_news_hub_omega/images/Apple_News_Icon.png";

  ArticleCell(this.article);

  @override
  Widget build(BuildContext context) {

    final shorterUrl = this.article.url.split('/')[2];

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(shorterUrl,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200)),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              this.article.title,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: CachedNetworkImage(
              imageUrl: this.article.urlToImage != null ? this.article.urlToImage : DEFAULT_IMAGE,
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => Image.asset('images/news_icon.png'),
            ),
          ),

        ],
      ),
    );
  }
}
