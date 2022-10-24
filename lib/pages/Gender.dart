import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workers/pages/RegisterPage.dart';
import 'package:workers/values/colors.dart';

import '../session/Session.dart';
import '../values/Theme.dart';
import '../widgets/widgets.dart';

class Gender extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GenderState();
  }
}

class GenderState extends State<Gender> {
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
                    tileColor: ThemeColors.systemColorLight,
                    iconColor: ThemeColors.colorPrimary,
                    leading: Icon(Icons.man),
                    title: Text("Male"),
                    subtitle: Text("Select if you are male"),
                    onTap: () {
                      Session.gender = {"gender": "male", "name": "Male"};
                      Navigator.pop(context);
                    }),
              ),
              Container(
                margin: SystemTheme.fabBottomMargin,
                child: ListTile(
                  tileColor: ThemeColors.systemColorLight,
                  iconColor: ThemeColors.colorPrimary,
                  leading: Icon(Icons.woman),
                  title: Text("Female"),
                  subtitle: Text("Select if you are female."),
                  onTap: () {
                    Session.gender = {"gender": "female", "name": "Female"};
                    Navigator.pop(context);
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
              title: Text("Select  your gender"),
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
