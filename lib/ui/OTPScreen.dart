import 'package:flutter/material.dart';
import 'package:Amnesia/net/http_nw.dart';
import 'package:Amnesia/util/Utils.dart';
import 'package:Amnesia/util/constants.dart';
import 'package:Amnesia/util/progress_indicator.dart';

import 'home/home_screen.dart';

class OTPScreenWidget extends StatefulWidget {
  final number;

  State<StatefulWidget> createState() => new OTPScreenState();

  OTPScreenWidget({this.number});
}

class OTPScreenState extends State<OTPScreenWidget> {
  TextEditingController _pwdOtp;

  bool isLoadingState = false;

  initState() {
    super.initState();
    _pwdOtp = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressWidget(
      isLoading: isLoadingState,
      child: new Scaffold(
//      appBar: _buildBar(context),
        body:
            /*new Container(
          padding: EdgeInsets.all(16.0),*/
            DecoratedBox(
          position: DecorationPosition.background,
          decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter:
                      ColorFilter.mode(Colors.black, BlendMode.colorDodge),
                  image: AssetImage("images/bg_1x.jpg"),
                  fit: BoxFit.cover)),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Image.asset(
                  "images/app_logo.png",
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
              controller: _pwdOtp,
              style: TextStyle(color: Colors.white, fontSize: 18),
              decoration: new InputDecoration(
                labelText: 'OTP',
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
                'SUBMIT',
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
    if (_pwdOtp.text.isEmpty) {
      Utils.showToast("Invalid  number", Colors.redAccent, Colors.white);
      return;
    }

    AppHttpRequest.otpValidation(widget.number, _pwdOtp.text).then((response) {
      if (response is Map) {
        if (response['status'] == 'error') {
          Utils.showToast(
              response['message'], Colors.redAccent[800], Colors.white, 10.0);
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (BuildContext context) =>
                  MyHomePage(title: "Insomnia")));
        } else if (response['status'] == 'success') {
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
