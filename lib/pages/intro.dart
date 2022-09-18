import 'package:flutter/material.dart';
import 'package:workers/values/Theme.dart';
import 'package:workers/values/colors.dart';

class IntroPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IntroPageState();
  }
}

class IntroPageState extends State<IntroPage> {
  String connectionText = "Checking Connection...";
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: ThemeColors.systemColorLight),
        padding: SystemTheme.fabBottomMargin,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Icon(
              Icons.newspaper,
              color: ThemeColors.colorPrimary,
              size: 40,
            ),
            Text(
              "N.E.W.S",
              style: TextStyle(
                  fontFamily: "Inherit",
                  fontSize: 17,
                  decoration: TextDecoration.none,
                  color: ThemeColors.colorPrimary),
            ),
            Text(
              connectionText,
              style: TextStyle(
                  fontFamily: "Inherit",
                  fontSize: 17,
                  decoration: TextDecoration.none,
                  color: ThemeColors.systemColorLight),
            )
          ],
        ));
  }
}
