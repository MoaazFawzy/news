import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  Function onDrawerClick;

  DrawerWidget(this.onDrawerClick);

  static int CATEGORY = 1;
  static int SETTINGS = 2;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * .7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 40.0,
                ),
                color: Color(0xFF39A552),
                child: Center(
                  child: Text(
                    "News App!",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                )),
            InkWell(
              onTap: () {
                onDrawerClick(CATEGORY);
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("Categories"),
              ),
            ),
            InkWell(
              onTap: () {
                onDrawerClick(SETTINGS);
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("Settings"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
