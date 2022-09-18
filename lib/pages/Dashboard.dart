import 'package:flutter/material.dart';

import '../values/Theme.dart';
import '../values/colors.dart';
import '../widgets/widgets.dart';
import 'AddPage.dart';
import 'History.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashboardState();
  }
}

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              elevation: 0,
              // backgroundColor: ThemeColors.systemColorLight,
              title: Text(
                "Hello! Greetings",
                // style: TextStyle(color: ThemeColors.colorPrimary),
              ),
              actions: [
                navActions(context, Icons.check, null),
                // navBadge(context, Icons.notifications, "9"),
              ],
              floating: true,
              pinned: false,
              snap: true,
            )
          ];
        },
        body: ListView(
          children: [
            Container(
              padding: SystemTheme.fabMargin,
              child: Text(
                "Today is wednesday",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Container(
              padding: SystemTheme.fabMargin,
              child: Text(
                "Make sure you  register your tasks for today.",
                style: TextStyle(color: ThemeColors.colorPrimary),
              ),
            ),
            Container(
              padding: SystemTheme.fabMargin,
              child: Text(
                "Actions",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 150),
                child: GridView(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1.2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12),
                  children: [
                    dashBoardCard(context, "Punch In", Icons.handshake,
                        page: AddPage()),
                    dashBoardCard(context, "Location", Icons.location_history),
                    dashBoardCard(context, "History", Icons.history,
                        page: History()),
                  ],
                )),
            Container(
              padding: SystemTheme.fabMargin,
              child: Text(
                "Previous Actions",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: SystemTheme.fabMargin,
              child: Column(
                children: [
                  Text(
                    "Today You Signed in at 2:00 pm",
                    style: TextStyle(
                        color: ThemeColors.colorPrimary,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
