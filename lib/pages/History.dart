import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../session/Session.dart';
import '../values/strings.dart';
import '../widgets/widgets.dart';

class History extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HistoryState();
  }
}

class HistoryState extends State<History> {
  var history = [];
  Widget currentDisplay = loadingWidget();

  var itemCount = 0;
  var hasItems = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        body: RefreshIndicator(
            child: Container(
              width: double.maxFinite,
              child: Stack(
                children: [
                  Container(
                    child: currentDisplay,
                    alignment: Alignment.center,
                  )
                ],
              ),
            ),
            onRefresh: () async {
              loadHistory(context);
            }),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              snap: true,
              title: Text("Projects' History"),
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
    history = [];
    itemCount = history.length;
    currentDisplay = loadingWidget();
    loadHistory(context);
  }

  void loadHistory(BuildContext context) async {
    try {
      var data = {"employee_id": Session.userId, "history": ""};

      Uri uri = Uri.http(systemHost, systemUrl, data);

      Response response = await http.get(uri);

      if (!response.body.isEmpty) {
        setState(() {
          history = jsonDecode(response.body);
          itemCount = history.length;

          if (itemCount > 0) {
            setState(() {
              currentDisplay = ListView.builder(
                itemCount: itemCount,
                itemBuilder: (BuildContext context, int index) {
                  return historyCard(context, history[index]["task_name"],
                      startDate: history[index]["login_time"],
                      endDate: history[index]["logout_time"],
                      task: history[index]);
                },
              );
            });
            hasItems = true;
          } else {
            hasItems = false;
            currentDisplay = noDataWidget();
          }
        });

        // print(history);
      }
    } catch (exception) {
      print(exception);

      setState(() {
        currentDisplay = noDataWidget();
      });
      showActionSnackbar(context, "Something went wrong", "Retry", () {
        loadHistory(context);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
