import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
    home : Container(
      margin : EdgeInsets.all(30),
      // color: Colors.green,
      child: Text('hello world',),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green
      ),

    )
  ));
}