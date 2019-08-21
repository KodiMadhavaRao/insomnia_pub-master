import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

// Used for controlling whether the user is loggin or creating an account

final CREATE_POST_URL = 'http://geekadvises.com/insomnia/signup';

class _LoginPageState extends State<LoginScreen> {
  final TextEditingController _userName = new TextEditingController();
  final TextEditingController _mobileNumber = new TextEditingController();
  String _user = "";
  String _mobile = "";

  // our default setting is to login, and we should switch to creating an account when the user chooses to

  _LoginPageState() {
    _userName.addListener(_userListen);
    _mobileNumber.addListener(_mobileListen);
  }

  void _userListen() {
    if (_userName.text.isEmpty) {
      _user = "";
    } else {
      _user = _userName.text;
    }
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
          Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/bg_1x.png'), fit: BoxFit.fill),
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
//          Image(image: AssetImage("assets/images/letter_logo.png"), width: 300, height: 100),
          new Container(
            margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: new TextField(
              controller: _userName,
              style: TextStyle(color: Colors.white, fontSize: 18),
              decoration: new InputDecoration(
                labelText: 'user name',
                filled: true,
                labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(width: 1, color: Colors.yellow)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(width: 1, color: Colors.yellow),
                ),
              ),
            ),
          ),
          new Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
//            padding: EdgeInsets.all(5),
            child: new TextField(
              controller: _mobileNumber,
              style: TextStyle(color: Colors.white, fontSize: 18),
              decoration: new InputDecoration(
                labelText: 'mobile',
                filled: true,
                labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(width: 1, color: Colors.yellow[600])),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(width: 1, color: Colors.yellow[600]),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
          ),
          new Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            width: 200,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
            child: new RaisedButton(
              child: new Text(
                'SIGNUP',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: _loginPressed,
              padding: EdgeInsets.all(5.0),
              color: Colors.yellow[600],
              shape: Border.all(color: Colors.yellow[600], style: BorderStyle.solid, width: 2),
            ),
          )
        ],
      ),
    );
  }

  // These functions can self contain any user auth logic required, they all have access to _user and _mobile

  void _loginPressed() async {
    Post newPost = new Post(mobile: _mobile, name: _user);
    Post p = await createPost(CREATE_POST_URL, body: newPost.toMap());
    print(p.name);
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _user;
    map["mobile"] = _mobile;

    return map;
  }

  Future<Post> createPost(String url, {Map body}) async {
    return http.post(url, body: body).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return Post.fromJson(json.decode(json.toString()));
    });
  }
}

class Post {
  final String name;
  final String mobile;

  Post({this.name, this.mobile});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      name: json['name'],
      mobile: json['mobile'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["mobile"] = mobile;

    return map;
  }
}
