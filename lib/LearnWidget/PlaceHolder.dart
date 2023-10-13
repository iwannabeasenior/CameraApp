import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
    home : SafeArea(
      child : Scaffold(
        body : Container(
          child : Placeholder(
            color : Colors.red,
            fallbackHeight: 20,
            fallbackWidth: 20,
            strokeWidth: 4,

          )
        )
      )
    )
  ));
}