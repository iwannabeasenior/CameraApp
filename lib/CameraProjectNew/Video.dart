
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:smooth_video_progress/smooth_video_progress.dart';
import 'package:untitled/cameraProject/QRcode.dart';
import 'package:video_player/video_player.dart';
import '../font/my_flutter_app_icons.dart';
import '../font/flash_icon.dart';
import 'package:share_plus/share_plus.dart';
class CameraPage2 extends StatefulWidget {
  const CameraPage2({Key? key}) : super(key : key);
  @override
  State<StatefulWidget> createState() {
    return CameraPageState();
  }
}
class CameraPageState extends State<CameraPage2> {
  //zoom
  double zoom = 0.0;
  //flash
  late IconData flashIcon;
  FlashMode flashMode = FlashMode.off;
  // time
  late IconData timeIcon;
  int time = 0;

  late VideoPlayerController videoPlayerController;
  late CameraController cameraController;
  late List<CameraDescription>cameras;
  bool _isLoading = true;
  bool _isRecording = false;

  String speed = '1.0';

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
            CameraPreview(cameraController),

            Align(

                alignment: Alignment.bottomCenter,
                child : SizedBox(
                  height: 200,
                  width: 200,
                  child: Slider(
                      value : zoom,
                      activeColor: Colors.white,
                      onChanged:(value) {
                        print(value);
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(onPressed: _recordVideo,
                    child : Icon(_isRecording ? Icons.stop : Icons.circle),
                    backgroundColor: Colors.white54),
              ],
            ),
            Align(
                alignment: Alignment(0, -0.9),
                child : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        color : Colors.white,
                        onPressed: () {
                          setTime();
                          if (time == 0) timeIcon = MyFlutterApp.timer_off;
                          else if (time == 3) timeIcon = MyFlutterApp.timer_3;
                          else timeIcon = MyFlutterApp.timer_10;
                          setState(() {});
                        },
                        icon: Icon(timeIcon)),
                    IconButton(
                      color : Colors.white,
                      onPressed: () {
                        setFlashMode();
                        if (flashMode == FlashMode.off) flashIcon = FlashIcon.flash_off;
                        else if (flashMode == FlashMode.always) flashIcon = FlashIcon.flash_on;
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

  _recordVideo() async{
    if (_isRecording) {
      final file = await cameraController.stopVideoRecording();
      setState(() {
        _isRecording = false;
      });
      videoPlayerController = VideoPlayerController.file(File(file.path));
      await videoPlayerController.initialize();
      await videoPlayerController.setLooping(false);
      await videoPlayerController.play();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Scaffold(
          bottomNavigationBar: BottomAppBar(
                child : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SmoothVideoProgress(
                        controller: videoPlayerController,
                        builder: (context, position, duration, child) {
                          return Slider(
                            onChangeEnd: (_) {
                              videoPlayerController.play();
                            },
                            onChangeStart: (_) {
                              videoPlayerController.pause();
                            },
                            onChanged: (value) {
                              videoPlayerController.seekTo(Duration(milliseconds: value.toInt()));
                            },
                            value: position.inMilliseconds.toDouble(),
                            min : 0,
                            max : duration.inMilliseconds.toDouble(),
                          );
                        }),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        IconButton(
                          onPressed: () async {
                            // // videoPlayerController.setVolume(10000)
                            // int minute = await videoPlayerController.position.then((value) => value!.inMinutes);
                            // int hour = await videoPlayerController.position.then((value) => value!.inHours);
                            int second = await videoPlayerController.position.then((value) => value!.inSeconds - 5);
                            // videoPlayerController.seekTo(Duration(hours: hour, minutes : minute, seconds: second));
                            videoPlayerController.seekTo(Duration(seconds : second));
                          },
                          icon : Icon(Icons.skip_previous),
                        ),
                        IconButton(
                            onPressed: () async {
                              if (videoPlayerController.value.isPlaying) {
                                await videoPlayerController.pause();
                              } else {
                                await videoPlayerController.play();
                              }
                              setState(() {});
                            },
                            icon : Icon(videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow)
                        ),
                        IconButton(
                            onPressed: () async {
                              // // videoPlayerController.setVolume(10000)
                              // int minute = await videoPlayerController.position.then((value) => value!.inMinutes);
                              // int hour = await videoPlayerController.position.then((value) => value!.inHours);
                              int second = await videoPlayerController.position.then((value) => value!.inSeconds - 5);
                              // videoPlayerController.seekTo(Duration(hours: hour, minutes : minute, seconds: second));
                              videoPlayerController.seekTo(Duration(seconds : second));
                            },
                            icon : Icon(Icons.skip_next)
                        ),
                        PopupMenuButton(
                          child: Text(speed),
                          onSelected: (value) {
                            if (value == MenuItemButton.button1) {
                              speed = 'x2';
                              videoPlayerController.setPlaybackSpeed(2.0);
                              setState(() {});
                            } else if (value == MenuItemButton.button2) {
                              speed  = 'x1.5';
                              videoPlayerController.setPlaybackSpeed(1.5);
                              setState(() {});
                            } else if (value == MenuItemButton.button3) {
                              speed = 'x1';
                              videoPlayerController.setPlaybackSpeed(1.0);
                              setState(() {});
                            }
                          },
                          itemBuilder: (context) => const [
                            PopupMenuItem(child: Text('x2'),
                              value: MenuItemButton.button1,),
                            PopupMenuItem(child: Text('x1.5'),
                                value : MenuItemButton.button2),
                            PopupMenuItem(child: Text('x1'),
                                value : MenuItemButton.button3)
                          ],
                        )
                      ],
                    ),
                  ],
                )
            ),

          body : VideoPlayer(videoPlayerController),
          appBar: AppBar(
            backgroundColor: Colors.cyanAccent,
            title: Text('Your record video, save it >>',),
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
                    GallerySaver.saveVideo(file.path);
                    showDialog(context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.red,
                            actions: [

                              Center(
                                child: TextButton(
                                  onPressed : () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    videoPlayerController.pause();
                                  },
                                  child: Text('OK'),
                                ),
                              )
                            ],
                            title: Center(
                              child: Text('Video saved',
                              style: TextStyle(
                                color: Colors.tealAccent
                              )),
                            ),
                          );
                        });
                  },
                  icon : Icon(Icons.check)
              )
            ],
          ),
        );
      }));
    } else {
      await cameraController.prepareForVideoRecording();
      await cameraController.startVideoRecording();
      setState(() {
        _isRecording = true;
      });
    }
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
              title: Text('Here is your image captured, let me know you will save or not save'),
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
                            title: Text('Image saved'),
                            actions: [
                              TextButton(onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                                  child : Text('OK'))
                            ],
                          );
                        });
                    // Navigator.pop(context);
                  },
                  icon : Icon(Icons.check),
                )
              ],

            ),
            // body : VideoPlayer(videoPlayerController),
          );
        }));
  }
  void setTime() {
    if (time == 0) time = 3;
    else if (time == 3) time = 10;
    else if (time == 10) time = 0;
  }
  void setFlashMode() {
    if (flashMode == FlashMode.off) flashMode = FlashMode.always;
    else if (flashMode == FlashMode.always) flashMode = FlashMode.auto;
    else flashMode = FlashMode.off;
  }
  void dispose() {
    videoPlayerController.dispose();
    cameraController.dispose();
    super.dispose();
  }
}
enum MenuItemButton {
  button1, button2, button3;
}
