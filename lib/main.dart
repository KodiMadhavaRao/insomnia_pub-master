import 'package:flutter/material.dart';
import 'package:Amnesia/ui/AuthenticationScreen.dart';
import 'package:Amnesia/ui/SignUpScreen.dart';
import 'package:Amnesia/ui/home/home_screen.dart';
import 'package:Amnesia/ui/home/start_up_option.dart';
import 'package:Amnesia/util/constants.dart';
import 'package:Amnesia/util/shared_preferences.dart';

import 'ui/event_list/events_list.dart';
import 'ui/home/carousel_with_indicator.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appTitle = 'Insomnia';

  final String backImg = "images/bg_1x.png";
  bool showSplash;
  int iUserid;

  @override
  void initState() {
    super.initState();
    showSplash = true;
    disableSplashScreen();
    SharedPrefencesHelper.getUserId().then((int userId) {
      iUserid = userId ?? -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData.dark().copyWith(
          primaryColor: Constants.COLORMAIN,
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Constants.COLORMAIN))),
      home: showSplash
          ? splashScreen()
          : iUserid == -1 || iUserid == null
              ? new SignInOrSignUp()
              : MyHomePage(title: "Insomnia"),
    );
  }

  Widget splashScreen() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/splash_screen.jpg'),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter)),
    );
  }

  disableSplashScreen() async {
    new Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        showSplash = false;
      });
    });
  }
}
