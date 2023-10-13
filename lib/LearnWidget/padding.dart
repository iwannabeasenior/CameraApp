import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home : SafeArea(
      child : Scaffold(
        body : MyWidget(),
      )
    )
  ));
}
class MyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyWidgetState();
  }
}
class MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Card(
      color : Colors.pink,
      margin: EdgeInsets.all(200),
      child : Padding(
        padding: EdgeInsets.symmetric(vertical : 100, horizontal: 100),
        child: Text('TinCoder',
                      style: TextStyle(
                          fontSize: 30,
                          color : Colors.white)),
      ),
    );
  }
}