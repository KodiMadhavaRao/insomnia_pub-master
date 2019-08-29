import 'package:flutter/material.dart';
import 'package:Amnesia/net/http_nw.dart';
import 'package:Amnesia/ui/OTPScreen.dart';
import 'package:Amnesia/util/Utils.dart';
import 'package:Amnesia/util/constants.dart';
import 'package:Amnesia/util/progress_indicator.dart';
import 'package:Amnesia/util/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SignUpScreen.dart';
import 'home/home_screen.dart';

class AuthenticationScreen extends StatefulWidget {
  State<StatefulWidget> createState() => new _AutenticationState();
}

class _AutenticationState extends State<AuthenticationScreen> {
  TextEditingController _mobileNumber;

//  String _mobile = "";

  bool isLoadingState = false;

  // our default setting is to login, and we should switch to creating an account when the user chooses to

  initState() {
    super.initState();
    _mobileNumber = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressWidget(
      isLoading: isLoadingState,
      child: new Scaffold(
        body: DecoratedBox(
          position: DecorationPosition.background,
          decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter:
                      ColorFilter.mode(Colors.black, BlendMode.colorDodge),
                  image: AssetImage("images/bg_1x.png"),
                  fit: BoxFit.cover)),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Image.asset(
                  "images/app_logo.jpg",
                  fit: BoxFit.fitHeight,
                ),
              ),
              _buildTextFields(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFields() {
    return new Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Container(
            margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: new TextField(
              controller: _mobileNumber,
              style: TextStyle(color: Colors.white, fontSize: 18),
              decoration: new InputDecoration(
                labelText: 'Mobile',
                hintStyle: TextStyle(fontWeight: FontWeight.w300),
                filled: true,
                labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide:
                        BorderSide(width: 2, color: Constants.COLORMAIN)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(width: 2, color: Constants.COLORMAIN),
                ),
              ),
              keyboardType:
                  TextInputType.numberWithOptions(decimal: false, signed: true),
            ),
          ),
          new Container(
            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
            child: new RaisedButton(
              child: new Text(
                'LOGIN',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              onPressed: _loginPressed,
              padding: EdgeInsets.only(top: 15, bottom: 15),
              color: Constants.COLORMAIN,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
            ),
          )
        ],
      ),
    );
  }

  // These functions can self contain any user auth logic required, they all have access to _user and _mobile

  void _loginPressed() {
//    print('The user wants to login with  and $_mobile');
    if (_mobileNumber.text.isEmpty || _mobileNumber.text.length < 10) {
      Utils.showToast("Invalid mobile number", Colors.red, Colors.white);
      return;
    }

    setState(() {
      isLoadingState = true;
    });
    AppHttpRequest.loginRequest(_mobileNumber.text).then((response) {
      if (response is Map) {
        if (response['status'] == 'error') {
          Utils.showToast(
              response['message'], Colors.red[900], Colors.white, 10.0);
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (BuildContext context) =>
                  SignUpScreen(number: _mobileNumber.text)));
        } else if (response['status'] == 'success') {
          SharedPrefencesHelper.setUserId(int.parse(response['id']));
          SharedPrefencesHelper.setUserName(response['user_name']);
          SharedPrefencesHelper.setMobileNo(int.parse(_mobileNumber.text));
          /* Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => MyHomePage(title: "Insomnia")),
              ModalRoute.withName("/"));*/
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (BuildContext context) =>
                  MyHomePage(title: "Insomnia")));
        }

        setState(() {
          isLoadingState = false;
        });
      }
    });
  }
}
