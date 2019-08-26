import 'dart:collection';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:insomnia_pub/net/http_nw.dart';
import 'package:insomnia_pub/util/constants.dart';
import 'package:insomnia_pub/util/number_counter.dart';
import 'package:insomnia_pub/util/progress_indicator.dart';
import 'package:insomnia_pub/util/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TableBooking extends StatefulWidget {
  bool showCloseButton;

  TableBooking(this.showCloseButton);

  @override
  State<StatefulWidget> createState() {
    return TableBookingState();
  }
}

class TableBookingState extends State<TableBooking> {
  bool loadingStatus = false;
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  int dropDownValue;
  int maleCount=0, femaleCount=0;
  int iTotalCount=0;
  DateTime currentDate;
  TimeOfDay currentTime;

  int iUserid,iMobileNo;
  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
    currentTime = TimeOfDay.now();
    widget.showCloseButton = widget.showCloseButton == null ? false : widget.showCloseButton;
    dropDownValue = 1;
    SharedPrefencesHelper.getUserId().then((int userId){
      iUserid=userId;
    });
    SharedPrefencesHelper.getMobileNo().then((int mobileNo){
      numberController.text=mobileNo.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProgressWidget(isLoading: loadingStatus, child: getMainView());
  }

  Widget getMainView() {
    return SingleChildScrollView(
        child: Container(margin: EdgeInsets.all(8.0), child: createForm()));
  }

  Column createForm() {
    return Column(
      mainAxisSize: widget.showCloseButton?MainAxisSize.min:MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        showCloseButton(),
        getLabelvalueView(
            "YOUR NAME",
            Icon(
              Icons.account_circle,
              color: Colors.black,
            ),
            "Your Name",
            TextInputType.text,
            nameController,),
        getLabelvalueView(
            "EMAIL ADDRESS",
            Icon(
              Icons.email,
              color: Colors.black,
            ),
            "Email Address",
            TextInputType.emailAddress,
            emailController),
        getLabelvalueView("MOBILE", Icon(Icons.phone_android, color: Colors.black), "Mobile",
            TextInputType.number, numberController),
        getGuestsView(),
        getDateTimePicker(),
        Padding(padding: EdgeInsets.all(5)),
        getReservationButton()
      ],
    );
  }

