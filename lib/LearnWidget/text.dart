import 'package:flutter/material.dart';
void main() {
  runApp( MaterialApp(
    theme: ThemeData(fontFamily: 'DancingScript'),
    home : SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.red,
          title: Text('Nguyen Trung Thanh'),
        ),
        body: MyText(),
      ),
    ),
    debugShowCheckedModeBanner: false,
  ),);
}
class MyText extends StatelessWidget{
  @override

  Widget build(BuildContext context) {
    return const Text('Lunar New Year Festival often falls between late January and '
        'early February; it is among the most important holidays in Vietnam. '
        'Officially, the festival includes the 1st, 2nd, and 3rd day in Lunar '
        'Calendar; however, Vietnamese people often spend nearly a month '
        'celebrating this special event. Tet Holiday gets its beginning marked '
        'with the first day in the Lunar Year; however, its preparation starts '
        'long before that. The 23rd day of the last Lunar month is East Day—a '
        'ritual worshiping Kitchen Gods (Tao Cong). It thought that each year '
        'on this day, these Gods go to heaven to tell Jade Emperor about all '
        'activities of households on earth. On New Year’s Eve, they return '
        'home to continue their duties as taking care of families.',
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.justify,
      maxLines: 5,
      overflow: TextOverflow.visible,
      textScaleFactor: 2,
      style: TextStyle(
        color : Colors.pink,
        backgroundColor: Colors.green,
        fontSize: 10,
        fontWeight: FontWeight.w100,
        fontStyle: FontStyle.italic,
        fontFamily: 'Times New Roman',
        wordSpacing: 10,
        // letterSpacing: 10,
        // decoration: TextDecoration.lineThrough
      ),
    );
  }
}