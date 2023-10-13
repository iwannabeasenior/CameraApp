import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
    theme: ThemeData(

    ),
    home : SafeArea(
      child : Scaffold(

        body  : Container(

          child: MyWidget(
            child : MyWidgetChild(),
          ),
        ),
        ),
      )
    )
  );
}
class MyWidget extends StatelessWidget {
  MyWidget({this.child});
  Widget? child;
  static MyWidget of (BuildContext context) {
    return context.findAncestorRenderObjectOfType() as MyWidget;
  }
  @override
  Widget build(BuildContext context) {
      return Text('');
  }
  void function() {}
}

class MyWidgetChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyWidget myWidget = MyWidget.of(context);
    myWidget.function();
    return Text('',
    style: Theme.of(context).textTheme.headlineLarge,);

  }

}