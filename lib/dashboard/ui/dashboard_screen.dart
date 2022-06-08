import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'package:funky_project/dashboard/ui/post_preview.dart';


import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funky_project/Authentication/creator_login/controller/creator_login_controller.dart';
import 'package:funky_project/dashboard/ui/post_screen.dart';
import 'package:funky_project/dashboard/ui/video_editor.dart';
import 'package:funky_project/homepage/ui/homepage_screen.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_picker/image_picker.dart';

import '../../Utils/App_utils.dart';
import '../../Utils/asset_utils.dart';
import '../../Utils/colorUtils.dart';
import '../../Utils/toaster_widget.dart';
import '../../custom_widget/common_buttons.dart';
import '../../drawerScreen.dart';
import '../../news_feed/new_feed_screen.dart';
import '../../profile_screen/profile_screen.dart';
import '../../search_screen/search_screen.dart';
import 'dart:math' as math;

import '../../sharePreference.dart';
import '../model/PostModel.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late double screenHeight, screenWidth;
  int _page = 0;

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              FlatButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Widget? get getPage {
    if (_page == 0) {
      return const HomePageScreen();
    } else if (_page == 1) {
      return const SearchScreen();
    } else if (_page == 2) {
      return const NewsFeedScreen();
    } else if (_page == 3) {
      return const Profile_Screen();
    }
  }

  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();

  File? imgFile;
  Uint8List? imageData;

  final imgPicker = ImagePicker();

  void openGallery() async {
    var imgGallery = await imgPicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imgFile = File(imgGallery!.path);
      imageData = imgFile!.readAsBytesSync();
      print(imageData);
    });
    // editedImage();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageEditor(
          image: imageData,
        ),
      ),
    ).then((editedImage) async {
      if (editedImage != null) {
        setState(() {
          // imgFile = editedImage;
         String base64String = base64Encode(editedImage);
         final decodedBytes = base64Decode(base64String);
         var file = Io.File(imgFile!.path);
         file.writeAsBytesSync(decodedBytes);
         print(file.path.split('/').last);
         imgFile = file;
         Get.to(PostPreviewScreen(ImageFile:imgFile! ,));
        });
      }
    }).catchError((er) {
      print(er);
    });
  }

  void openCamera() async {
    var imgCamera = await imgPicker.getImage(source: ImageSource.camera);
    setState(() {
      imgFile = File(imgCamera!.path);
      // _creator_signup_controller.photoBase64 =
      //     base64Encode(imgFile!.readAsBytesSync());
      // print(_creator_signup_controller.photoBase64);
      imageData = imgFile!.readAsBytesSync();
      print(imageData);
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageEditor(
          image: imageData,
        ),
      ),
    ).then((editedImage) {
      if (editedImage != null) {
        setState(() {
          // imgFile = editedImage;
          String base64String = base64Encode(editedImage);
          final decodedBytes = base64Decode(base64String);
          var file = Io.File(imgFile!.path);
          file.writeAsBytesSync(decodedBytes);
          print(file.path.split('/').last);
          imgFile = file;
          Get.to(PostPreviewScreen(ImageFile:imgFile! ,));
          Navigator.pop(context);
        });
      }
    }).catchError((er) {
      print(er);
    });
  }

  void Pickvideo() async {
    var imgCamera = await imgPicker.pickVideo(source: ImageSource.gallery);
    setState(() {
      imgFile = File(imgCamera!.path);
      // _creator_signup_controller.photoBase64 =
      //     base64Encode(imgFile!.readAsBytesSync());
      // print(_creator_signup_controller.photoBase64);
      imageData = imgFile!.readAsBytesSync();
      print(imageData);
    });
    if (mounted && imgFile != null) {
      Navigator.push(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext context) =>
                  VideoEditor(file: File(imgFile!.path))));
    }
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ImageEditor(
    //       image: imageData,
    //     ),
    //   ),
    // ).then((editedImage) {
    //   if (editedImage != null) {
    //     setState(() {
    //       // imgFile = editedImage;
    //       String base64String = base64Encode(editedImage);
    //       final decodedBytes = base64Decode(base64String);
    //       var file = Io.File(imgFile!.path);
    //       file.writeAsBytesSync(decodedBytes);
    //       print(file.path.split('/').last);
    //       imgFile = file;
    //       Get.to(PostPreviewScreen(ImageFile:imgFile! ,));
    //       Navigator.pop(context);
    //     });
    //   }
    // }).catchError((er) {
    //   print(er);
    // });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _globalKey,
      // drawer: DrawerScreen(),
      backgroundColor: HexColor(CommonColor.appBackColor),
      extendBodyBehindAppBar: true,
      drawer: DrawerScreen(),

      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomAppBar(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                // stops: [0.1, 0.5, 0.7, 0.9],
                colors: [
                  HexColor("#C12265"),
                  HexColor("#000000"),
                  HexColor("#000000"),
                  // HexColor("#FFFFFF").withOpacity(0.67),
                ],
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 28.0),
                  decoration: BoxDecoration(
                      color: (_page == 0 ? Colors.white : Colors.transparent),
                      borderRadius: BorderRadius.circular(50)),
                  child: IconButton(
                    visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                    iconSize: 25.0,
                    icon: Image.asset(
                      AssetUtils.home_icon,
                      color: (_page == 0 ? Colors.black : Colors.white),
                      height: 20,
                      width: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _page = 0;
                        // _myPage.jumpToPage(0);
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 28.0),
                  decoration: BoxDecoration(
                      color: (_page == 1 ? Colors.white : Colors.transparent),
                      borderRadius: BorderRadius.circular(50)),
                  child: IconButton(
                    visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                    iconSize: 25.0,
                    icon: Image.asset(
                      AssetUtils.search_icon,
                      color: (_page == 1 ? Colors.black : Colors.white),
                      height: 20,
                      width: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _page = 1;
                        // _myPage.jumpToPage(1);
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 28.0),
                  decoration: BoxDecoration(
                      color: (_page == 2 ? Colors.white : Colors.transparent),
                      borderRadius: BorderRadius.circular(50)),
                  child: IconButton(
                    visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                    iconSize: 25.0,
                    icon: Image.asset(
                      AssetUtils.news_icon,
                      color: (_page == 2 ? Colors.black : Colors.white),
                      height: 20,
                      width: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _page = 2;
                        // _myPage.jumpToPage(2);
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 28.0),
                  decoration: BoxDecoration(
                      color: (_page == 3 ? Colors.white : Colors.transparent),
                      borderRadius: BorderRadius.circular(50)),
                  child: IconButton(
                    visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                    iconSize: 25.0,
                    icon: Image.asset(
                      AssetUtils.user_icon2,
                      color: (_page == 3 ? Colors.black : Colors.white),
                      height: 20,
                      width: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _page = 3;

                        // _myPage.jumpToPage(3);
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Material(
        type: MaterialType.transparency,
        borderOnForeground: true,
        child: Container(
          height: 80,
          width: 80,
          child: Stack(
            children: [
              Container(
                child: MyArc(diameter: 80),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 50.79,
                  width: 50.79,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white.withOpacity(0.14), width: 5),
                    borderRadius: BorderRadius.circular(50),
                    // color: Colors.grey
                  ),
                  child: SizedBox(
                    height: 45.79,
                    width: 45.79,
                    child: FittedBox(
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              double width = MediaQuery.of(context).size.width;
                              double height =
                                  MediaQuery.of(context).size.height;
                              return BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: AlertDialog(
                                    backgroundColor: Colors.transparent,
                                    contentPadding: EdgeInsets.zero,
                                    elevation: 0.0,
                                    // title: Center(child: Text("Evaluation our APP")),
                                    content: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 110, horizontal: 70),
                                          height: 122,
                                          // width: 133,
                                          // padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment(-1.0, 0.0),
                                                end: Alignment(1.0, 0.0),
                                                transform:
                                                    GradientRotation(0.7853982),
                                                // stops: [0.1, 0.5, 0.7, 0.9],
                                                colors: [
                                                  HexColor("#000000"),
                                                  HexColor("#000000"),
                                                  HexColor("##E84F90"),
                                                  HexColor("#ffffff"),
                                                  // HexColor("#FFFFFF").withOpacity(0.67),
                                                ],
                                              ),
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(26.0))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  print('name');
                                                  Get.to(PostScreen());
                                                  // showDialog(
                                                  //   context: context,
                                                  //   builder: (ctx) => AlertDialog(
                                                  //     title: Text("Pick Image from"),
                                                  //     actions: <Widget>[
                                                  //       Container(
                                                  //         margin:
                                                  //         EdgeInsets.only(bottom: 10),
                                                  //         child: common_button(
                                                  //           onTap: () {
                                                  //             openCamera();
                                                  //             // Get.toNamed(BindingUtils.signupOption);
                                                  //           },
                                                  //           backgroud_color: Colors.black,
                                                  //           lable_text: 'Camera',
                                                  //           lable_text_color:
                                                  //           Colors.white,
                                                  //         ),
                                                  //       ),
                                                  //       common_button(
                                                  //         onTap: () {
                                                  //           openGallery();
                                                  //           // Get.toNamed(BindingUtils.signupOption);
                                                  //         },
                                                  //         backgroud_color: Colors.black,
                                                  //         lable_text: 'Gallery',
                                                  //         lable_text_color: Colors.white,
                                                  //       ),
                                                  //       SizedBox(
                                                  //         height: 10,
                                                  //       ),
                                                  //       common_button(
                                                  //         onTap: () {
                                                  //           Pickvideo();
                                                  //           // Get.toNamed(BindingUtils.signupOption);
                                                  //         },
                                                  //         backgroud_color: Colors.black,
                                                  //         lable_text: 'Video',
                                                  //         lable_text_color: Colors.white,
                                                  //       ),
                                                  //     ],
                                                  //   ),
                                                  // );
                                                  },
                                                child: Text(
                                                  'Post',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: 'PR',
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: Divider(
                                                  color: Colors.black,
                                                  height: 20,
                                                ),
                                              ),
                                              Text(
                                                'Videos',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'PR',
                                                    color: Colors.white),
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: Divider(
                                                  color: Colors.black,
                                                  height: 20,
                                                ),
                                              ),
                                              Text(
                                                'Live',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'PR',
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              );
                            },
                          );
                        },
                        tooltip: 'Increment',
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 30,
                        ),
                        elevation: 0.0,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: getPage!,
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class MyArc extends StatelessWidget {
  final double diameter;

  const MyArc({Key? key, this.diameter = 200}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(),
      size: Size(diameter, diameter),
    );
  }
}

// This is the Painter class
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = HexColor('#C12265');
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
