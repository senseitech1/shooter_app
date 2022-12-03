import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/colorsfiltters.dart';

class Camerascreen extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const Camerascreen(
      {Key? key, required this.cameras}) : super(key:key);

  @override
  CamerascreenState createState() => CamerascreenState();
}

class CamerascreenState extends State<Camerascreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isRearCameraSelected = true;
  bool tabbarview = false;
  @override
  void initState() {
    super.initState();
    initCamera(widget.cameras![1]);
    _initializeControllerFuture = _controller.initialize();
    _controller = CameraController(
      widget.cameras![1],
      ResolutionPreset.medium,
    );
  }
  final ImagePicker _picker = ImagePicker();
  FlashMode flashMode = FlashMode.off;
  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }
  Future initCamera(CameraDescription cameraDescription) async {
// create a CameraController
    _controller = CameraController(
        cameraDescription, ResolutionPreset.high);
// Next, initialize the controller. This returns a Future.
    try {
      await _controller.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: size.height*0.07,left: size.width*0.03),
                  child: InkWell(
                    onTap: (){
                      setState((){
                        tabbarview = !tabbarview;

                      });
                      // tabbarview == true? Container():TabBar(
                      //   tabs: [
                      //     Tab(
                      //       text: ("One"),
                      //     ),
                      //     Tab(
                      //       text: ("Two"),
                      //     ),
                      //     Tab(
                      //       text: ("Three"),
                      //     )
                      //   ],
                      // );
                    },
                    child: Container(
                      height: size.height*0.04,
                      width: size.height*0.04,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: Icon(tabbarview == true?Icons.keyboard_arrow_down:Icons.keyboard_arrow_up) ,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: size.height*0.06,left: size.width*0.03),
                  child: InkWell(
                    onTap: (){
                      _picker.pickImage(source: ImageSource.gallery);
                    },
                    child: Container(
                      height: size.height*0.055,
                        width: size.width*0.055,
                        child: Image.asset("assets/gallery.png")),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: size.height*0.055,left: size.width*0.03),
                  child: InkWell(
                    onTap: ()async{
                      try {
                        await _initializeControllerFuture;
                        final image = await _controller.takePicture();
                        if (!mounted) return;
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DisplayPictureScreen(
                              imagePath: image.path,
                            ),
                          ),
                        );
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Container(
                      height: size.height*0.08,
                      width: size.height*0.08,
                      decoration: BoxDecoration(
                        color: HexColor("57595A"),
                        borderRadius: BorderRadius.circular(35),
                        border: Border.all(color: HexColor("FFFFFF"),width: size.width*0.01)
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: size.height*0.07,left: size.width*0.03),
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        if (flashMode == FlashMode.off) {
                          _controller.setFlashMode(FlashMode.torch);
                          flashMode = FlashMode.always;
                        } else {
                          _controller.setFlashMode(FlashMode.off);
                          flashMode = FlashMode.off;
                        }
                      });
                    },
                    child: Container(
                      height: size.height*0.04,
                      width: size.height*0.04,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: flashMode == FlashMode.off ? const Icon(Icons.flash_off) : const Icon(Icons.flash_on),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:  EdgeInsets.only(bottom: size.height*0.07,left: size.width*0.05),
                  child: InkWell(onTap: (){
                    setState(() => _isRearCameraSelected = !_isRearCameraSelected);
                    initCamera(widget.cameras![_isRearCameraSelected ? 0 : 1]);
                  },child: Icon( _isRearCameraSelected
                      ? CupertinoIcons.switch_camera
                      : CupertinoIcons.switch_camera_solid,color: Colors.white),),
                ),
              )
            ],
          ),
          /*Align(
            alignment: Alignment.bottomCenter,
            child: tabbarview==true? TabBar(
              tabs: [
                Tab(
                  text: ("One"),
                ),
                Tab(
                  text: ("Two"),
                ),
                Tab(
                  text: ("Three"),
                )
              ],
            ):Container(),
          )*/
        ],
      ),

    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

   DisplayPictureScreen({super.key, required this.imagePath});


  @override
  Widget build(BuildContext context) {
    final List<List<double>> filters = [SEPIA_MATRIX,GREYSCALE_MATRIX,VINTAGE_MATRIX  ,SWEET_MATRIX];

    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: PageView.builder(
        itemCount: filters.length,
        itemBuilder: (context, index) {
          return ColorFiltered(
              colorFilter: ColorFilter.matrix(filters[index]),
              child: Image.file(File(imagePath)));
        },
      ),
    );

  }
}