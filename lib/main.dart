import 'package:flutter/material.dart';
import 'package:scratch_and_win/scratch_and_win.dart';

void main(List<String> args) => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Scratch And Win",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: scratch_and_win(),
    );
  }
}
