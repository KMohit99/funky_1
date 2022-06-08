import 'dart:async';

import 'package:flutter/material.dart';
import 'package:funky_project/Utils/asset_utils.dart';
import 'package:funky_project/homepage/controller/homepage_controller.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:video_player/video_player.dart';

import '../../drawerScreen.dart';
import 'better_video.dart';
import 'common_video_class.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final HomepageController homepageController =
      Get.put(HomepageController(), tag: HomepageController().toString());

  bool _onTouch = true;

  Timer? _timer;

  @override
  void initState() {
    init();
    // **
    super.initState();
  }

  init() async {
    await homepageController.getAllVideosList();
    await video_method();
  }

  video_method() {}

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  int _currentPage = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Dashboard',
            style:
                TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'PB'),
          ),
          centerTitle: true,
          actions: [
            Row(
              children: [
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, top: 0.0, bottom: 5.0),
                    child: ClipRRect(
                      child: Image.asset(
                        AssetUtils.noti_icon,
                        height: 20.0,
                        width: 20.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, top: 0.0, bottom: 5.0),
                    child: ClipRRect(
                      child: Image.asset(
                        AssetUtils.chat_icon,
                        height: 20.0,
                        width: 20.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
          leadingWidth: 100,
          leading: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 16, top: 0, bottom: 0),
                child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      print('oject');
                      _scaffoldKey.currentState!.openDrawer();
                    },
                    icon: (Image.asset(
                      AssetUtils.drawer_icon,
                      color: Colors.white,
                      height: 12.0,
                      width: 19.0,
                      fit: BoxFit.contain,
                    ))),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 18, top: 0, bottom: 0),
                  child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: (Image.asset(
                        AssetUtils.user_icon,
                        color: Colors.white,
                        height: 20.0,
                        width: 20.0,
                        fit: BoxFit.contain,
                      ))),
                ),
              ),
            ],
          ),
        ),
        body: Obx(() => (homepageController.isVideoLoading != true &&
                homepageController.videoListModel != null)
            ? Center(
                child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: homepageController.videoListModel!.data!.length,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return
                          // VideoDetails(url: homepageController
                          //         .videoListModel!.data![index].videoUrl!,);
                          VideoWidget(
                        url: homepageController
                            .videoListModel!.data![index].uploadVideo!,
                        play: true,
                        songName: homepageController
                            .videoListModel!.data![index].musicName!,
                        singerName: (homepageController
                                    .videoListModel!.data![index].userName ==
                                null
                            ? ''
                            : homepageController
                                .videoListModel!.data![index].userName!),
                      );
                    }),
              )
            : Center(
                child: Container(
                  child: Text('plaese wait'),
                ),
              )));
  }
}
