import 'package:flutter/material.dart';
import 'package:news/models/category_model.dart';
import 'package:news/screens/categories.dart';
import 'package:news/screens/drawer_widget.dart';
import 'package:news/screens/news_Screen.dart';

import '../screens/widgets/news_item.dart';
import '../shared/network/remote/api_manager.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();
  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: isSearch ? null : DrawerWidget(onDrawerClicked),
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
        title: isSearch
            ? TextField(
                controller: controller,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    prefixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isSearch = false;
                        });
                      },
                      icon: Icon(
                        Icons.clear,
                        color: Colors.green,
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          controller.clear();
                        });
                      },
                      icon: Icon(
                        Icons.search,
                        color: Colors.green,
                      ),
                    ),
                    hintStyle: TextStyle(
                      fontSize: 25,
                      color: Colors.grey,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Search..."),
              )
            : Text(categoryModel == null ? "News App" : categoryModel!.name),
        actions: !isSearch
            ? categoryModel != null
                ? [
                    IconButton(
                        onPressed: () {
                          // showSearch(context: context, delegate: NewsSearshDelegate());
                          setState(() {
                            isSearch = true;
                          });
                        },
                        iconSize: 25,
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ))
                  ]
                : null
            : null,
      ),
      body: categoryModel == null
          ? CategoriesScreen(onCategorySelected)
          : NewsScreen(categoryModel!, controller.text),
    );
  }

  CategoryModel? categoryModel = null;

  void onDrawerClicked(number) {
    if (number == DrawerWidget.CATEGORY) {
      categoryModel = null;
    } else if (number == DrawerWidget.SETTINGS) {
      // open settings tab
    }
    setState(() {
      Navigator.pop(context);
    });
  }

  void onCategorySelected(category) {
    categoryModel = category;
    setState(() {});
  }
}

class NewsSearshDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(
          Icons.clear,
          color: Colors.green,
          size: 25,
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back,
        color: Colors.green,
        size: 25,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    print(query);
    return FutureBuilder(
      future: ApiManager.getNewsData("", q: query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Column(
            children: [
              Text("something went wrong"),
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
              Text(snapshot.data?.message ?? ""),
              TextButton(
                onPressed: () {},
                child: Text("Try Again"),
              )
            ],
          );
        }
        var newsData = snapshot.data?.articles ?? [];
        return ListView.builder(
          itemBuilder: (context, index) {
            return NewsItem(newsData[index]);
          },
          itemCount: newsData.length,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text("suggestions"),
    );
  }
}
