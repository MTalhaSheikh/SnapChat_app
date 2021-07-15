import 'package:camera_deep_ar/camera_deep_ar.dart';
import 'package:flutter/material.dart';

const apiKey =
    "cd7971aaab0265b7bbd8885537468d3cebdc2a8d2fffcac01b02c0375faebd50b394564db6b46e4e";

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  CameraDeepArController cameraDeepArController;
  int currentPage = 0;
  final vp = PageController(viewportFraction: .24);
  Effects currentEffect = Effects.none;
  Filters currentFilter = Filters.none;
  Masks currentMask = Masks.none;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.greenAccent[700],
          title: const Text('SnapChat Filter'),
        ),
        body: Stack(
          children: [
            CameraDeepAr(
                onCameraReady: (isReady) {
                  _platformVersion = "Camera status $isReady";
                  setState(() {});
                },
                onImageCaptured: (path) {
                  _platformVersion = "Image Taken @ $path";
                  setState(() {});
                },
                onVideoRecorded: (path) {
                  _platformVersion = "Video Recorded @ $path";
                  isRecording = false;
                  setState(() {});
                },
                androidLicenceKey:
                    "cd7971aaab0265b7bbd8885537468d3cebdc2a8d2fffcac01b02c0375faebd50b394564db6b46e4e",
                iosLicenceKey:
                    "cd7971aaab0265b7bbd8885537468d3cebdc2a8d2fffcac01b02c0375faebd50b394564db6b46e4e",
                cameraDeepArCallback: (c) async {
                  cameraDeepArController = c;
                  setState(() {});
                }),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                //height: 250,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // SizedBox(
                    //   height: 20,
                    // ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (null == cameraDeepArController) return;
                              if (isRecording) return;
                              cameraDeepArController.snapPhoto();
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Icon(Icons.camera_enhance_outlined),
                              padding: EdgeInsets.all(15),
                            ),
                          ),
                          if (isRecording)
                            GestureDetector(
                              onTap: () {
                                if (null == cameraDeepArController) return;
                                cameraDeepArController.stopVideoRecording();
                                isRecording = false;
                                setState(() {});
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Icon(Icons.videocam_off),
                                padding: EdgeInsets.all(15),
                              ),
                            )
                          else
                            GestureDetector(
                              onTap: () {
                                if (null == cameraDeepArController) return;
                                cameraDeepArController.startVideoRecording();
                                isRecording = true;
                                setState(() {});
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.orangeAccent,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Icon(Icons.videocam),
                                padding: EdgeInsets.all(15),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(7, (p) {
                          bool active = currentPage == p;
                          return GestureDetector(
                            onTap: () {
                              currentPage = p;
                              cameraDeepArController.changeMask(p);
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(12),
                              width: active ? 65 : 55,
                              height: active ? 65 : 55,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: active
                                      ? Colors.greenAccent[700]
                                      : Colors.white,
                                  shape: BoxShape.circle),
                              child: Text(
                                "$p",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: active ? 18 : 16,
                                    color:
                                        active ? Colors.white : Colors.black),
                              ),
                            ),
                          );
                        }),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
