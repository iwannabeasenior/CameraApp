import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled/CameraProjectNew/Login.dart';
import 'package:untitled/CameraProjectNew/Settings.dart';
import '../firebase/repos/userRepos/firebase_options.dart';
import 'QRcode.dart';
import 'package:untitled/CameraProjectNew/Image.dart';
import 'package:untitled/CameraProjectNew/Video.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home : SafeArea(
        child: Scaffold(
          body: Login(),
        ),
      )
  ));
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
      return HomeState();
  }

}
class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
      return SafeArea(
          child: DefaultTabController(
            length: 4 ,
            child: Scaffold(
                extendBody: false,
                extendBodyBehindAppBar: true,
                // appBar: AppBar(
                //   backgroundColor: Colors.black12.withOpacity(0.05),
                // ),
                drawer: const Drawer(
                  child : Icon(Icons.add_alert),
                ) ,
                bottomNavigationBar: menu(),
                body : const TabBarView(
                  children: [
                    CameraPage1(),//image
                    CameraPage2(),//video
                    QRcode(),
                    Setting(),
                  ],
                )
            )
      ));
  }

}
Widget menu() {
  return Container(
    color : Colors.black54,
    child: const TabBar(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white70,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorPadding: EdgeInsets.all(5.0),
      indicatorColor: Colors.blue,
      tabs: [
        Tab(
          text: "Ảnh",
          icon: Icon(Icons.add_a_photo),
        ),
        Tab(
          text: "Video",
          icon: Icon(Icons.circle), // add stop
        ),
        Tab(
          text: "QR Code",
          icon: Icon(Icons.qr_code),
        ),
        Tab(
          text: "Options",
          icon: Icon(Icons.settings),
        ),
      ],
    ),
  );
}
// login
