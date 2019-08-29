import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Amnesia/dtos/offer_list_dto.dart';
import 'package:Amnesia/net/http_nw.dart';
import 'package:Amnesia/util/constants.dart';
import 'package:Amnesia/util/progress_indicator.dart';
import 'package:Amnesia/util/custom_dialog.dart' as customDialog;

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
            crossAxisCount: 2, mainAxisSpacing: 25, crossAxisSpacing: 8.0),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) => new customDialog.Dialog(
                        child: CachedNetworkImage(
                          imageUrl: offerList.message[index].image,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
//                flex: 1,
                  child: CachedNetworkImage(
                    imageUrl: offerList.message[index].image,
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
//                Padding(
//                  padding: const EdgeInsets.only(right: 25),
//                  child: Text(
//                    offerList.message[index].specialOffersText,
//                    maxLines: 2,
//                    overflow: TextOverflow.ellipsis,
//                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
//                  ),
//                )
              ],
            ),
          );
        });
    return gridView;
  }
}
