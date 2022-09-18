import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:workers/values/colors.dart';
import 'package:workers/values/strings.dart';
import 'package:workers/widgets/widgets.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState<SearchPage> extends State {
  late List newsdata = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    var url = Uri.http(systemHost, systemUrl, {"news": "true"});
    try {
      var response = await http.get(url);

      setState(() {
        newsdata = jsonDecode(response.body);
      });
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        body: RefreshIndicator(
            child: Container(
              child: ListView.builder(
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
                    "${item['article_image']}",
                  );
                },
              ),
            ),
            onRefresh: () async {
              loadData();
            }),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          TextEditingController controller = new TextEditingController();
          controller.addListener(() async {
            String text = controller.text;
            // newsdata.forEach((element) {
            //   print(element);
            // });

            setState(() {
              newsdata.where((element) => false);

              // newsdata = newsdata.map((element) {
              //   print(element);
              //   return element;
              // }).toList();
            });
          });

          return [
            SliverAppBar(
              floating: true,
              snap: true,
              centerTitle: true,
              elevation: 1.0,
              title: CupertinoSearchTextField(
                controller: controller,
                borderRadius: BorderRadius.circular(8),
                backgroundColor: ThemeColors.systemColorLight,
                placeholder: "Type your search..",
              ),
            )
          ];
        },
      ),
    );
  }
}
