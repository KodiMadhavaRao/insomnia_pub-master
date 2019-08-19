import 'package:flutter/material.dart';
import 'package:insomnia_pub/net/http_nw.dart';
import 'package:insomnia_pub/util/constants.dart';
import 'package:insomnia_pub/util/feedback_bar.dart';
import 'package:insomnia_pub/util/progress_indicator.dart';

class FeedBackWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FeedBackWidgetState();
  }
}

class FeedBackWidgetState extends State<FeedBackWidget> {
  String foodRatting = "";
  String serviceRatting = "";
  String settingRatting = "";
  String overAllRatting = "";
  TextEditingController reviewText;

  bool loadingStatus = false;
@override
  void initState() {
    super.initState();
    reviewText = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressWidget(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            FeedBackBarWidget(
              label: "Food",
              onRattingChange: foodRattingChange,
            ),
            FeedBackBarWidget(
              label: "Service",
              onRattingChange: serviceRattingChange,
            ),
            FeedBackBarWidget(
              label: "Setting",
              onRattingChange: settingRattingChange,
            ),
            FeedBackBarWidget(
              label: "Over all",
              onRattingChange: overAllRattingChange,
            ),
            getReviewTitle("Your Review"),
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
//              margin: EdgeInsets.all(15),
              height: 180,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border.all(
                      color: Constants.COLORMAIN.withAlpha(100), width: 2)),
              child: new TextField(
                controller: reviewText,
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black),
                decoration: new InputDecoration(
                  hintText: "Type here",
                  hintStyle: TextStyle(color: Colors.grey[700]),
                  border: InputBorder.none,
                ),
              ),
            ),
            getSubmitButton(),
          ],
        ),
      ),
      isLoading: loadingStatus,
    );
  }

  Widget getReviewTitle(String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 15, left: 15, bottom: 8),
      child: Text(
        value,
        textDirection: TextDirection.ltr,
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Constants.COLORMAIN),
      ),
    );
  }

  void foodRattingChange(int value) {
    this.foodRatting = setRatting(value);
  }

  void serviceRattingChange(int value) {
    this.serviceRatting = setRatting(value);
  }

  void settingRattingChange(int value) {
    this.settingRatting = setRatting(value);
  }

  void overAllRattingChange(int value) {
    this.overAllRatting = setRatting(value);
  }

  Widget getSubmitButton() {
    return InkWell(
      onTap: () => onSubmitRatting(),
      child: Container(
        margin: EdgeInsets.only(top: 30.0),
        padding: EdgeInsets.only(top: 15, bottom: 15),
//      height: 75,
        width: 200,
        alignment: Alignment.center,
        decoration: BoxDecoration(
//        border: Border.all(style: ),
          borderRadius: BorderRadius.all(Radius.circular(15)),
          gradient: LinearGradient(
              colors: [Color(0xffe2cda0), Constants.COLORMAIN],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              stops: [0.0, 1.0],
              tileMode: TileMode.repeated),
        ),
        child: Text(
          "SUBMIT",
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
    );
  }

  void onSubmitRatting() {
    AppHttpRequest.submitFeedBack(121, foodRatting, serviceRatting, settingRatting,
            overAllRatting, reviewText.text)
        .then((response) {
      setState(() {
        reviewText.text = "";
        loadingStatus = false;
      });
    });
    setState(() {
      loadingStatus = true;
    });
  }

  String setRatting(int value) {
    switch (value) {
      case 0:
        return "Poor";
        break;
      case 1:
        return "average";
        break;
      case 2:
        return "good";
        break;
      case 3:
        return "very good";
        break;
      default:
        return "";
        break;
    }
  }
}
