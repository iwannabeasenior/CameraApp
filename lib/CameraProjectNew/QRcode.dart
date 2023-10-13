import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MaterialApp(
    home : QRcode(),
  ));
}

class QRcode extends StatefulWidget {
  const QRcode({Key? key}) : super(key : key);
  @override
  State<StatefulWidget> createState() {
    return QRcodeState();
  }

}
class QRcodeState extends State<QRcode> {
  final GlobalKey qrKey = GlobalKey(debugLabel: "QR");
  QRViewController? controller;
  String result = "";
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData.code!;
      });
    });
  }
  @override
  Widget build(BuildContext context) {

      return Scaffold(
        // appBar: AppBar(
        //   title: Text('QR code'),
        // ),
        body: Column(
          children: [
            Expanded(
                flex : 5,
                child: QRView(
                  key : qrKey,
                  onQRViewCreated: _onQRViewCreated ,
                )),
            Expanded(
                flex : 1,
                child: Center(
                  child: Text('Scan Result : $result',
                                    style: const TextStyle(
                                      fontSize: 18
                                    ),),
                )),
            Expanded(
                  child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: () {
                          if (result.isNotEmpty) {
                            Clipboard.setData(ClipboardData(text: result));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Copied to Clipboard'))
                            );
                          }
                        }, child: const Icon(Icons.copy)
                      ),
                      ElevatedButton(
                          onPressed: () async {

                            if (result.isNotEmpty) {
                              final Uri _url = Uri.parse(result);
                              await launchUrl(_url);
                            }
                          }, child: const Icon(Icons.open_in_new)),
                    ],
                  ),
                )
          ],
        ),
      );
  }

}