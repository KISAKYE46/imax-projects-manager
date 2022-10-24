import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:workers/router/page_router.dart';
import 'package:workers/session/Session.dart';

import '../location/LocationManager.dart';
import '../values/Theme.dart';
import '../values/colors.dart';
import '../values/dimen.dart';
import '../values/strings.dart';
import '../widgets/widgets.dart';
import 'AddPage.dart';
import 'History.dart';
import 'Location.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashboardState();
  }
}

class DashboardState extends State<Dashboard> {
  bool punchedIn = false;

  bool completed = false;

  late bool locationGranted;
  bool isLocationEnabled = false;

  @override
  void initState() {
    super.initState();

    punchedIn = Session.signedIn;
    completed = Session.completed;
    isLocationEnabled = false;

    Geolocator.isLocationServiceEnabled().then((bool enabled) {
      if (enabled) {
        setState(() {
          isLocationEnabled = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              elevation: appBarElevation,
              // backgroundColor: ThemeColors.systemColorLight,
              title: Text(
                "Hello ${Session.name.split(" ")[0]}!",
                // style: TextStyle(color: ThemeColors.colorPrimary),
              ),
              actions: [
                navMessage(
                    context,
                    !punchedIn && !completed
                        ? Icons.info_outline
                        : completed
                            ? Icons.done_all
                            : Icons.check, () {
                  if (punchedIn) {
                    showActionSnackbar(
                        context, "You Have already punched In", "", () {});
                  } else {
                    showActionSnackbar(
                        context, "You Have not punched In yet", "Punch In", () {
                      routeTo(context, AddPage());
                    });
                  }
                }),
                // navBadge(context, Icons.notifications, "9"),
              ],
              floating: true,
              pinned: false,
              snap: true,
            )
          ];
        },
        body: ListView(
          children: [
            Container(
              padding: SystemTheme.fabMargin,
              child: Text(
                !punchedIn && !completed
                    ? "Start your ${Session.today}!"
                    : completed
                        ? "Hope ${Session.today} was Good!"
                        : "Nice ${Session.today}!",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Container(
                padding: SystemTheme.fabMargin,
                child: punchedIn && !completed
                    ? Text(
                        "You have already registered your tasks for today.",
                        style: TextStyle(color: ThemeColors.colorWarning),
                      )
                    : !completed
                        ? Text(
                            "Make sure you  register your tasks for today.",
                            style: TextStyle(color: ThemeColors.colorDanger),
                          )
                        : Text(
                            "All tasks are completed today.",
                            style: TextStyle(color: ThemeColors.colorSuccess),
                          )),
            Container(
              padding: SystemTheme.fabMargin,
              child: Text(
                "Actions",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 150),
                child: GridView(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1.2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12),
                  children: [
                    !punchedIn && !completed
                        ? dashBoardCard(context, "Punch In", Icons.handshake,
                            action: () {
                            routeWithAction(context, AddPage(), () {
                              setState(() {
                                punchedIn = Session.signedIn;
                              });
                            });
                          })
                        : !completed
                            ? dashBoardCard(context, "Punch Out", Icons.logout,
                                action: () {
                                showActionSnackbar(
                                    context,
                                    "Are you sure to Punch out?",
                                    "Punch Out",
                                    punchOut);
                              }, color: ThemeColors.buttonColor)
                            : dashBoardCard(
                                context, "Day Completed", Icons.done_all,
                                action: () {
                                showActionSnackbar(
                                    context,
                                    "All tasks are completed today!",
                                    "",
                                    () {});
                              }, color: ThemeColors.buttonColor),
                    dashBoardCard(
                        context, "Previous Places", Icons.location_history,
                        page: Location()),
                    dashBoardCard(context, "Previous Projects", Icons.history,
                        page: History()),
                  ],
                )),
            Container(
              padding: SystemTheme.fabMargin,
              child: Text(
                "Previous Actions",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: SystemTheme.fabMargin,
              child: Column(
                children: [
                  Text(
                    "Last login was on ${Session.lastAction}",
                    style: TextStyle(
                        color: ThemeColors.colorPrimary,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: SystemTheme.fabMargin,
              child: Column(
                children: [
                  Text(
                    !isLocationEnabled
                        ? "Please make sure that your location is enabled."
                        : "",
                    style: TextStyle(
                        color: ThemeColors.colorWarning,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  void punchOut() {
    var x = Random(3).nextDouble();
    var y = Random(3).nextDouble();

    var date = DateTime.now();
    var timeStamp = date.toString();

    Geolocator.isLocationServiceEnabled().then((bool enabled) {
      if (enabled) {
        loadingDialog(context);
        var position = LocationManager.getLocation();
        position.then((Position pos) async {
          x = pos.latitude;
          y = pos.longitude;

          var data = {
            "punch_out": "true",
            "time": timeStamp,
            "employee_id": Session.userId,
            "location_x": "$x",
            "location_y": "$y",
          };

          Uri uri = Uri.http(systemHost, systemUrl, data);

          try {
            Response response = await http.get(uri);

            if (!response.body.isEmpty) {
              Map data = jsonDecode(response.body);

              Session.signedIn = false;

              setState(() {
                punchedIn = false;
                completed = true;
                Session.completed = true;
              });
              showActionSnackbar(
                  context, "Successfully Punched Out", "", () {});
            }
          } catch (exception) {
            print(exception);
            showActionSnackbar(context, "Something went wrong", "", () {});
          }

          Navigator.pop(context);
        });
      } else {
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
