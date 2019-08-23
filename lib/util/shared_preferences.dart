import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefencesHelper {
  static setUserId(int userId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("userId", userId);
  }

  static Future<int> getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int userId=sharedPreferences.get("userId");
    return userId;
  }

  static void setMobileNo(int mobileNo) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("mobileNo", mobileNo);
  }

  static Future<int> getMobileNo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int iMobileNo=sharedPreferences.get("mobileNo");
    return iMobileNo;
  }
  static void setUserName(String userName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("userName", userName);
  }

  static Future<String> getUserName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userName=sharedPreferences.get("userName");
    return userName;
  }
}
