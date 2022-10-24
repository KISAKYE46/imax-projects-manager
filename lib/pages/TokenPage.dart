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
import 'NewPassPage.dart';

class TokenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TokenPageState();
  }
}

class _TokenPageState<TokenPage> extends State {
  TextEditingController phoneController = new TextEditingController();
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
                "Check your SMS inbox for the Token",
                style: TextStyle(color: ThemeColors.systemColorOnLight),
                textAlign: TextAlign.center,
              ),
              margin: SystemTheme.fabRLBMargin,
            ),

            Container(
              padding: SystemTheme.fabBottomMargin,
            ),
            textField(
                context, "Enter your token", phoneController, Icons.token),
            Container(
              margin: SystemTheme.fabRLMargin,
              child: ElevatedButton(
                  onPressed: submit, child: Text("Confirm Token")),
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
    if (phoneController.text.trim() == "") {
      showActionSnackbar(context, "Token Field is Empty", "", () {});
      return;
    }

    Uri uri = Uri.http(systemHost, systemUrl, {
      "confirm_token": "true",
      "contact": "${Session.contact}",
      "token": phoneController.text,
    });

    loadingDialog(context);

    try {
      http.Response response = await http.get(uri);

      if (!response.body.isEmpty) {
        Map data = jsonDecode(response.body);

        String message = data["message"];

        if (message == "right_token") {
          // Session.contact = data["data"]["contact"];
          // Session.email = data["data"]["email"];
          // Session.name = data["data"]["name"];
          // Session.lastAction = data["data"]["last_login"];
          // Session.today = data["data"]["today"];

          phoneController.clear();
          password2Controller.clear();

          Navigator.pop(context);

          routePermanentlyTo(context, NewPassPage());
        } else if (message == "wrong_token") {
          Navigator.pop(context);
          showActionSnackbar(context, "Wrong Token!!", "", () {});
        } else {
          Navigator.pop(context);
          showActionSnackbar(context, "An error occurred!!", "", () {});
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
