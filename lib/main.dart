import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funky_project/Authentication/authentication_screen.dart';
import 'package:funky_project/Authentication/creator_login/ui/Creator_login_screen.dart';
import 'package:funky_project/splash_screen.dart';
import 'package:get/get.dart';

import 'getx_pagination/Bindings_class.dart';
import 'getx_pagination/binding_utils.dart';
import 'getx_pagination/page_route.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseAppCheck.getInstance().installAppCheckProviderFactory(
  //     PlayIntegrityAppCheckProviderFactory.getInstance())
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // navigatorKey: NavigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Funky',
      initialRoute: BindingUtils.initialRoute,
      initialBinding: Splash_Bindnig(),
      getPages: AppPages.getPageList,
      // home: (Token == '_' ||
      //         Token.toString() == 'null' ||
      //         Token.toString().isEmpty ||
      //         roles == '_' ||
      //         roles == 'null' ||
      //         roles.toString().isEmpty)
      //     ? loginScreen()
      //     : (roles == "company")
      //         ? addCompanyScreen()
      //         : (roles == "plan")
      //             ? subscription_Screen()
      //             : DashBoardScreen(),
      home: SplashScreen(),
      theme: ThemeData(
        primaryColor: Colors.yellow,
        dividerColor: Colors.transparent,
        backgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
    );
  }
}
