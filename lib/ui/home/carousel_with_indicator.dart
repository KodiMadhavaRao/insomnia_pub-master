import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:Amnesia/dtos/slider_data.dart';
import 'package:Amnesia/net/http_nw.dart';
import 'package:Amnesia/util/progress_indicator.dart';

List<String> imgList = new List();
/*[
  "images/home_sl_1.jpg",
  "images/home_sl_2.jpg",
  "images/home_sl_3.jpg",
  "images/home_sl_4.jpg",
];*/

final Widget placeholder = Container(color: Colors.grey);

final List child = map<Widget>(
  imgList,
  (index, i) {
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: CachedNetworkImage(
              imageUrl: imgList[index],
              placeholder: (context, url) => Container(
                child: new CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation(Colors.blue),
                    strokeWidth: 5.0),
                height: 30,
                width: 30,
                alignment: Alignment.center,
              ),
              errorWidget: (context, url, error) => new Icon(Icons.error),
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
            //            child: Image.network(i, fit: BoxFit.cover, width: 1000.0),
            //            child: Image.asset(imgList[index], fit: BoxFit.cover, width: 1000.0),
          ),
        ),
        Center(
            child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Welcome !",
                style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "INSOMINIA-THE MOST HOT & HAPPENING \n PLACE IN HYDERABAD",
                style: TextStyle(
                    backgroundColor: Colors.black45,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )),
      ],
    );
  },
).toList();

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class CarouselWithIndicator extends StatefulWidget {
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;
  bool loadingStatus = true;
  SliderListDTO sliderListDTO;

  @override
  void initState() {
    super.initState();
    loadingStatus = true;
    AppHttpRequest.getslidersResponse().then((response) {
      setState(() {
        try {
          sliderListDTO = SliderListDTO.fromJson(response);
          fillList();
          loadingStatus = false;
        } catch (e) {
          loadingStatus = false;
          print("EXCEPTION : " + e);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return loadingStatus
        ? Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.25,
            child: CircularProgressIndicator(),
            alignment: Alignment.center,
          )
        : Stack(children: [
            CarouselSlider(
              viewportFraction: 1.0,
              items: child,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index) {
                setState(() {
                  _current = index;
                });
              },
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: map<Widget>(
                  imgList,
                  (index, url) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? Color.fromRGBO(0, 0, 0, 0.9)
                              : Color.fromRGBO(0, 0, 0, 0.4)),
                    );
                  },
                ),
              ),
            ),
          ]);
  }

  void fillList() {
    for (int i = 0; i < sliderListDTO.message.length; i++) {
      imgList.add(sliderListDTO.message[i].image);
    }
  }
}

class CarouselDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselWithIndicator();
  }
}
