import 'package:flutter/material.dart';
import 'package:news/layout/details_screen.dart';
import 'package:news/layout/home.dart';
import 'package:news/layout/web_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        DetailsScreen.routName: (context) => DetailsScreen(),
        WebViewScreen.routName: (context) => WebViewScreen(),
      },
    );
  }
}
