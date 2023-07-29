import 'package:flutter/material.dart';
import 'package:news/models/category_model.dart';
import 'package:news/screens/tabs_screen.dart';
import 'package:news/shared/network/remote/api_manager.dart';

class NewsScreen extends StatelessWidget {
  CategoryModel categoryModel;
  String quary;

  NewsScreen(this.categoryModel, this.quary);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getSources(categoryModel.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Column(
            children: [
              Text("Something went wrong"),
              TextButton(
                onPressed: () {},
                child: Text("Try Again"),
              )
            ],
          );
        }

        if (snapshot.data?.status != "ok") {
          return Column(
            children: [
              Text("Error ..!!"),
              TextButton(
                onPressed: () {},
                child: Text("Try Again"),
              )
            ],
          );
        }
        var sources = snapshot.data?.sources ?? [];
        return TabsScreen(sources, quary);
      },
    );
  }
}
