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

import 'HomePage.dart';
import 'ResetPage.dart';

class LogginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LogginPageState();
  }
}

class _LogginPageState<LogginPage> extends State {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool isSubmitting = false;

  Widget buttonWidget = Text("Sign In");
  @override
  void initState() {
    super.initState();
    buttonWidget = Text("Sign In");
    isSubmitting = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeColors.systemColorLight,
        body: NestedScrollView(
          body: ListView(
            shrinkWrap: true,
            children: [
              Container(
                // height: MediaQuery.of(context).size.height,
                padding: SystemTheme.fabTopMargin,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  color: ThemeColors.systemColorLight,
                  padding: SystemTheme.fabMargin,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      companyLogo(context),
                      Container(
                        padding: SystemTheme.fabBottomMargin,
                      ),
                      Container(
                        padding: SystemTheme.fabBottomMargin,
                      ),
                      Container(
                        child: Column(
                          children: [
                            formTitle(
                                context, "Sign in to Access your Account"),
                            Container(
                              padding: SystemTheme.fabBottomMargin,
                            ),
                            phoneField(context, "Enter your Phone Number..",
                                emailController, Icons.phone),
                            passwordTextField(context, "Enter your Password..",
                                passwordController, Icons.lock),
                            Container(
                              alignment: Alignment.center,
                              padding: SystemTheme.fabRLMargin,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        routeTo(context, ResetPage());
                                      },
                                      child: Text("Forgot Password?")),
                                ],
                              ),
                            ),
                            Container(
                              width: double.maxFinite,
                              margin: SystemTheme.fabRLMargin,
                              child: ElevatedButton(
                                  onPressed: () {
                                    submit(context);
                                  },
                                  child: buttonWidget),
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: SystemTheme.fabRLMargin,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Dont have an account?"),
                                  TextButton(
                                      onPressed: () {
                                        routeTo(context, RegisterPage());
                                      },
                                      child: Text("Sign Up")),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )

                      //termsAndConditions(context)
                    ],
                  ),
                ),
              )
            ],
          ),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [];
          },
        ));
  }

  void submit(BuildContext context) async {
    if (passwordController.text.trim() == "") {
      showActionSnackbar(context, "Password Field is Empty", "", () {});
      return;
    }

    if (emailController.text.trim() == "") {
      showActionSnackbar(context, "Phone Field is Empty", "", () {});
      return;
    }
    loadingDialog(context);

    Uri uri = Uri.http(systemHost, systemUrl, {
      "login": "true",
      "phone": emailController.text,
      "password": passwordController.text
    });

    try {
      Response response = await http.get(uri);

      if (!response.body.isEmpty) {
        Map data = jsonDecode(response.body);

        String message = data["message"];

        if (message == "success") {
          Session.userId = "${data["data"]["id"]}";
          Session.contact = data["data"]["contact"];
          Session.email = data["data"]["email"];
          Session.name = data["data"]["name"];
          Session.lastAction = data["data"]["last_login"];
          Session.today = data["data"]["today"];
          Session.deptName = data["data"]["department_name"];
          Session.desName = data["data"]["designation_name"];

          if (data["data"]["has_punched_in"] == true) {
            Session.signedIn = true;
          } else {
            Session.signedIn = false;
          }

          if (data["data"]["has_completed"] == true) {
            Session.completed = true;
          } else {
            Session.completed = false;
          }

          emailController.clear();
          passwordController.clear();
          emailController.dispose();
          passwordController.dispose();

          Navigator.pop(context);
          routePermanentlyTo(context, HomePage());
        } else {
          Navigator.pop(context);
          showActionSnackbar(context, "Loggin Attempt failed!", "", () {});
        }

        print(response.body);
      } else {
        showActionSnackbar(
            context, "Something went wrong!!", "Try Again", submit);
        Navigator.pop(context);
      }
    } catch (exception) {
      showActionSnackbar(context, "Connection Error", "Try Again", submit);
      Navigator.pop(context);
      print(exception);
    }
  }
}
