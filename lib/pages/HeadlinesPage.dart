import 'dart:convert';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:http/retry.dart';
import 'package:workers/values/strings.dart';
import 'package:workers/widgets/widgets.dart';

import '../network/Network.dart';

class HeadlinesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HeadlinesPageState();
  }
}

class _HeadlinesPageState<HeadlinesPage> extends State {
  late List newsdata = [];
  Widget statusWidget = loadingWidget();

  @override
  void initState() {
    super.initState();

    if (newsdata.length > 0) {
      newsdata = [];
    }
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      if (mounted) {
        statusWidget = loadingWidget();
      }
    });

    try {
      if (mounted) {
        setState(() => newsdata = []);
      }

      var response = await client.get(url).timeout(Duration(seconds: 10));

      print(systemUrl);

      if (mounted) {
        setState(() => newsdata = []);
      }

      setState(() {
        newsdata = jsonDecode(response.body);
        statusWidget = noWidget();
      });
    } catch (exception) {
      setState(() {
        statusWidget = errorWidget("You are offline..", null);
      });
      showPersistentActionSnackbar(
          context, "${exception.toString()}", "Retry", loadData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: Container(
            child: Stack(
          children: [
            ListView.builder(
              itemCount: newsdata.length,
              itemBuilder: (BuildContext context, index) {
                var item = newsdata[index];
                return headline(
                    context,
                    "${item['article_title']}",
                    "${item['article_subtitle']}",
                    "${item['category_id']}",
                    "FASHION",
                    "${item['created_at']}",
                    "${item['article_body']}",
                    "${item['article_image']}",
                    "");
              },
            ),
            Container(
              width: double.maxFinite,
              child: statusWidget,
            )
          ],
        )),
        onRefresh: () async {
          loadData();
        });
  }
}
