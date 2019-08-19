import 'package:flutter/material.dart';
class AuthenticationScreen extends StatefulWidget
{
    // TODO: implement createState
    State<StatefulWidget> createState() => new _AutenticationState();

}
class _AutenticationState extends State<AuthenticationScreen>
{
  final TextEditingController _mobileNumber = new TextEditingController();
  String _mobile = "";
  // our default setting is to login, and we should switch to creating an account when the user chooses to

  _AutenticationState() {
    _mobileNumber.addListener(_mobileListen);
  }


  void _mobileListen() {
    if (_mobileNumber.text.isEmpty) {
      _mobile = "";
    } else {
      _mobile = _mobileNumber.text;
    }
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      appBar: _buildBar(context),
      body:
      /*new Container(
        padding: EdgeInsets.all(16.0),*/
      DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              image: AssetImage('assets/back.jpg'),
              fit: BoxFit.cover),
        ),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildTextFields(),
//            _buildButtons(),
          ],
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
              style: TextStyle(color: Colors.white,fontSize: 18),
              decoration: new InputDecoration(labelText: 'mobile',filled: true,labelStyle: TextStyle(color: Colors.white,fontSize: 16),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(width: 2,color: Colors.yellow)
                ), enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(width: 2,color: Colors.yellow),
                ),),
              keyboardType: TextInputType.phone,
            ),
          ),
          new Container(
            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
            width: 200,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
            child: new RaisedButton(
              child: new Text('Login',style: TextStyle(color: Colors.black),),
              onPressed: _loginPressed,
              padding: EdgeInsets.all(5.0),
              color: Colors.yellowAccent,
              shape: Border.all(color: Colors.yellow,style: BorderStyle.solid,width: 2),
            ),
          )
        ],
      ),
    );
  }


  // These functions can self contain any user auth logic required, they all have access to _user and _mobile

  void _loginPressed() {
    print('The user wants to login with  and $_mobile');
  }

}