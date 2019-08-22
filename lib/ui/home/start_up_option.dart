import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:insomnia_pub/ui/SignUpScreen.dart';
import 'package:insomnia_pub/util/constants.dart';

import '../AuthenticationScreen.dart';

class SignInOrSignUp extends StatelessWidget {
  static final String path = "lib/src/pages/login/auth2.dart";
  final String backImg = "images/bg_1x.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(backImg), fit: BoxFit.cover)),
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                margin: const EdgeInsets.all(48.0),
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 48.0),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10.0)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 1.0,
                    sigmaY: 1.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        "images/insomnialogo.png",
                        width: 150,
                        height: 150,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "Night Club",
                        style: TextStyle(
                            color: Constants.COLORMAIN,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20.0),
                      Text("night you won't forget",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w300)),
                      const SizedBox(height: 30.0),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: RaisedButton(
                          elevation: 0,
                          highlightElevation: 0,
                          color: Constants.COLORMAIN.withAlpha(180),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Text("LOGIN",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        AuthenticationScreen()));
                          },
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "OR",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(height: 10.0),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: RaisedButton(
                          elevation: 0,
                          highlightElevation: 0,
                          color: Constants.COLORMAIN.withAlpha(180),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Text(
                            "CREATE A ACCOUNT",
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SignUpScreen()));
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
