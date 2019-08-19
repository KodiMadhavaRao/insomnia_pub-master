import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insomnia_pub/dtos/offer_list_dto.dart';
import 'package:insomnia_pub/net/http_nw.dart';
import 'package:insomnia_pub/util/constants.dart';
import 'package:insomnia_pub/util/progress_indicator.dart';

class OffersWidgets extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OffersWidgetsState();
  }
}

class OffersWidgetsState extends State<OffersWidgets> {
  bool loadingStatus = true;
  OfferListDTO offerList;

  @override
  Widget build(BuildContext context) {
    return ProgressWidget(isLoading: loadingStatus, child: getMainView());
  }

  @override
  void initState() {
    super.initState();
    loadingStatus = true;
    AppHttpRequest.getOffersResponse().then((response) {
      setState(() {
        loadingStatus = false;
        try {
          offerList = OfferListDTO.fromJson(response);
        } catch (e) {
          print("EXCEPTION" + e);
        }
      });
    });
  }

  Widget getMainView() {
    if (offerList == null) {
      return Container();
    }
    var gridView = new GridView.builder(
        padding: EdgeInsets.only(left: 20.0),
        shrinkWrap: true,
        itemCount: offerList.message.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 25),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
//                flex: 1,
                child: Image.network(
                    offerList.message[index].image,
//                  'https://source.unsplash.com/210x210/?food',
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2, bottom: 2),
                child: Text(
                  offerList.message[index].specialOffersText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Constants.COLORMAIN,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Text(
                  offerList.message[index].specialOffersText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              )
            ],
          );
        });
    return gridView;
  }
}
