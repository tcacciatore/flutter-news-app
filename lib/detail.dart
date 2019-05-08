import 'package:flutter/material.dart';
import './model/Article.dart';
import 'package:cached_network_image/cached_network_image.dart';


class DetailWidget extends StatelessWidget {

  final Article article;
  static const String DEFAULT_IMAGE = "https://news.delta.com/sites/all/themes/delta_news_hub_omega/images/Apple_News_Icon.png";

  DetailWidget(this.article);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'detail',
      home: Scaffold(appBar: AppBar(title: Text('Detail')),
      body: Container(padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Text(this.article.title,
              style: TextStyle(fontSize: 25),),

        CachedNetworkImage(
          imageUrl: this.article.urlToImage != null ? this.article.urlToImage : DEFAULT_IMAGE,
          placeholder: (context, url) => new CircularProgressIndicator(),
          errorWidget: (context, url, error) => Image.asset('images/news_icon.png'),),

            Text(this.article.content,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),)

          ],
        ),
      ),),
    );
  }
  
}
