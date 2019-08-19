import 'package:flutter/material.dart';
import 'package:insomnia_pub/net/http_nw.dart';
import 'package:insomnia_pub/util/constants.dart';
import 'package:insomnia_pub/util/progress_indicator.dart';

class PhotoGallery extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PhotoGalleryState();
  }
}

class PhotoGalleryState extends State<PhotoGallery> {
  bool loadingStatus;

  @override
  void initState() {
    super.initState();
    loadingStatus=false;
    /* AppHttpRequest.getGalleryResponse().then((response){
      String data=response;
      setState(() {
        loadingStatus=false;
      });

    });*/

  }
  @override
  Widget build(BuildContext context) {
    return ProgressWidget(isLoading: loadingStatus,child: getMainView());
  }

  Widget getMainView() {
    var gridView = new GridView.builder(
      padding: EdgeInsets.only(left: 15,right: 15),
        shrinkWrap: true,
        itemCount: 20,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 5,crossAxisSpacing: 5),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: InkWell(
              onTap: (){
                showDialog(
                    context: context,
                    builder: (_) => new AlertDialog(
                      content:  Image.asset(
                        "images/insomnialogo.png",
                        ),
                      )
                    );
              },
              child: Image.asset(
                "images/insomnialogo.png",
              ),
            )/*Image.network(
              "https://source.unsplash.com/210x210/?people",
              )*/,
          );
        });
    return gridView;
  }


}
