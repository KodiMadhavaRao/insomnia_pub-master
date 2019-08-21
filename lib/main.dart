import 'package:flutter/material.dart';
import 'package:insomnia_pub/ui/AuthenticationScreen.dart';
import 'package:insomnia_pub/ui/SignUpScreen.dart';
import 'package:insomnia_pub/ui/home/home_screen.dart';
import 'package:insomnia_pub/ui/home/start_up_option.dart';
import 'package:insomnia_pub/util/constants.dart';

import 'ui/event_list/events_list.dart';
import 'ui/home/carousel_with_indicator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appTitle = 'Insomnia';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData.dark().copyWith(
          primaryColor: Constants.COLORMAIN,
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Constants.COLORMAIN))),
      home: new SignInOrSignUp(),
      );
  }
}
