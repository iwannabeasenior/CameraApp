
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:video_player/video_player.dart';
import '../font/my_flutter_app_icons.dart';
import '../font/flash_icon.dart';
import 'package:share_plus/share_plus.dart';
class CameraPage1 extends StatefulWidget {
  const CameraPage1({Key? key}) : super(key : key);
  @override
  State<StatefulWidget> createState() {
    return CameraPageState();
  }
}
class CameraPageState extends State<CameraPage1> {

  //zoom
  double zoom = 0.1;
  //flash
  late IconData flashIcon;
  FlashMode flashMode = FlashMode.off;
  // time
  late IconData timeIcon;
  int time = 0;

  late  VideoPlayerController videoPlayerController;
  late CameraController cameraController;
  late List<CameraDescription>cameras;
  bool _isLoading = true;
  bool _isRecording = false;
  final ImagePicker picker = ImagePicker();
  double _baseScaleFactor = 1.0;
  @override
  Widget build(BuildContext context) {

    if (_isLoading) {
      return Container(
        color : Colors.black,
        child : const Center(
          child : CircularProgressIndicator(),
        ),
      );
    } else {
      return Stack(
        fit: StackFit.expand,
            // alignment: Alignment.bottomCenter,
            children : [
              GestureDetector(

                onScaleStart: (details) {
                    _baseScaleFactor = zoom;
                },
                onScaleUpdate: (details) {
                  setState(() {
                    print(details.scale);
                    zoom = _baseScaleFactor * details.scale;
                    if (zoom*10 >= 1 && zoom*10 <= 8) cameraController.setZoomLevel(zoom*10);
                  });
                },
                child : CameraPreview(cameraController)
              ),

              Align(
                  alignment: Alignment.bottomCenter,
                  child : SizedBox(
                    height: 200,
                    width: 200,
                    child: Slider(
                        value : zoom,
                        activeColor: Colors.white,
                        onChanged:(value) {
                          value = value * 10;
                          if (value <= 8.0 && value >= 1.0) {
                            //here we set the zoom level when we move slider pointer
                            cameraController.setZoomLevel(value);
                          }
                          setState(() {
                            zoom = value / 10;
                          });
                        }
                    ),
                  )

              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment : MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: () async  {
                    try {
                      final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
                      if (image != Null)
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)   {
                              return Scaffold(
                                  appBar: AppBar(
                                    backgroundColor: Colors.lightGreenAccent,
                                    title: Center(child: Text('Photo view')),
                                  ),
                                  body : PhotoView(
                                    enableRotation: true,
                                    enablePanAlways: true,
                                    backgroundDecoration: BoxDecoration(
                                        color: Colors.black
                                    ),
                                    imageProvider: AssetImage(image!.path),
                                  )
                              );
                          }
                          )
                      );
                    } catch (e) {
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${e}')));
                    }
                  }, icon: Icon(Icons.photo_camera_back)),

                  FloatingActionButton(onPressed: _capturePicture,
                    child : Icon(Icons.circle_outlined),
                    backgroundColor: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {

                    },
                    icon : Icon(Icons.add),
                  )
                ],
              ),

                  Align(
                      alignment: Alignment(0, -1),
                      child : Container(
                        color : Colors.black12,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                color : Colors.white,
                                onPressed: () {
                                  setTime();
                                  if (time == 0) {
                                    timeIcon = MyFlutterApp.timer_off;
                                  } else if (time == 3) timeIcon = MyFlutterApp.timer_3;
                                  else timeIcon = MyFlutterApp.timer_10;
                                  setState(() {});
                                },
                                icon: Icon(timeIcon)),
                            IconButton(
                              color : Colors.white,
                              onPressed: () {
                                setFlashMode();
                                if (flashMode == FlashMode.off) {
                                  flashIcon = FlashIcon.flash_off;
                                } else if (flashMode == FlashMode.always) flashIcon = FlashIcon.flash_on;
                                else flashIcon = FlashIcon.flash_auto;
                                setState(() {});
                              },
                              icon : Icon(flashIcon),

                            ),
                            IconButton(
                                alignment: Alignment.bottomCenter,
                                color: Colors.tealAccent,
                                onPressed: () async {
                                  final lenDirection = cameraController.description.lensDirection;
                                  CameraDescription cameraDescription;
                                  if (lenDirection == CameraLensDirection.front) {
                                    cameraDescription  = cameras.firstWhere((element) => element.lensDirection == CameraLensDirection.back);
                                  } else {
                                    cameraDescription = cameras.firstWhere((element) => element.lensDirection == CameraLensDirection.front);
                                  }
                                  if (cameraDescription != null) {
                                    cameraController = CameraController(cameraDescription, ResolutionPreset.max);
                                  }
                                  await cameraController.initialize();
                                  setState(() {});
                                },
                                icon: Icon(Icons.cameraswitch))

                          ],
                        ),
                      )
                  )
            ]
      );
    }
  }

  @override
  void initState() {
    super.initState();
    iniCamera();
    // time = 0;
    // flashMode = FlashMode.off;
    timeIcon = MyFlutterApp.timer_off;
    flashIcon = FlashIcon.flash_off;
  }

  void iniCamera() async{
    cameras = await availableCameras();
    final front = cameras.firstWhere((element) => element.lensDirection == CameraLensDirection.front);
    cameraController = CameraController(front, ResolutionPreset.max);
    await cameraController.initialize();
    setState(() {
      _isLoading = false;
    });
  }



  _capturePicture() async {
    await cameraController.setFlashMode(flashMode);
    await Future.delayed(Duration(seconds : time));
    final file = await cameraController.takePicture();
    Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            body : Image.file(File(file.path)),
            appBar: AppBar(
              backgroundColor: Colors.cyanAccent,
              title: const Text('Here is your image captured, let me know you will save or not save'),
              actions: [
                IconButton(
                  onPressed: () async{
                    try {
                        Share.shareXFiles([file], text :'hello' );
                    } catch(Exception) {};

                  },
                  icon: Icon(Icons.share),
                ),
                IconButton(
                   onPressed: () {
                     GallerySaver.saveImage(file.path);
                     showDialog(context : context,
                         builder:(context) {
                              return AlertDialog(
                                backgroundColor: Colors.white54,
                                 title: Center(child: Text('Image saved',
                                 style: TextStyle(
                                   color: Colors.tealAccent
                                 ),)),
                                actions: [
                                  Center(
                                    child: TextButton(onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child : Text('OK')),
                                  )
                                ],
                              );
                         });
                     // Navigator.pop(context);
                   },
                    icon : Icon(Icons.download),
                ),
              ],

            ),
            // body : VideoPlayer(videoPlayerController),
          );
        }));
  }


  void setTime() {
    if (time == 0) {
      time = 3;
    } else if (time == 3) time = 10;
    else if (time == 10) time = 0;
  }
  void setFlashMode() {
    if (flashMode == FlashMode.off) {
      flashMode = FlashMode.always;
    } else if (flashMode == FlashMode.always) flashMode = FlashMode.auto;
    else flashMode = FlashMode.off;
  }
  @override
  void dispose() {
    videoPlayerController.dispose();
    cameraController.dispose();
    super.dispose();
  }
}
