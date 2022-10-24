import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:workers/values/colors.dart';
import 'package:workers/widgets/widgets.dart';
import '../session/Session.dart';
import '../values/Theme.dart';
import 'package:http/http.dart' as http;

import '../values/strings.dart';

class Designations extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DesignationsState();
  }
}

class DesignationsState extends State<Designations> {
  late Widget designations;

  var deptsData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        body: RefreshIndicator(
            child: Container(
              width: double.maxFinite,
              child: designations,
            ),
            onRefresh: loadDesignations),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              centerTitle: true,
              floating: true,
              snap: true,
              title: Text("Select  your Disgnation"),
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
    designations = loadingWidget();
    loadDesignations();
  }

  Future<void> loadDesignations() async {
    setState(() {
      designations = loadingWidget();
    });
    var url = Uri.http(systemHost, systemUrl, {"des": "true"});
    try {
      var response = await http.get(url);

      setState(() {
        deptsData = jsonDecode(response.body);
        if (deptsData.length > 2) {
          setState(() {
            designations = ListView(
              children: deptsData.map((dept) {
                return Container(
                  margin: SystemTheme.fabBottomMargin,
                  child: ListTile(
                    tileColor: ThemeColors.systemColorLight,
                    iconColor: ThemeColors.colorPrimary,
                    leading: Icon(Icons.work),
                    title: Text(dept["designation_name"]),
                    subtitle: Text(dept["designation_desc"]),
                    onTap: () {
                      Session.des = {
                        "id": "${dept["designation_id"]}",
                        "name": dept["designation_name"]
                      };
                      Navigator.pop(context);
                    },
                  ),
                );
              }).toList(),
            );
          });
        } else {
          setState(() {
            designations = noDataWidget(text: "No Designations found!");
          });
        }
      });
    } catch (exception) {
      setState(() {
        designations = noDataWidget(text: "Something went wrong!");
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
