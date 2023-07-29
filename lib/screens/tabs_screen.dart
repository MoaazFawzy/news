import 'package:flutter/material.dart';
import 'package:news/models/SourcesResponse.dart';
import 'package:news/screens/widgets/news_item.dart';
import 'package:news/screens/widgets/source_item.dart';

import '../shared/network/remote/api_manager.dart';

class TabsScreen extends StatefulWidget {
  List<Sources> sources;
  String quary;

  TabsScreen(this.sources, this.quary);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
            length: widget.sources.length,
            child: TabBar(
                isScrollable: true,
                indicatorColor: Colors.transparent,
                onTap: (value) {
                  selectedIndex = value;
                  setState(() {});
                },
                tabs: widget.sources.map((source) {
                  return Tab(
                    child: SourceItem(source,
                        widget.sources.indexOf(source) == selectedIndex),
                  );
                }).toList())),
        FutureBuilder(
          future: ApiManager.getNewsData(widget.sources[selectedIndex].id ?? "",
              q: widget.quary),
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
            return Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return NewsItem(newsData[index]);
                },
                itemCount: newsData.length,
              ),
            );
          },
        )
      ],
    );
  }
}
