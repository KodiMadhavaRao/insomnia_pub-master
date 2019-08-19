import 'package:flutter/material.dart';
import 'package:insomnia_pub/util/constants.dart';
import 'package:insomnia_pub/util/number_counter.dart';

class TableBooking extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TableBookingState();
  }
}

class TableBookingState extends State<TableBooking> {
  DateTime currentDate;
  TimeOfDay currentTime;

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
    currentTime = TimeOfDay.now();
//    currentTime.format(context);
  }

  @override
  Widget build(BuildContext context) {
    return getMainView();
  }

  Widget getMainView() {
    return SingleChildScrollView(
        child: Container(margin: EdgeInsets.all(8.0), child: createForm()));
  }

  Column createForm() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        getLabelvalueView(
            "YOUR NAME",
            Icon(
              Icons.account_circle,
              color: Colors.black,
            ),
            "Your Name"),
        getLabelvalueView("EMAIL ADDRESS",
            Icon(Icons.email, color: Colors.black), "Email Address"),
        getLabelvalueView(
            "MOBILE", Icon(Icons.phone_android, color: Colors.black), "Mobile"),
        getGuestsView(),
        getDateTimePicker(),
        Padding(padding: EdgeInsets.all(5)),
        getReservationButton()
      ],
    );
  }

  Widget getLabelvalueView(String label, Icon icon, String hint) {
    return Column(children: <Widget>[
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
    ], crossAxisAlignment: CrossAxisAlignment.start);
  }

  Widget getGuestsView() {
    return Row(
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
                child: Text("NO OF GUESTS GOING"),
              ),
              Container(
//                width: double.infinity,
                height: 35,
                color: Colors.white,
                child: DropdownButtonHideUnderline(
                  child: Theme(
                    data: ThemeData.light(),
                    child: DropdownButton(
                      isExpanded: true,
                      items: getItem(),
                      onChanged: onDropDownChange,
                      style: TextStyle(color: Colors.black),
                      /* icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                        size: 32,
                      ),*/
                    ),
                  ),
                ),
              ),
            ],
          ),
          flex: 4,
        )
      ],
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
//    setState(() {});
  }

  void onFemaleChange(int value) {
//    setState(() {});
  }

  List<DropdownMenuItem<int>> getItem() {
    List<DropdownMenuItem<int>> items = [
      DropdownMenuItem(
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            "1 People",
            softWrap: true,
          ),
        ),
      ),
      DropdownMenuItem(
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            "2 People",
            softWrap: true,
          ),
        ),
      ),
      DropdownMenuItem(
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            "3 People",
            softWrap: true,
          ),
        ),
      ),
      DropdownMenuItem(
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

  void onDropDownChange(int value) {}

  Container getReservationButton() {
    return Container(
        width: double.infinity,
        height: 45,
        child: RaisedButton(
          color: Constants.COLORMAIN,
          child: Text("Reserve Table"),
          onPressed: () {},
        ));
  }

  Widget getDateTimePicker() {
    return Row(
      children: <Widget>[
        Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
                    child: Text("DATE")),
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
                          lastDate: DateTime(
                              currentDate.year, currentDate.month + 2))
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
                          '${currentDate.day} / ${currentDate
                              .month} / ${currentDate.year}',
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
                    showTimePicker(
                        initialTime: currentTime, context: context)
                        .then((time) {
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
                        '${currentTime.hour} : ${currentTime
                            .minute} ',/*${currentTime.period.index == 0 ? 'am' : 'pm'}',*/
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
          ), flex
            :
        4
          ,
        )
      ]
      ,
    );
  }
}
