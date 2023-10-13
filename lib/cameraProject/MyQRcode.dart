import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
void main() {
    runApp(
        MaterialApp(
            home : Scaffold(
                body : MyQR()
            )

        )
    );
}
class MyQR extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
      return MyQRState();
  }

}
class MyQRState extends State<MyQR> {
  String result = '';
  late QRViewController controller;
  GlobalKey key = GlobalKey(debugLabel: "QR");
  _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) => result = scanData.code!);
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        QRView(
            key: key,
            onQRViewCreated: _onQRViewCreated),
        Container(
          child: Row(
             children: [
               ElevatedButton(onPressed: () {
                 if (result.isNotEmpty)
                 Clipboard.setData(ClipboardData(text: result));
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('copied')));
               }, child: Icon(Icons.copy)),
               ElevatedButton(onPressed: () {

               }, child: Icon(Icons.open_in_new))
             ],
          )
        )
      ],
    );
  }

}