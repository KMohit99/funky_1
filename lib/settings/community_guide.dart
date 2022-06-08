import 'package:flutter/material.dart';
import 'package:funky_project/Utils/asset_utils.dart';

class CommunityGuide extends StatefulWidget {
  const CommunityGuide({Key? key}) : super(key: key);

  @override
  State<CommunityGuide> createState() => _CommunityGuideState();
}

class _CommunityGuideState extends State<CommunityGuide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Community guidelines',
          style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'PB'),
        ),
        centerTitle: true,
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.only(
            right: 20.0,
            top: 0.0,
            bottom: 5.0,
          ),
          child: ClipRRect(
              child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          )),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Container(
                child: Text(
                  "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. ",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 14, color: Colors.white, fontFamily: 'PR'),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                      AssetUtils.image4,
                      fit: BoxFit.fitWidth,
                    ),
                ),
              ),
              Container(
                child: Text(
                  "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. ",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 14, color: Colors.white, fontFamily: 'PR'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
