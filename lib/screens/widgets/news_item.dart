import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/layout/details_screen.dart';
import 'package:news/models/NewsResponse.dart';

class NewsItem extends StatelessWidget {
  Articles article;

  NewsItem(this.article);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailsScreen.routName,
            arguments: article);
      },
      child: Card(
        elevation: 16,
        margin: EdgeInsets.all(8),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.transparent)),
        child: Container(
          padding: EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
                child: CachedNetworkImage(
                  imageUrl: article.urlToImage ?? "",
                  height: 160,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Text(
                article.title ?? "",
                style: TextStyle(fontSize: 16, color: Color(0xff707070)),
                maxLines: 2,
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                article.description ?? "",
                style: TextStyle(fontSize: 13, color: Colors.black45),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                article.author ?? "",
                style: TextStyle(fontSize: 8, color: Colors.black),
              ),
              Text(
                article.publishedAt?.substring(0, 10) ?? "",
                style: TextStyle(fontSize: 13, color: Colors.black45),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
