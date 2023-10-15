import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
      home : SafeArea(
        child : Scaffold(
          body : GD(),
        )
      )
  ));
}
class GD extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GDState();
  }

}
class GDState extends State<GD> {
  double _scaleFactor = 1.0;
  double _baseScaleFactor = 1.0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (details) {
        _baseScaleFactor = _scaleFactor;
      },
      onScaleUpdate: (details) {
        print(MediaQuery.of(context).size.height);
        setState(() {
          _scaleFactor = _baseScaleFactor * details.scale;
        });
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.red,
        child: Center(
          child: Text(
            'Test',
            textScaleFactor: _scaleFactor,
          ),
        ),
      ),
    );
  }

}