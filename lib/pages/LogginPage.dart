import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import "package:http/http.dart" as http;
import 'package:workers/pages/IndexPage.dart';
import 'package:workers/pages/RegisterPage.dart';
import 'package:workers/router/page_router.dart';
import 'package:workers/session/Session.dart';
import 'package:workers/values/Theme.dart';
import 'package:workers/values/colors.dart';
import 'package:workers/values/strings.dart';
import 'package:workers/widgets/widgets.dart';

class LogginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LogginPageState();
  }
}

class _LogginPageState<LogginPage> extends State {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    // emailController.addListener(() {
    //   RegExp regex = new RegExp("[a-z0-9@]{1,}");
    //   regex.hasMatch("nkanjijoel@gmail.com");
    // });
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
                "Sign In",
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
            ),
            textField(context, "Email or Phone", emailController, null),
            passwordTextField(
                context, "Password", passwordController, Icons.lock),
            Container(
              alignment: Alignment.center,
              padding: SystemTheme.fabRLMargin,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                      onPressed: () {
                        routeTo(context, RegisterPage());
                      },
                      child: Text("Sign Up")),
                ],
              ),
            ),
            Container(
              height: 45,
              margin: SystemTheme.fabRLMargin,
              child: ElevatedButton(
                  onPressed: () async {
                    Uri uri = Uri.http(systemHost, systemUrl, {
                      "loggin": "true",
                      "email": emailController.text,
                      "password": passwordController.text
                    });

                    try {
                      Response response = await http.get(uri);

                      if (!response.body.isEmpty) {
                        List<dynamic> data = jsonDecode(response.body);

                        emailController.clear();
                        passwordController.clear();
                        routePermanentlyTo(context, IndexPage());
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return dialog(context, "Failure",
                                  "Loggin attempt failed", null, null);
                            });
                      }
                    } catch (exception) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return dialog(context, "Connection Error",
                                "No Connection", null, resubmit);
                          });
                    }
                  },
                  child: Text("Sign In")),
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

  void resubmit() async {
    Uri uri = Uri.http(systemHost, systemUrl, {
      "loggin": "true",
      "email": emailController.text,
      "password": passwordController.text
    });
    try {
      Response response = await http.get(uri);

      if (!response.body.isEmpty) {
        List<dynamic> data = jsonDecode(response.body);

        emailController.clear();
        passwordController.clear();
        routePermanentlyTo(context, IndexPage());
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return dialog(
                  context, "Failure", "Loggin attempt failed", null, null);
            });
      }
    } catch (exception) {
      showDialog(
          context: context,
          builder: (context) {
            return dialog(
                context, "Connection Error", "No Connection", null, resubmit);
          });
    }
  }
}
