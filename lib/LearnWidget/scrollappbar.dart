import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
    home : SafeArea(
      child : Scaffold(
        appBar: AppBar(
          title: Text('hello1'),
        ),

        body : CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 150,
              pinned: true,
              snap : true,
              floating: true,
              title: Text('hello'),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index ) {
                  return Container(
                    color: index.isOdd ? Colors.white : Colors.black12,
                    height: 100.0,
                    child: Center(
                      child: Text('$index', textScaleFactor: 5),
                    ),
                  );
                },
                childCount: 20,

             ),
          ),

          ],
        )
      )
    )
  ));
}