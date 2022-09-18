import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:workers/pages/LogginPage.dart';
import 'package:workers/router/page_router.dart';
import 'package:workers/values/Theme.dart';
import 'package:workers/values/colors.dart';
import 'package:workers/values/strings.dart';
import 'package:workers/widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState<RegisterPage> extends State {
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
      body: Container(
        padding: SystemTheme.fabMargin,
        child: ListView(
          children: [
            Container(
              padding: SystemTheme.fabBottomMargin,
              child: Text(
                ".N.E.W.S.",
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: SystemTheme.fabBottomMargin,
              child: Text(
                "Sign Up",
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
            ),
            textField(context, "Full Name", null, Icons.person),
            textField(context, "Phone", null, Icons.phone),
            textField(context, "Email", null, Icons.email),
            textField(context, "Password", null, Icons.lock),
            textField(context, "Comfirm Password", null, Icons.lock),
            Container(
              alignment: Alignment.center,
              padding: SystemTheme.fabRLMargin,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Sign In"))
                ],
              ),
            ),
            Container(
              height: 45,
              margin: SystemTheme.fabRLMargin,
              child: ElevatedButton(onPressed: () {}, child: Text("Sign Up")),
            ),
            termsAndConditions(context)
          ],
        ),
      ),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            backgroundColor: ThemeColors.lightBg,
            centerTitle: true,
            floating: true,
            snap: true,
            iconTheme: IconThemeData(color: ThemeColors.colorPrimary),
            elevation: 1.0,
          )
        ];
      },
    ));
  }
}
