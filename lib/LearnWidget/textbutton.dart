import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home : SafeArea(
      child : Scaffold(
        body : MyWidget(),
      )
    ),
    debugShowCheckedModeBanner: false,
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
    return Center(
      child: Container(
        margin: EdgeInsets.all(100),
        child: TextButton(
          onPressed: onPressedButton,
          style : TextButton.styleFrom(
            foregroundColor: Colors.green,
            backgroundColor: Colors.pink,
            // minimumSize: Size(30, 30),
            padding: EdgeInsets.all(100),
          ), child: Icon(Icons.add_a_photo_sharp)
        ),
      ),
    );
  }
  void onPressedButton() {
    print('text button');
  }
}