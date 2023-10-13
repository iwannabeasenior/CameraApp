import 'package:flutter/material.dart';

void main() => runApp(Bookkeeper());

class Bookkeeper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          extendBody: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text("Title text"),
          ),
          bottomNavigationBar: menu(),
          body: TabBarView(
            children: [
              Container(child: Icon(Icons.directions_car)),
              Container(child: Icon(Icons.directions_transit)),
              Container(child: Icon(Icons.directions_bike)),
              Container(child: Icon(Icons.directions_bike)),
            ],
          ),
        ),
      ),
    );
  }

  Widget menu() {
    return Container(
      // color: Colors.transparent,
      color : Colors.tealAccent,
      child: TabBar(

        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Colors.blue,
        tabs: [
          Tab(
            text: "Transactions",
            icon: Icon(Icons.euro_symbol),
          ),
          Tab(
            text: "Bills",
            icon: Icon(Icons.assignment),
          ),
          Tab(
            text: "Balance",
            icon: Icon(Icons.account_balance_wallet),
          ),
          Tab(
            text: "Options",
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}