import 'package:flutter/material.dart';
import 'package:insomnia_pub/dtos/gallery_list_dto.dart';
import 'package:insomnia_pub/dtos/gallery_list_dto.dart';
import 'package:insomnia_pub/net/http_nw.dart';
import 'package:insomnia_pub/util/constants.dart';
import 'package:insomnia_pub/util/progress_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PhotoGallery extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PhotoGalleryState();
  }
}

class PhotoGalleryState extends State<PhotoGallery> {
  GalleryListDTO galleryListDTO;
  bool loadingStatus = true;

  @override
  void initState() {
    loadingStatus = true;
    AppHttpRequest.getEventListResponse().then((response) {
      setState(() {
        loadingStatus = false;
        try {
          galleryListDTO = GalleryListDTO.fromJson(response);
        } catch (e) {
          print("EXCEPTION : " + e);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProgressWidget(isLoading: loadingStatus, child: getMainView());
  }

  Widget getMainView() {
    if (galleryListDTO == null) {
      return Container();
    }
    var gridView = new GridView.builder(
        padding: EdgeInsets.only(left: 15, right: 15),
        shrinkWrap: true,
        itemCount: galleryListDTO.message.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 5, crossAxisSpacing: 5,childAspectRatio:3:4),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) => new AlertDialog(
                            content: CachedNetworkImage(
                              imageUrl: galleryListDTO.message[index].image,
                              placeholder: (context, url) => Container(
                                    child: new CircularProgressIndicator(
                                        valueColor: new AlwaysStoppedAnimation(Colors.blue),
                                        strokeWidth: 5.0),
                                    height: 30,
                                    width: 30,
                                    alignment: Alignment.center,
                                  ),
                              errorWidget: (context, url, error) => new Icon(Icons.error),
                            ),
                          ));
                },
                child: CachedNetworkImage(
                  imageUrl: galleryListDTO.message[index].image,
                  placeholder: (context, url) => Container(
                        child: new CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation(Colors.blue), strokeWidth: 5.0),
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                      ),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                )),
          );
        });
    return gridView;
  }
}
