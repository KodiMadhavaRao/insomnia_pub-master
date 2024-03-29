import 'package:flutter/material.dart';
import 'package:Amnesia/ui/event_list/events_list.dart';
import 'package:Amnesia/ui/feedback/feedback_widget.dart';
import 'package:Amnesia/ui/offers/offers.dart';
import 'package:Amnesia/util/constants.dart';
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
  List<String> alIcons;
  List<String> description;
  List<int> ids;

  @override
  Widget build(BuildContext context) {
    return getMainView();
  }

  @override
  void initState() {
    super.initState();
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
    return InkWell(
      onTap: () {
        launchMap();
      },
      child: Image.asset(
        "images/map.png",
        height: 50,
        width: double.infinity,
        fit: BoxFit.cover,
        color: Colors.grey.withAlpha(100),
        colorBlendMode: BlendMode.difference,
      ),
    );
  }

  Widget getHomeView() {
    var gridView = new GridView.builder(
        padding: EdgeInsets.only(top: 25, left: 50, right: 50, bottom: 50),
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
