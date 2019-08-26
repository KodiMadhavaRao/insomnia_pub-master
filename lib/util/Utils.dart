import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insomnia_pub/util/constants.dart';

class Utils {
  static void showToast(String message,
      [Color backColor = Constants.COLORMAIN,
      Color textColor = Colors.white,
      fontSize = 16.0]) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: backColor,
        textColor: textColor,
        fontSize: 16.0);
  }
}