  Widget getLabelvalueView(String label, Icon icon, String hint, TextInputType textType,
      TextEditingController textEditController) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
          child: Text(label),
        ),
        new Container(
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            border: new Border.all(
              color: Colors.white,
              width: 1.0,
            ),
          ),
          child: Container(
            color: Colors.white,
            child: new TextField(
              controller: textEditController,
              keyboardType: textType,
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.black),
              decoration: new InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey[700]),
                prefixIcon: icon,
                border: InputBorder.none,
              ),
            ),
          ),
        )
      ], crossAxisAlignment: CrossAxisAlignment.start),
    );
  }

  Widget getGuestsView() {
    iTotalCount=maleCount+femaleCount;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
                      child: Text("SELECT GUEST/S")),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          NumberCount(
                            initialCount: 0,
                            label: "Male",
                            onCountValueChange: onMaleChange,
                          ),
                          NumberCount(
                            initialCount: 0,
                            label: "Female",
                            onCountValueChange: onFemaleChange,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              flex: 6),
          Padding(
            padding: EdgeInsets.only(right: 5),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
                  child: Text(
                    "NO OF GUESTS GOING",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Container(
                width: double.infinity,
                  height: 35,
                  color: Colors.white,
                  child: Align(child: Container(child: Text(iTotalCount.toString()+" Persons",style: TextStyle(color: Colors.black,fontSize: 18),),),),
                ),
              ],
            ),
            flex: 4,
          )
        ],
      ),
    );
  }

  Widget getCountView(String text) {
    return Row(
      children: <Widget>[
        Text(text, style: TextStyle(color: Colors.black)),
        Card(
          child: Icon(Icons.remove, size: 16, color: Colors.white),
          shape: CircleBorder(),
        ),
        Text(
          "1",
          style: TextStyle(color: Colors.black),
        ),
        Card(
          child: Icon(Icons.add, size: 16, color: Colors.white),
          shape: CircleBorder(),
        )
      ],
    );
  }

  void onMaleChange(int value) {
    setState(() {
      maleCount = value;
    });

  }

  void onFemaleChange(int value) {
    setState(() {
      femaleCount = value;
    });
  }

  List<DropdownMenuItem<int>> getItem() {
    List<DropdownMenuItem<int>> items = [
      DropdownMenuItem(
        value: 1,
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            "1 People",
            softWrap: true,
          ),
        ),
      ),
      DropdownMenuItem(
        value: 2,
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            "2 People",
            softWrap: true,
          ),
        ),
      ),
      DropdownMenuItem(
        value: 3,
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            "3 People",
            softWrap: true,
          ),
        ),
      ),
      DropdownMenuItem(
        value: 4,
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            "4 People",
            softWrap: true,
          ),
        ),
      ),
    ];
    return items;
  }

  void onDropDownChange(int value) {
    setState(() {
      dropDownValue = value;
    });
  }

  Container getReservationButton() {
    return Container(
        width: double.infinity,
        height: 45,
        child: RaisedButton(
          color: Constants.COLORMAIN,
          child: Text("Reserve Table"),
          onPressed: () {
            setState(() {
              loadingStatus = true;
            });
            AppHttpRequest.saveTableReservation(formMapData()).then((String body) {
              handleTableBookingSaveResponse(body);
            });
          },
        ));
  }

  Widget getDateTimePicker() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(bottom: 5.0, top: 5.0), child: Text("DATE")),
                  Container(
//                width: double.infinity,
                    height: 35,
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        showDatePicker(
                                context: context,
                                firstDate: currentDate,
                                initialDate: currentDate,
                                lastDate: DateTime(currentDate.year, currentDate.month + 2))
                            .then((date) {
                          if (date != null)
                            setState(() {
                              currentDate = date;
                            });
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            Icons.date_range,
                            size: 24,
                            color: Colors.black,
                          ),
                          Text(
                            '${currentDate.day} / ${currentDate.month} / ${currentDate.year}',
//                            currentDate.toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            size: 24,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              flex: 6),
          Padding(
            padding: EdgeInsets.only(right: 5),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
                  child: Text("TIME"),
                ),
                Container(
//                width: double.infinity,
                  height: 35,
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      showTimePicker(initialTime: currentTime, context: context).then((time) {
                        if (time != null)
                          setState(() {
                            currentTime = time;
                          });
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(
                          Icons.timelapse,
                          size: 24,
                          color: Colors.black,
                        ),
                        Text(
                          '${currentTime.hour} : ${currentTime.minute} ',
                          /*${currentTime.period.index == 0 ? 'am' : 'pm'}',*/
//                          currentTime.toString(),
                          style: TextStyle(color: Colors.black),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          size: 24,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            flex: 4,
          )
        ],
      ),
    );
  }

  Widget showCloseButton() {
    return widget.showCloseButton
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "TABLE BOOKING",
                    style: TextStyle(color: Constants.COLORMAIN, fontSize: 18),
                  ),
                ),
                flex: 2,
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 4.0),
                      child: Icon(Icons.close),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              )
            ],
          )
        : Container();
  }

  Map<String, String> formMapData() {
    Map<String, String> resrevationData = new HashMap();
    resrevationData["user_id"] = iUserid.toString();
    resrevationData["user_name"] = nameController.text;
    resrevationData["user_mobile"] = numberController.text;
    resrevationData["males"] = maleCount.toString();
    resrevationData["females"] = femaleCount.toString();
    resrevationData["members"] = (maleCount+femaleCount).toString();
//    resrevationData["date_time"] = formatDateTime();
    resrevationData["date"] = formatDate();
    resrevationData["time"] = formatTime();
    resrevationData["status"] = 0.toString();
    return resrevationData;
  }

  String formatDateTime() {
    return currentDate.day.toString() +
        "-" +
        currentDate.month.toString() +
        "-" +
        currentDate.year.toString() +
        " " +
        currentTime.hour.toString() +
        ":" +
        currentTime.minute.toString();
  }


  String formatDate() {
    return currentDate.day.toString() +
        "-" +
        currentDate.month.toString() +
        "-" +
        currentDate.year.toString();
  }


  String formatTime() {
    return currentTime.hour.toString() +
        ":" +
        currentTime.minute.toString();
  }

  void handleTableBookingSaveResponse(String body) {
    setState(() {
      loadingStatus = false;
    });
    Map<String, dynamic> jsonData = json.decode(body);
    if (jsonData["status"] == "success") {
      Fluttertoast.showToast(
          msg: jsonData["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Constants.COLORMAIN,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: jsonData["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

}
