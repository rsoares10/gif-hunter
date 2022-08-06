import 'package:flutter/material.dart';
import 'ui/views/home.view.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'GIF Searcher',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffE6EEF7)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffE6EEF7)),
          ),
        ),
      ),
      home: HomeView(),
    ),
  );
}
