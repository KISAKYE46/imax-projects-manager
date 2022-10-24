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
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 120, maxHeight: 120),
              child: Image.asset(
                "assets/images/logo.png",
                height: 130,
                width: 130,
                fit: BoxFit.cover,
                scale: 2.0,
              ),
            ),
            Text(
              "i-MAX INNOVATION ",
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
