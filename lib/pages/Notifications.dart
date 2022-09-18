import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workers/values/colors.dart';

import '../values/Theme.dart';
import '../widgets/widgets.dart';

class Notifications extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NotificationsState();
  }
}

class NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        body: Container(
          child: ListView(
            children: [
              Container(
                margin: SystemTheme.fabBottomMargin,
                child: ListTile(
                  isThreeLine: true,
                  tileColor: ThemeColors.systemColorLight,
                  iconColor: ThemeColors.colorPrimary,
                  leading: Icon(Icons.notifications),
                  title: Text("Eddy Replied to your comment.."),
                  subtitle: Text("You are right man..."),
                  trailing: Icon(Icons.close),
                ),
              ),
              Container(
                margin: SystemTheme.fabBottomMargin,
                child: ListTile(
                  isThreeLine: true,
                  tileColor: ThemeColors.systemColorLight,
                  iconColor: ThemeColors.colorPrimary,
                  leading: Icon(Icons.newspaper),
                  title: Text("James Mayer added a new article."),
                  subtitle: Text("Read more.."),
                  trailing: Icon(Icons.close),
                ),
              ),
              Container(
                margin: SystemTheme.fabBottomMargin,
                child: ListTile(
                  isThreeLine: true,
                  tileColor: ThemeColors.systemColorLight,
                  iconColor: ThemeColors.colorPrimary,
                  leading: Icon(Icons.settings),
                  title: Text("A new update is available"),
                  subtitle: Text("Take Action"),
                  trailing: Icon(Icons.close),
                  onTap: () {
                    showTextSnackbar(context, "Clicked on item");
                  },
                ),
              ),
              Container(
                margin: SystemTheme.fabBottomMargin,
                child: ListTile(
                  isThreeLine: true,
                  tileColor: ThemeColors.systemColorLight,
                  iconColor: ThemeColors.colorPrimary,
                  leading: Icon(Icons.newspaper),
                  title: Text("James Mayer added a new article."),
                  subtitle: Text("Read more.."),
                  trailing: Icon(Icons.close),
                  onTap: () {
                    showActionSnackbar(context, "You are about to do something",
                        "Continue", () {});
                  },
                ),
              ),
            ],
          ),
        ),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              centerTitle: true,
              floating: true,
              snap: true,
              title: Text("Notifications"),
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
