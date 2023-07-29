import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/layout/web_screen.dart';
import 'package:news/models/NewsResponse.dart';

class DetailsScreen extends StatelessWidget {
  static const String routName = 'DetailsScreen';

  @override
  Widget build(BuildContext context) {
    var artical = ModalRoute.of(context)?.settings.arguments as Articles;
    var date = DateTime.parse(artical.publishedAt ?? "");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(22),
              bottomRight: Radius.circular(22),
            )),
        backgroundColor: Color(0xFF39A552),
        title: Text(artical.title ?? ""),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            CachedNetworkImage(
              imageUrl: artical.urlToImage ?? "",
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, provider) => Center(
                child: Icon(
                  Icons.error,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              artical.source?.name ?? "",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff707070),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              artical.title ?? "",
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 13,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "${date.year}-${date.month}-${date.day}",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                artical.content ?? "",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, WebViewScreen.routName,
                    arguments: artical);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "View this artical",
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: Colors.black,
                    size: 40,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
