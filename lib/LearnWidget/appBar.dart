import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
    theme: ThemeData(useMaterial3: true),
    home : DefaultTabController(
      initialIndex: 1,
      length: 4,
      child : Scaffold(
        // bottomNavigationBar: AppBar(
        //   title: const Text('Weather today'),
        //   flexibleSpace: Container(
        //     child : Text('space'),
        //   ),
        //   bottom: const TabBar(
        //     tabs: [
        //       Tab(
        //         icon: Icon(Icons.cloud_outlined),
        //       ),
        //       Tab(
        //         icon: Icon(Icons.beach_access_sharp),
        //       ),
        //       Tab(
        //         icon: Icon(Icons.brightness_5_sharp),
        //       ),
        //     ],
        //
        //   ),
        // ),
        appBar: AppBar(

          title: const Text('Weather today'),
          flexibleSpace: Container(
            child : Text('space'),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.cloud_outlined),
              ),
              Tab(
                icon: Icon(Icons.beach_access_sharp),
              ),
              Tab(
                icon: Icon(Icons.brightness_5_sharp),
              ),
            ],

          ),
        ),
        body : const TabBarView(
            children: <Widget>[
                Center(
                  child: Text("It's cloudy here"),
                ),
                Center(
                  child: Text("It's rainy here"),
                ),
                Center(
                  child: Text("It's sunny here"),
                ),


            ]
        )
      )

    ),
  ));
}