import 'package:flutter/material.dart';

class GifView extends StatelessWidget {
  final Map _gifData;

  GifView(this._gifData);

  void _showDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff4C4E52),
          title: new Text(
            "Share GIF",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: new Text(
            "This feature is under development!",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text(
                "Close",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
              // Share.share(_gifData['images']['fixed_height']['url']);
              _showDialog(context);
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
