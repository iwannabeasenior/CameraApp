import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
    home : SafeArea(
      child: Scaffold(
        body : MyWidget(),
      ),
    ),
    debugShowCheckedModeBanner: false,
  ));
}
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan> [
              TextSpan(text : 'hello'),
              TextSpan(text : 'bold', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), ),
              TextSpan(text: 'world', )
            ]
          )
      ),
    );
  }
  
}