import 'package:flutter/material.dart';
import 'package:ocw/add_form.dart';
import 'package:ocw/home_screen.dart';
 
void main() {
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/addForm': (context) => AddForm(),
      },
    );
  }
}