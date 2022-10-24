import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import "package:http/http.dart" as http;
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workers/network/Network.dart';
import 'package:workers/session/Session.dart';
import 'package:workers/values/Theme.dart';
import 'package:workers/values/colors.dart';
import 'package:workers/values/strings.dart';
import 'package:workers/widgets/widgets.dart';

import '../location/LocationManager.dart';

class AddPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddPageState();
  }
}

class _AddPageState<AddPage> extends State {
  late List newsdata = [];

  bool hasSubmitted = false;

  bool isSubmitting = false;

  Widget submitWidget = Text("Submit Task");

  TextEditingController placeController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController taskController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isSubmitting = false;
    submitWidget = Text("Submit Task");
    hasSubmitted = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      body: Stack(
        children: [
          Positioned(
              child: Visibility(
                child: loadingWidget(),
                visible: !hasSubmitted,
              ),
              top: 0,
              bottom: 0,
              left: 0,
              right: 0),
          Container(
            padding: SystemTheme.fabMargin,
            child: ListView(
              children: [
                labelText(context, "Project of the Day"),
                textField(context, "", taskController, Icons.task),
                labelText(context,
                    "Project Desciption ie (What will be done  today)"),
                largeTextField(context, "", descController, Icons.details,
                    size: 200.0),
                labelText(
                    context, "Project Place ie (Where you went to today)"),
                textField(context, "", placeController, Icons.location_on),
                Container(
                  alignment: Alignment.center,
                  padding: SystemTheme.fabRLMargin,
                ),
                Container(
                  height: 45,
                  margin: SystemTheme.fabRLMargin,
                  child: ElevatedButton(
                      onPressed: () {
                        submitTask(context);
                      },
                      child: submitWidget),
                ),
              ],
            ),
          ),
        ],
      ),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            title: Text(
              "Today's Project Details",
              //style: TextStyle(color: ThemeColors.colorPrimary),
            ),
            // backgroundColor: ThemeColors.lightBg,
            centerTitle: false,
            floating: true,
            snap: true,
            elevation: 2.0,
          )
        ];
      },
    ));
  }

  Future<void> submitTask(BuildContext context) async {
    if (taskController.value.text.trim() == "") {
      showActionSnackbar(context, "Project Should not be empty", "", () {});
      return;
    }

    if (placeController.value.text.trim() == "") {
      showActionSnackbar(context, "Place Name Should not be empty", "", () {});
      return;
    }

    if (descController.value.text.trim() == "") {
      showActionSnackbar(
          context, "Project Description Should not be empty", "", () {});

      return;
    }

    var status = await Permission.location.request();
    if (status.isDenied) {
      showActionSnackbar(
          context, "Please permit us with your location", "Retry", () {
        submitTask(context);
      });

      status = await Permission.location.request();
      return;
    }

    loadingDialog(context);

    var date = DateTime.now();
    var timeStamp = date.toString();

    var x = Random(3).nextDouble();
    var y = Random(3).nextDouble();

    Geolocator.isLocationServiceEnabled().then((bool enabled) {
      if (enabled) {
        var position = LocationManager.getLocation();
        position.then((Position pos) async {
          x = pos.latitude;
          y = pos.longitude;

          var data = {
            "add_task": "true",
            "time": timeStamp,
            "task_name": taskController.value.text,
            "task_desc": descController.value.text,
            "employee_id": Session.userId,
            "location_x": "$x",
            "location_y": "$y",
            "location_name": placeController.value.text,
          };

          Uri uri = Uri.http(systemHost, systemUrl, data);

          try {
            Response response = await http.get(uri);

            if (!response.body.isEmpty) {
              print(response.body);

              Map data = jsonDecode(response.body);
              Session.signedIn = true;
              showActionSnackbar(context, "Successfully Punched In", "", () {
                ;
              });

              Navigator.pop(context);
            }

            taskController.clear();
            descController.clear();
            placeController.clear();
            Navigator.pop(context);
          } catch (exception) {
            print(exception);
            Navigator.pop(context);
            showActionSnackbar(
                context, "Something went wrong", "Resubmit", submitTask);
          }
        });
      } else {
        setState(() {
          hasSubmitted = false;
        });
        Navigator.pop(context);
        showActionSnackbar(context, "Please enable your location", "Enable",
            () {
          Geolocator.openLocationSettings().then((bool enabled) {
            if (enabled) {
              showActionSnackbar(
                  context, "Thank You for enabling you loctaion", "", () {});
            }
          });
        });
      }
    });
  }
}
