import 'package:flutter/material.dart';
import 'package:insomnia_pub/ui/home/home_screen.dart';
import 'package:insomnia_pub/util/constants.dart';

import 'ui/event_list/events_list.dart';
import 'ui/home/carousel_with_indicator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appTitle = 'Insomnia';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData.dark().copyWith(
          primaryColor: Constants.COLORMAIN,
          appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Constants.COLORMAIN))),
      home: MyHomePage(title: appTitle),
    );
  }
}
/*
class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: getMainView(widget.ipage),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Events'),
              onTap: () {
                push(context, EventsList());
              },
            ),
            ListTile(
              title: Text('Special Offers'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Table Reservation'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Packages'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Feedback'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  push(BuildContext buildContext, Widget navWidgets) {
    Navigator.push(
      buildContext,
      MaterialPageRoute(builder: (context) => navWidgets),
    );
  }

  Widget getMainView(int id) {
    return Column(
      children: <Widget>[CarouselDemo(), getSelectedMainWidget(id)],
    );
  }

  Widget getSelectedMainWidget(int id) {}
}*/
