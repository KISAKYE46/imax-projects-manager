import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../session/Session.dart';
import '../values/strings.dart';
import '../widgets/widgets.dart';

class TaskDetails extends StatefulWidget {
  var task = {};

  TaskDetails(Map task) {
    this.task = task;
  }

  @override
  State<StatefulWidget> createState() {
    return TaskDetailsState(this.task);
  }
}

class TaskDetailsState extends State<TaskDetails> {
  var task = {};

  TaskDetailsState(Map task) {
    this.task = task;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        body: RefreshIndicator(
            child: Container(
                child: ListView(
              children: [
                taskHeadingCard(context, this.task["task_name"],
                    startDate: task["login_time"],
                    endDate: task["logout_time"],
                    location: task["location_name"],
                    body: task["task_desc"]),
              ],
            )),
            onRefresh: () async {
              //loadHistory(context);
            }),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              snap: true,
              title: Text("Project  Details"),
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
  }

  @override
  void dispose() {
    super.dispose();
  }
}
