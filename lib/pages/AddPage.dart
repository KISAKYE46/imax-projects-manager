import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:workers/pages/LogginPage.dart';
import 'package:workers/router/page_router.dart';
import 'package:workers/values/Theme.dart';
import 'package:workers/values/colors.dart';
import 'package:workers/values/strings.dart';
import 'package:workers/widgets/widgets.dart';

class AddPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddPageState();
  }
}

class _AddPageState<AddPage> extends State {
  late List newsdata = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    var url = Uri.http(systemHost, systemUrl, {"news": "true"});
    try {
      //  var response = await http.get(url);

      // setState(() {
      //   newsdata = jsonDecode(response.body);
      // });
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      body: Container(
        padding: SystemTheme.fabMargin,
        child: ListView(
          children: [
            labelText(context, "Task of the Day"),
            textField(context, "", null, Icons.task),
            labelText(context, "Task Desciption ie (What will be done  today)"),
            largeTextField(context, "", null, Icons.details, size: 200.0),
            labelText(context, "Task Location ie (Where you went to today)"),
            textField(context, "", null, Icons.location_on),
            labelText(context, "Start Time ie (When you started working)"),
            textField(context, "", null, Icons.timer),
            labelText(context, "End Time ie (When you expect to finish)"),
            textField(context, "", null, Icons.timer_off_outlined),
            Container(
              alignment: Alignment.center,
              padding: SystemTheme.fabRLMargin,
            ),
            Container(
              height: 45,
              margin: SystemTheme.fabRLMargin,
              child: ElevatedButton(
                  onPressed: () {}, child: Text("+ Save Details")),
            ),
          ],
        ),
      ),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            title: Text(
              "Add Task Details here..",
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
}
