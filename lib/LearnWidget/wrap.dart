import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
    home : SafeArea(
      child: Scaffold(
        body : Wrap(
          runSpacing: 30,
          direction: Axis.vertical,
          alignment: WrapAlignment.center,
          children: <Widget>[MyContainer(),
            MyContainer(),MyContainer(),MyContainer(),MyContainer(),MyContainer(),
            MyContainer(),MyContainer(),MyContainer(),MyContainer(),MyContainer(),
            MyContainer()],
        )
      ),
    )
  ));
}
class MyContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      width: 50,
      height: 50,
      color: Colors.red,
    );
  }

}