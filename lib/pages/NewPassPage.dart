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
import '../session/Session.dart';
import 'HomePage.dart';

class NewPassPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewPassPageState();
  }
}

class _NewPassPageState<NewPassPage> extends State {
  TextEditingController password1Controller = new TextEditingController();
  TextEditingController password2Controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      body: Container(
        color: ThemeColors.systemColorLight,
        padding: SystemTheme.fabMargin,
        child: ListView(
          children: [
            companyLogo(context),
            Container(
              padding: SystemTheme.fabBottomMargin,
            ),
            Container(
              child: Text(
                "Create your New Password",
                style: TextStyle(color: ThemeColors.systemColorOnLight),
                textAlign: TextAlign.center,
              ),
              margin: SystemTheme.fabRLBMargin,
            ),

            Container(
              padding: SystemTheme.fabBottomMargin,
            ),
            passwordTextField(
                context, "New Password", password1Controller, Icons.lock),

            Container(
              padding: SystemTheme.fabBottomMargin,
            ),
            passwordTextField(
                context, "Confirm Password", password2Controller, Icons.lock),

            Container(
              margin: SystemTheme.fabRLMargin,
              child: ElevatedButton(
                  onPressed: submit, child: Text("Reset Password")),
            ),
            // termsAndConditions(context)
          ],
        ),
      ),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            backgroundColor: ThemeColors.systemColorLight,
            centerTitle: true,
            floating: true,
            snap: true,
            iconTheme: IconThemeData(color: ThemeColors.colorPrimary),
            elevation: 0,
          )
        ];
      },
    ));
  }

  void submit() async {
    if (password1Controller.text.trim() == "") {
      showActionSnackbar(context, "Password field is empty", "", () {});
      return;
    }

    if (password2Controller.text.trim() == "") {
      showActionSnackbar(context, "Confirm your password", "", () {});
      return;
    }

    if (password2Controller.text != password1Controller.text) {
      showActionSnackbar(context, "Passwords must be equal", "", () {});
      return;
    }

    Uri uri = Uri.http(systemHost, systemUrl, {
      "new_pass": "true",
      "contact": "${Session.contact}",
      "pass": password1Controller.text,
    });

    loadingDialog(context);

    try {
      http.Response response = await http.get(uri);

      if (!response.body.isEmpty) {
        Map data = jsonDecode(response.body);

        String message = data["message"];

        if (message == "success") {
          // Session.contact = data["data"]["contact"];
          // Session.email = data["data"]["email"];
          // Session.name = data["data"]["name"];
          // Session.lastAction = data["data"]["last_login"];
          // Session.today = data["data"]["today"];

          password1Controller.clear();
          password2Controller.clear();

          Navigator.pop(context);

          showActionSnackbar(
              context, "Password Successfully Reset", "Login Now", () {
            routePermanentlyTo(context, LogginPage());
          });
        } else {
          Navigator.pop(context);
          showActionSnackbar(context, "Password Reset Failed", "", () {});
        }
      } else {
        Navigator.pop(context);
        showActionSnackbar(
            context, "Something went wrong!!", "Try Again", submit);
      }
    } catch (exception) {
      Navigator.pop(context);
      showActionSnackbar(context, "Connection Error", "Try Again", submit);
      print(exception);
    }
  }
}
