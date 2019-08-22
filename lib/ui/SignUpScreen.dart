import 'package:flutter/material.dart';
import 'package:insomnia_pub/net/http_nw.dart';
import 'package:insomnia_pub/ui/OTPScreen.dart';
import 'package:insomnia_pub/util/Utils.dart';
import 'package:insomnia_pub/util/constants.dart';
import 'package:insomnia_pub/util/progress_indicator.dart';

import 'home/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  final String number;

  State<StatefulWidget> createState() => SignUpScreenState();

  SignUpScreen({this.number = ""});
}

class SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _mobileNumber;

//  String _mobile = "";

  bool isLoadingState = false;

  TextEditingController _userName;

  initState() {
    super.initState();
    _mobileNumber = new TextEditingController(text: widget.number);
    _userName = new TextEditingController();
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
                child: Text(
                  "INSOMNIA",
                  style: TextStyle(
                      fontSize: 35,
                      letterSpacing: 5,
                      fontWeight: FontWeight.bold),
                ),
              ),
              _buildTextFields(),
//            _buildButtons(),
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
              controller: _userName,
              style: TextStyle(color: Colors.white, fontSize: 18),
              decoration: new InputDecoration(
                labelText: 'User name',
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
              keyboardType: TextInputType.text,
            ),
          ),
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
                'SIGN UP',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              onPressed: _SignUpPressed,
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

  void _SignUpPressed() {
    if (_userName.text.isEmpty) {
      Utils.showToast("Invalid User Name", Colors.redAccent[700], Colors.white);
      return;
    }
    if (_mobileNumber.text.isEmpty || _mobileNumber.text.length < 10) {
      Utils.showToast(
          "Invalid mobile number", Colors.redAccent[700], Colors.white);
      return;
    }

    setState(() {
      isLoadingState = true;
    });

    AppHttpRequest.singUpRequest(_userName.text, _mobileNumber.text)
        .then((response) {
      if (response is Map) {
        if (response['status'] == 'error') {
          Utils.showToast(
              response['message'], Colors.redAccent[700], Colors.white, 10.0);
        } else if (response['status'] == 'success') {
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (BuildContext context) =>
                  OTPScreenWidget(number: _mobileNumber.text)));
        }

        setState(() {
          isLoadingState = false;
        });
      }
    });
  }
}
