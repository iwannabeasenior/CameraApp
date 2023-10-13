import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
    home : SafeArea(
      child: Scaffold(
        body : Center(
          child : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [MyContainer(),
                      Expanded(flex : 1, child: MyContainer()),
                      Expanded(flex : 2, child: MyContainer())],
          )
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