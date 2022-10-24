import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:workers/values/colors.dart';
import 'package:workers/widgets/widgets.dart';
import '../session/Session.dart';
import '../values/Theme.dart';
import 'package:http/http.dart' as http;

import '../values/strings.dart';

class Departments extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DepartmentsState();
  }
}

class DepartmentsState extends State<Departments> {
  late Widget departments;

  var deptsData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        body: RefreshIndicator(
            child: Container(
              width: double.maxFinite,
              child: departments,
            ),
            onRefresh: loadDepts),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              centerTitle: true,
              floating: true,
              snap: true,
              title: Text("Select  a Department"),
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
    departments = loadingWidget();
    loadDepts();
  }

  Future<void> loadDepts() async {
    setState(() {
      departments = loadingWidget();
    });
    var url = Uri.http(systemHost, systemUrl, {"depts": "true"});
    try {
      var response = await http.get(url);

      setState(() {
        deptsData = jsonDecode(response.body);
        if (deptsData.length > 0) {
          setState(() {
            departments = ListView(
              children: deptsData.map((dept) {
                return Container(
                  margin: SystemTheme.fabBottomMargin,
                  child: ListTile(
                    tileColor: ThemeColors.systemColorLight,
                    iconColor: ThemeColors.colorPrimary,
                    leading: Icon(Icons.work),
                    title: Text(dept["department_name"]),
                    subtitle: Text(dept["department_desc"]),
                    onTap: () {
                      Session.dept = {
                        "id": "${dept["department_id"]}",
                        "name": dept["department_name"]
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
            departments = noDataWidget(text: "No departments found!");
          });
        }
      });
    } catch (exception) {
      setState(() {
        departments = noDataWidget(text: "Something went wrong!");
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
