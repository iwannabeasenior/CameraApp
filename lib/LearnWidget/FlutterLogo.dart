import 'dart:ffi';

import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
    home : SafeArea(
      child : Scaffold(
        body: Center(
          child : FlutterLogo(
            size : 100,
            style: FlutterLogoStyle.stacked,
            curve: Curves.bounceInOut,
            duration: Duration(seconds : 5),
          )
        ),
      )
    )
  ));
}