import 'package:flutter/material.dart';

class NumberCount extends StatefulWidget {
  final int initialCount;
  final String label;
  final ValueChanged<int> onCountValueChange;

  NumberCount({this.initialCount, this.label, this.onCountValueChange});

  @override
  _NumberCountState createState() => new _NumberCountState();
}

class _NumberCountState extends State<NumberCount> {
  int value;

  @override
  void initState() {
    super.initState();
    value=widget.initialCount;
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: <Widget>[
          Text(widget.label, style: TextStyle(color: Colors.black)),
          InkWell(
            onTap: ()=>onDecrementValue(),
            child: Card(
              child: Icon(Icons.remove, size: 20, color: Colors.white),
              shape: CircleBorder(),
            ),
          ),
          Text(
            '$value',
            style: TextStyle(color: Colors.black),
          ),
          InkWell(
            onTap: ()=>onIncrementValue(),
            child: Card(
              child: Icon(Icons.add, size: 20, color: Colors.white),
              shape: CircleBorder(),
            ),
          )
        ],
      ),
    );
  }

  void onDecrementValue() {
    if(value!=0&&value>0){
    setState(() {

      value--;
      widget.onCountValueChange(value);
    });
    }
  }

  void onIncrementValue() {
    setState(() {
      value++;
      widget.onCountValueChange(value);

    });

  }
}
