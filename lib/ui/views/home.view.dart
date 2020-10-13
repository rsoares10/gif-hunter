import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gif_searcher/ui/views/gif.view.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _textEditCtrl = TextEditingController();
  String _search;
  int _offset = 0;

  _getGigs() async {
    Response response;
    if (_search == null || _search.isEmpty) {
      response = await Dio().get('https://api.giphy.com/v1/gifs/trending?api_key=nFpRCivJ74jdZjHMPgp2qsKDobPWhE4e&limit=20&rating=g');
    } else {
      response = await Dio()
          .get('https://api.giphy.com/v1/gifs/search?api_key=nFpRCivJ74jdZjHMPgp2qsKDobPWhE4e&q=$_search &limit=19&offset=$_offset&rating=g&lang=en');
    }
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image(
          image: NetworkImage('https://developers.giphy.com/branch/master/static/header-logo-8974b8ae658f704a5b48a2d039b8ad93.gif'),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: _textEditCtrl,
              onSubmitted: (text) {
                setState(() {
                  _search = text;
                  _offset = 0;
                });
              },
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search here',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _getGigs(),
              builder: (context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                      height: 200.0,
                      width: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5.0,
                      ),
                    );
                  default:
                    if (snapshot.hasError) {
                      return Container();
                    } else {
                      return _createGigTable(context, snapshot);
                    }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  int _getCount(List data) {
    if (_search == null) {
      return data.length;
    } else {
      return data.length + 1;
    }
  }

  Widget _createGigTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: _getCount(snapshot.data['data']),
      itemBuilder: (context, index) {
        if (_search == null || index < snapshot.data['data'].length) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return GifView(snapshot.data['data'][index]);
                  },
                ),
              );
            },
            onLongPress: () {
              Share.share(snapshot.data['data'][index]['images']['fixed_height']['url']);
            },
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: snapshot.data['data'][index]['images']['fixed_height']['url'],
              height: 300.0,
              fit: BoxFit.cover,
            ),
          );
        } else {
          return Container(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _offset += 19;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 70.0,
                  ),
                  Text(
                    'Load more...',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
