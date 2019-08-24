import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insomnia_pub/dtos/event_list_dto.dart';
import 'package:insomnia_pub/net/http_nw.dart';
import 'package:insomnia_pub/util/progress_indicator.dart';

class EventsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EventsListState();
  }
}

class EventsListState extends State<EventsList> {
  EventListDTO eventL1istDTO;
  bool loadingStatus = true;

  @override
  Widget build(BuildContext context) {
    return ProgressWidget(isLoading: loadingStatus, child: getMainView());
  }

  @override
  void initState() {
    super.initState();
    loadingStatus = true;
//    offerList=null;
    AppHttpRequest.getEventListResponse().then((response) {
//      String data=response;
      setState(() {
        loadingStatus = false;
        try {
          eventL1istDTO = EventListDTO.fromJson(response);
        } catch (e) {
          print("EXCEPTION : " + e);
        }
      });
    });
  }

  Widget getMainView() {
    if (eventL1istDTO == null) {
      return Container();
    }
    var gridView = new GridView.builder(
        shrinkWrap: true,
        itemCount: eventL1istDTO.message.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 8.0, mainAxisSpacing: 35.0),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) => new AlertDialog(
                        content: CachedNetworkImage(
                          imageUrl: eventL1istDTO.message[index].image,
                          placeholder: (context, url) => Container(
                            child: new CircularProgressIndicator(
                                valueColor:
                                    new AlwaysStoppedAnimation(Colors.blue),
                                strokeWidth: 5.0),
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                          ),
                          errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
                        ),
                      ));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: CachedNetworkImage(
                    imageUrl: eventL1istDTO.message[index].image,
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
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    eventL1istDTO.message[index].eventText,
                    maxLines: 2,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                  ),
                )
              ],
            ),
          );
        });
    return gridView;
  }
}
