import 'package:flutter/material.dart';
import 'package:share/share.dart';

class GifView extends StatelessWidget {
  final Map _gifData;

  GifView(this._gifData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff4C4E52),
      appBar: AppBar(
        backgroundColor: Color(0xff2E3033),
        title: Text(
          _gifData['title'],
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.white,
            ),
            onPressed: () {
              Share.share(_gifData['images']['fixed_height']['url']);
            },
          ),
        ],
      ),
      body: Center(
        child: Image.network(_gifData['images']['fixed_height']['url']),
      ),
    );
  }
}
