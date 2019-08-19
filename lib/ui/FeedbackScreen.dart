

import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => new FeedbackState();

}
class FeedbackState extends State<FeedbackScreen>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
//            _buildTextFields(),
//            _buildButtons(),
          ],
        ),
      ),
    );
  }

}