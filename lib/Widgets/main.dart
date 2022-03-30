import 'package:flutter/material.dart';
import 'package:tik_toe/Screens/Splash_Screen.dart';

void main() {
  runApp( MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(

     home: Splash(),
      debugShowCheckedModeBanner: false,
    );

  }
}


