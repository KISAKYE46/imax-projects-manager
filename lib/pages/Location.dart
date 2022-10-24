import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:workers/values/colors.dart';
import '../session/Session.dart';
import '../values/Theme.dart';
import '../values/strings.dart';
import '../widgets/widgets.dart';

class Location extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LocationState();
  }
}

class LocationState extends State<Location> {
  var location = [];

  Widget currentDisplay = loadingWidget();

  var itemCount = 0;
  var loading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        body: RefreshIndicator(
            child: Container(
                alignment: Alignment.center,
                padding: SystemTheme.fabRLMargin,
                child: currentDisplay),
            onRefresh: () async {
              loadLocation(context);
            }),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              snap: true,
              title: Text("Places History"),
              // actions: [navActions(context, Icons.share, null)],
            )
          ];
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    location = [];
    itemCount = location.length;
    currentDisplay = loadingWidget();

    loadLocation(context);
  }

  void loadLocation(BuildContext context) async {
    setState(() {
      currentDisplay = loadingWidget();
    });
    try {
      var data = {"history": "", "employee_id": Session.userId, "Location": ""};

      Uri uri = Uri.http(systemHost, systemUrl, data);

      Response response = await http.get(uri);

      print(response.body);

      if (!response.body.isEmpty) {
        setState(() {
          location = jsonDecode(response.body);
          itemCount = location.length;

          if (itemCount > 0) {
            setState(() {
              currentDisplay = GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 0.8),
                itemCount: itemCount,
                itemBuilder: (BuildContext context, int index) {
                  return locationCard(context, location[index]["location_name"],
                      startDate: location[index]["login_time"],
                      endDate: location[index]["logout_time"],
                      task: location[index]);
                },
              );
            });
          } else {
            currentDisplay = noDataWidget();
            showPersistentSnackbar(context, "No places found.",
                color: ThemeColors.colorWarning);
          }
        });

        print(location);
      }
    } catch (exception) {
      Navigator.pop(context);
      showActionSnackbar(context, "Something went wrong", "", () {});
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
