import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:Amnesia/dtos/gallery_list_dto.dart';
import 'package:Amnesia/net/http_nw.dart';
import 'package:Amnesia/util/progress_indicator.dart';
import 'package:Amnesia/util/custom_dialog.dart' as customDialog;

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
    super.initState();
    loadingStatus = true;
    AppHttpRequest.getGalleryResponse().then((response) {
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
            crossAxisCount: 3,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: 3 / 4),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      int dialogImage = index;
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return new customDialog.Dialog(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                CachedNetworkImage(
                                  imageUrl: galleryListDTO
                                      .message[dialogImage == null
                                          ? index
                                          : dialogImage]
                                      .image,
                                  placeholder: (context, url) => Container(
                                    child: new CircularProgressIndicator(
                                        valueColor: new AlwaysStoppedAnimation(
                                            Colors.blue),
                                        strokeWidth: 5.0),
                                    height: 30,
                                    width: 30,
                                    alignment: Alignment.center,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      new Icon(Icons.error),
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      FlatButton(
                                          child: Text('Previous'),
                                          onPressed: () {
                                            setState(() {
                                              dialogImage =
                                                  dialogImage == null ||
                                                          dialogImage == 0
                                                      ? dialogImage
                                                      : dialogImage - 1;
                                            });
                                          }),
                                      FlatButton(
                                          child: Text('Next'),
                                          onPressed: () {
                                            setState(() {
                                              dialogImage = dialogImage == null
                                                  ? 1
                                                  : dialogImage ==
                                                          galleryListDTO.message
                                                                  .length -
                                                              1
                                                      ? dialogImage
                                                      : dialogImage + 1;
                                            });
                                          })
                                    ])
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );

/*                  showDialog(
                    context: context,
                    builder: (context) {
                      int dialogImage;
                      return new customDialog.Dialog(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            CachedNetworkImage(
                              imageUrl: galleryListDTO
                                  .message[dialogImage == null ? index : dialogImage].image,
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
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  index == 0
                                      ? Container()
                                      : FlatButton(
                                          child: Text('Previous'),
                                          onPressed: () {
                                            setState(() {});
                                          }),
                                  index == galleryListDTO.message.length - 1
                                      ? Container()
                                      : FlatButton(
                                          child: Text('Next'),
                                          onPressed: () {
                                            setState(() {
                                              dialogImage=dialogImage==null?1:dialogImage+1;
                                            });
                                          })
                                ])
                          ],
                        ),
                      );
                    },
                  );*/
                },
                child: CachedNetworkImage(
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
