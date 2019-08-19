import 'package:flutter/material.dart';
import 'package:insomnia_pub/util/constants.dart';

class FeedBackBarWidget extends StatefulWidget {
  final String label;
  final ValueChanged<int> onRattingChange;

  const FeedBackBarWidget({Key key, this.label, this.onRattingChange})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FeedBackBarWidgetState();
  }
}

class FeedBackBarWidgetState extends State<FeedBackBarWidget> {
  int selectedRatting;
  @override
  void initState() {
    super.initState();
    selectedRatting=-1;
  }

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
          getRattingIcon(selectedRatting==0?'images/disapoint_d.png':'images/disapoint.png', 0),
          getRattingIcon(selectedRatting==1?'images/calm_d.png':'images/calm.png', 1),
          getRattingIcon(selectedRatting==2?'images/smile_d.png':'images/smile.png', 2),
          getRattingIcon(selectedRatting==3?'images/smile_d.png':'images/smile.png', 3),
        ],
      ),
    );
  }

  Widget getRattingIcon(String assetPath, int rating) {
    return InkWell(
      onTap:(){onRattingChanged(rating);} ,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 10, bottom: 10),
        child: Image.asset(assetPath),
      ),
    );
  }

  onRattingChanged(int rating) {
    selectedRatting=rating;
    widget.onRattingChange(selectedRatting);
    setState(() {
    });
  }
}
