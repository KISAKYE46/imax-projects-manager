import 'package:flutter/material.dart';

import '../values/Theme.dart';
import '../values/colors.dart';
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
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              elevation: 0,
              // backgroundColor: ThemeColors.systemColorLight,
              title: Text(
                "My Profile",
                //  style: TextStyle(color: ThemeColors.colorPrimary),
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
              ListTile(
                leading: Icon(
                  Icons.email,
                  color: ThemeColors.colorPrimary,
                ),
                tileColor: ThemeColors.systemColorLight,
                title: Text("Email"),
                subtitle: Text(Session.email),
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
                tileColor: ThemeColors.systemColorLight,
                title: Text("Job Position"),
                subtitle: Text("Distributor"),
              ),
              Container(
                height: 5,
              ),
              ListTile(
                leading: Icon(
                  Icons.task,
                  color: ThemeColors.colorPrimary,
                ),
                tileColor: ThemeColors.systemColorLight,
                title: Text("Tasks"),
                subtitle: Text("78"),
              ),
              Container(
                height: 5,
              ),
              ListTile(
                leading: Icon(Icons.handshake, color: ThemeColors.colorPrimary),
                tileColor: ThemeColors.systemColorLight,
                title: Text("Punch ins"),
                subtitle: Text("67"),
              ),
              Container(
                height: 5,
              ),
              ListTile(
                leading: Icon(
                  Icons.location_history,
                  color: ThemeColors.colorPrimary,
                ),
                tileColor: ThemeColors.systemColorLight,
                title: Text("Locations"),
                subtitle: Text("67"),
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
              )
            ],
          ),
        ));
  }
}
