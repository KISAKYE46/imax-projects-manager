import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workers/values/colors.dart';

import '../values/Theme.dart';
import '../widgets/widgets.dart';

class History extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HistoryState();
  }
}

class HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        body: Container(
          child: ListView(
            children: [
              historyCard(context, "Yesterday You were in Mbale"),
              historyCard(context, "On 20/03/2022 You were in Mbale"),
              historyCard(context, "On 20/03/2022 You were in Mbale"),
              historyCard(context, "On 20/03/2022 You were in Mbale"),
              historyCard(context, "On 20/03/2022 You were in Mbale"),
              historyCard(context, "On 20/03/2022 You were in Mbale"),
              historyCard(context, "On 20/03/2022 You were in Mbale"),
            ],
          ),
        ),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              snap: true,
              title: Text("Tasks' History"),
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
