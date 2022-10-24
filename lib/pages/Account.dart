import 'package:flutter/material.dart';
import 'package:workers/pages/LogginPage.dart';
import 'package:workers/router/page_router.dart';

import '../values/Theme.dart';
import '../values/colors.dart';
import '../values/dimen.dart';
import '../widgets/widgets.dart';
import '../session/Session.dart';
import 'AddPage.dart';
import 'History.dart';

class Account extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AccountState();
  }
}

class AccountState extends State<Account> {
  bool punchedIn = false;

  @override
  void initState() {
    super.initState();
    punchedIn = Session.signedIn;
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              elevation: appBarElevation,
              // backgroundColor: ThemeColors.systemColorLight,
              title: Text(
                "My Account",
                //  style: TextStyle(color: ThemeColors.colorPrimary),
              ),
              actions: [
                navActions(context,
                    punchedIn == true ? Icons.check : Icons.info_outline, null),
                // navBadge(context, Icons.notifications, "9"),
              ],
              floating: true,
              pinned: false,
              snap: true,
            )
          ];
        },
        body: Container(
          child: ListView(
            children: [
              Container(
                padding: SystemTheme.fabMargin,
                child: Text(
                  "Personal Details",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: ThemeColors.colorPrimary,
                ),
                tileColor: ThemeColors.systemColorLight,
                title: Text("Full Name"),
                subtitle: Text(Session.name),
              ),
              Container(
                height: 2,
              ),
              ListTile(
                leading: Icon(
                  Icons.phone,
                  color: ThemeColors.colorPrimary,
                ),
                tileColor: ThemeColors.systemColorLight,
                title: Text("Contact"),
                subtitle: Text(Session.contact),
              ),
              Container(
                height: 5,
              ),
              Container(
                padding: SystemTheme.fabMargin,
                child: Text(
                  "Other Details",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.work_history,
                  color: ThemeColors.colorPrimary,
                ),
                tileColor: Color.fromRGBO(255, 255, 255, 1),
                title: Text("Department"),
                subtitle: Text(Session.deptName),
              ),
              Container(
                height: 5,
              ),
              ListTile(
                leading: Icon(
                  Icons.work_history,
                  color: ThemeColors.colorPrimary,
                ),
                tileColor: ThemeColors.systemColorLight,
                title: Text("Job Position"),
                subtitle: Text(Session.desName),
              ),
              Container(
                height: 5,
              ),
              Container(
                padding: SystemTheme.fabMargin,
                child: Text(
                  "Previous Actions",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              Container(
                height: 60,
                color: ThemeColors.systemColorLight,
                alignment: Alignment.centerLeft,
                padding: SystemTheme.fabMargin,
                child: Column(
                  children: [
                    Text(
                      Session.lastAction,
                      style: TextStyle(
                          color: ThemeColors.colorPrimary,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                margin: SystemTheme.fabRLTMargin,
                child: ElevatedButton(
                    onPressed: () {
                      routePermanentlyTo(context, LogginPage());
                    },
                    child: Text("Sign out")),
              )
            ],
          ),
        ));
  }
}
