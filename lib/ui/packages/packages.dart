import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Amnesia/dtos/package_list_dto.dart';
import 'package:Amnesia/net/http_nw.dart';
import 'package:Amnesia/ui/table_booking/table_booking.dart';
import 'package:Amnesia/util/constants.dart';
import 'package:Amnesia/util/progress_indicator.dart';
import 'package:Amnesia/util/custom_dialog.dart' as customDialog;

class Packages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PackagesState();
  }
}

class PackagesState extends State<Packages> {
  @override
  Widget build(BuildContext context) {
    return ProgressWidget(
        isLoading: loadingStatus, child: getMainView(context));
  }

  PackageListDTO packageListDTO;
  bool loadingStatus = true;

  @override
  void initState() {
    super.initState();
    loadingStatus = true;
    AppHttpRequest.getPackagesResponse().then((response) {
      setState(() {
        loadingStatus = false;
        try {
          packageListDTO = PackageListDTO.fromJson(response);
        } catch (e) {
          print("EXCEPTION : " + e);
        }
      });
    });
  }

  Widget getMainView(BuildContext context) {
    if (packageListDTO == null) {
      return Container();
    }
    var gridView = new GridView.builder(
        padding: EdgeInsets.only(left: 20.0),
        shrinkWrap: true,
        itemCount: packageListDTO.message.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1,
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 25),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              openTableBookingDialog(context);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: LimitedBox(
                    child: Image.network(
                      packageListDTO.message[index].image,
                      fit: BoxFit.fill,
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                /*Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 2),
                  child: Text(
                    'Chees overloaded garlic bread',
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
//                packageListDTO.message[index].specialOffersText,
                    'TO DO',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                )*/
              ],
            ),
          );
        });
    return gridView;
  }

  void openTableBookingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => customDialog.Dialog(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.53,
          child: TableBooking(true),
        ),
      ),
    );
  }
}
