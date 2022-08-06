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
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
      home: HomeView(),
    ),
  );
}
