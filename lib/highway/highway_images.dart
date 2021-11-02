import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HighwayImages extends StatefulWidget {
  final String highwayName;
  final String htmlView;
  HighwayImages({required this.highwayName, required this.htmlView});

  @override
  _HighwayImagesState createState() => _HighwayImagesState();
}

class _HighwayImagesState extends State<HighwayImages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.highwayName + ' Situation'),
        backgroundColor: Colors.blueGrey.shade800,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Html(data: widget.htmlView),
        ),
      ),
    );
  }
}
