import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insomnia_pub/util/constants.dart';

class Packages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PackagesState();
  }
}

class PackagesState extends State<Packages> {
  @override
  Widget build(BuildContext context) {
    return getMainView();
  }

  Widget getMainView() {
    var gridView = new GridView.builder(
        padding: EdgeInsets.only(left: 20.0),
        shrinkWrap: true,
        itemCount: 25,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1, crossAxisCount: 2, mainAxisSpacing: 25),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: LimitedBox(
                  child: Image.asset(
                    "images/insomnialogo.png",
                  )/*Image.network(
//                    eventL1istDTO.message[index].image,
                    'https://source.unsplash.com/210x210/?food',
                    fit: BoxFit.fill,
                  )*/,
                ),
              ),
              Padding(
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
//                offerList.message[index].specialOffersText,
                  '(freshly backed bread herbed with exotic veggies and loaded with cheese)',
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
