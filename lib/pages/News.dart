import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:workers/widgets/widgets.dart';
import '../network/Network.dart';
import '../values/strings.dart';

class NewsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewsPageState();
  }
}

class _NewsPageState<NewsPage> extends State {
  late List newsdata = [];

  Widget statusWidget = loadingWidget();

  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void reloadData() async {
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      if (mounted) {
        statusWidget = loadingWidget();
      }
    });
    try {
      var response = await client.get(url).timeout(Duration(seconds: 10));

      if (mounted) {
        setState(() => newsdata = []);
      }

      if (response.body.length > 0) {
        setState(() {
          newsdata = jsonDecode(response.body);
          statusWidget = noWidget();
        });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return dialog(context, "Error", "Fetching Error",
                  Icons.network_check_rounded, null);
            });
      }
    } catch (exception) {
      setState(() {
        statusWidget = errorWidget("You are offline..", null);
      });
      showPersistentActionSnackbar(
          context, "${exception.toString()}", "Retry", reloadData);
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
                return newSection(
                    context,
                    "${item['article_title']}",
                    "${item['article_subtitle']}",
                    "${item['category_id']}",
                    "FASHION",
                    "${item['created_at']}",
                    "${item['article_image']}",
                    "${item['article_body']}",
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
