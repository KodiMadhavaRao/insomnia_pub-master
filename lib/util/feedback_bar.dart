import 'package:flutter/material.dart';
import 'package:Amnesia/util/constants.dart';

class FeedBackBarWidget extends StatefulWidget {
  final String label;
  final ValueChanged<int> onRattingChange;
  int selectedRatting;

  FeedBackBarWidget(
      {Key key, this.label, this.onRattingChange, this.selectedRatting})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FeedBackBarWidgetState();
  }
}

class FeedBackBarWidgetState extends State<FeedBackBarWidget> {
  FeedBackBarWidgetState();

/*
  @override
  void initState() {
    super.initState();
    selectedRatting = widget.selectedRatting;
  }*/

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.all(8.0),
      height: 75,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xff8a8a8a), Colors.black],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            stops: [0.0, 0.5],
            tileMode: TileMode.repeated),
      ),
      child: Row(
        children: <Widget>[
          Text(
            widget.label,
            style: TextStyle(
                color: Constants.COLORMAIN,
                fontSize: 24,
                fontWeight: FontWeight.w700),
          ),
          Spacer(),
          getRattingIcon(
              widget.selectedRatting == 1
                  ? 'images/ratting_1.png'
                  : 'images/ratting_g_1.png',
              1),
          getRattingIcon(
              widget.selectedRatting == 2
                  ? 'images/ratting_2.png'
                  : 'images/ratting_g_2.png',
              2),
          getRattingIcon(
              widget.selectedRatting == 3
                  ? 'images/ratting_3.png'
                  : 'images/ratting_g_3.png',
              3),
          getRattingIcon(
              widget.selectedRatting == 4
                  ? 'images/ratting_4.png'
                  : 'images/ratting_g_4.png',
              4),
          getRattingIcon(
              widget.selectedRatting == 5
                  ? 'images/ratting_5.png'
                  : 'images/ratting_g_5.png',
              5),
        ],
      ),
    );
  }

  Widget getRattingIcon(String assetPath, int rating) {
    return InkWell(
      onTap: () {
        onRattingChanged(rating);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 10, bottom: 10),
        child: Image.asset(assetPath),
      ),
    );
  }

  onRattingChanged(int rating) {
    widget.selectedRatting = rating;
    widget.onRattingChange(widget.selectedRatting);
    setState(() {});
  }
}
