import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
    home : SafeArea(
      child : Scaffold(
        body : Stack(
          alignment: Alignment.topLeft,
          textDirection: TextDirection.ltr,
          fit: StackFit.passthrough,
          clipBehavior: Clip.antiAlias,
          
          children: [
            Positioned(child: Container(
              child: Image.asset('assets/image/welcome.jpg'),
              color: Colors.blue,
            ),
            top : 20,),

            Positioned(child: Container(
                child : Text('Viet Nam'),
                color : Colors.green
            ),
            top : 50,
            left : 50),
          ],
        )
      )
    )
  ));
}