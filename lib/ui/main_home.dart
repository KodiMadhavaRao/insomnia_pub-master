import 'package:flutter/material.dart';
import 'package:insomnia_pub/ui/event_list/events_list.dart';
import 'package:insomnia_pub/ui/feedback/feedback_widget.dart';
import 'package:insomnia_pub/ui/offers/offers.dart';
import 'package:insomnia_pub/util/constants.dart';
import 'package:insomnia_pub/util/progress_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home/home_screen.dart';
import 'packages/packages.dart';
import 'photo_gallery/photo_gallery.dart';
import 'table_booking/table_booking.dart';

class MainHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainHomeState();
  }
}

class MainHomeState extends State<MainHome> {
  List<String> alIcons = new List();
  List<String> description = new List();
  List<int> ids = new List();

  @override
  Widget build(BuildContext context) {
    return getMainView();
  }

  @override
  void initState() {
    alIcons = [
      "images/Events_3.png",
      "images/Special Offers_3.png",
      "images/Table reservation_3.png",
      "images/Gallery_3.png",
      "images/Packages_3.png",
      "images/Feedback_3.png"
    ];
    description = [
      "Events",
      "Special offers",
      "Table reservation",
      "Gallery",
      "Packages",
      "Feedback"
    ];
    ids = [
      Constants.EVENTS,
      Constants.OFFERS,
      Constants.TABLEBOOKING,
      Constants.PHOTOGALLERY,
      Constants.PACKAGES,
      Constants.FEEDBACK
    ];
  }

  Widget getMainView() {
    return Column(
      children: <Widget>[getFindMeView(), Expanded(child: getHomeView())],
    );
  }

  Widget getFindMeView() {
    double mapHeight = MediaQuery.of(context).size.width * 0.13;
    return InkWell(
      onTap: () {
        launchMap();
      },
      child: Stack(
        children: <Widget>[
          Image.asset(
            "images/location.PNG",
            height: mapHeight,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            height: mapHeight,
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(150),
              /*gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.grey.withOpacity(0.0),
                      Colors.grey.withOpacity(1.0),
                    ],
                    stops: [
                      0.0,
                      1.0
                    ])*/
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 8.0),
                    child: Icon(
                      Icons.arrow_forward,
                      size: 30,
                      color: Colors.yellow,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Icon(
                      Icons.arrow_forward,
                      size: 30,
                      color: Colors.yellow,
                    ),
                  ),
                  Text(
                    "Find Me",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getHomeView() {
    var gridView = new GridView.builder(
        padding: EdgeInsets.only(
            top: 25,
            left: 50,
            right: 50,
            bottom: 50),
        shrinkWrap: true,
        itemCount: 6,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1,
            crossAxisCount: 2,
            crossAxisSpacing: 25,
            mainAxisSpacing: 25),
        itemBuilder: (BuildContext context, int index) {
          return getMainOptionsView(
              alIcons[index], description[index], ids[index]);
        });
    return gridView;
  }

  getMainOptionsView(String icon, String name, int id) {
    return InkWell(
      onTap: () {
//        push(context,getSelectedMainWidget(id));
        HomeScreenState homeScreenState = MyHomePage.of(context);
        setState(() {
          homeScreenState.rebuild(id);
        });
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
//        padding: const EdgeInsets.only(top: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          gradient: LinearGradient(
              colors: [Color(0xff55545A), Color(0xff34353A)],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              stops: [0.0, 0.8],
              tileMode: TileMode.repeated),
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  icon,
                  height: 45,
                  width: 45,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(name),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  push(BuildContext buildContext, Widget widget) {
    setState(() {
      Navigator.push(
        buildContext,
        MaterialPageRoute(builder: (context) => widget),
      );
    });
  }

  Widget getSelectedMainWidget(int id) {
    switch (id) {
      case Constants.EVENTS:
        return EventsList();
        break;
      case Constants.OFFERS:
        return OffersWidgets();
        break;
      case Constants.PACKAGES:
        return Packages();
        break;
      case Constants.PHOTOGALLERY:
        return PhotoGallery();
        break;
      case Constants.TABLEBOOKING:
        return TableBooking(false);
        break;
      case Constants.FEEDBACK:
        return FeedBackWidget();
        break;
    }
  }

  launchMap({String lat = "17.4312763", String long = "78.4069515"}) async {
    var mapSchema = 'geo:$lat,$long';
    if (await canLaunch(mapSchema)) {
      await launch(mapSchema);
    } else {
      throw 'Could not launch $mapSchema';
    }
  }
}
