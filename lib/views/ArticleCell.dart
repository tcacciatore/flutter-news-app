import 'package:flutter/material.dart';
import './../model/Article.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ArticleCell extends StatelessWidget {
  final Article article;

  /// Default image in case the article image is missing.
  static const String DEFAULT_IMAGE =
      "https://news.delta.com/sites/all/themes/delta_news_hub_omega/images/Apple_News_Icon.png";

  /// Widget constructor.
  ArticleCell(this.article);

  @override
  Widget build(BuildContext context) {
    /// Extract www.websiteName.com from the complete url.
    final shorterUrl = this.article.url.split('/')[2];

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// Display the shorter url.
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(shorterUrl,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200)),
          ),

          /// Display the title.
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              this.article.title,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20),
            ),
          ),

          /// Display the image.
          Container(
            alignment: Alignment(0.0, 0.0),
            child: CachedNetworkImage(
              imageUrl: this.article.urlToImage != null
                  ? this.article.urlToImage
                  : DEFAULT_IMAGE,
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  Image.asset('images/news_icon.png'),
            ),
          ),
        ],
      ),
    );
  }
}
