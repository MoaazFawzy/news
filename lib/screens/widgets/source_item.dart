import 'package:flutter/material.dart';
import 'package:news/models/SourcesResponse.dart';

class SourceItem extends StatelessWidget {
  Sources source;
  bool selected;

  SourceItem(this.source, this.selected);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: BoxDecoration(
          color: selected ? Color(0xFF39A552) : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Color(0xFF39A552), width: 2)),
      child: Text(
        source.name ?? "",
        style: TextStyle(color: selected ? Colors.white : Color(0xFF39A552)),
      ),
    );
  }
}
