import 'dart:convert';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:workers/pages/Departments.dart';
import 'package:workers/pages/Designations.dart';
import 'package:workers/pages/LogginPage.dart';
import 'package:workers/router/page_router.dart';
import 'package:workers/values/Theme.dart';
import 'package:workers/values/colors.dart';
import 'package:workers/values/strings.dart';
import 'package:workers/widgets/widgets.dart';

import '../session/Session.dart';
import 'Gender.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState<RegisterPage> extends State {
  var selectedGender = "Select your gender";
  var selectedDept = "Select your department..";
  var selectedDes = "Select your designation..";

  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController password2Controller = new TextEditingController();
  TextEditingController nameController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedGender = "Select your gender";
    selectedDept = "Select your department..";
    selectedDes = "Select your designation..";
  }

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

            formTitle(context, "Create a Workers Account"),

            Container(
              padding: SystemTheme.fabBottomMargin,
            ),
            textField(context, "Full Name", nameController, Icons.person),

            ListTile(
              onTap: () {
                routeWithAction(context, Departments(), () {
                  if (Session.dept["name"] != "") {
                    setState(() {
                      selectedDept = Session.dept["name"]!;
                    });
                  }
                });
              },
              title: Text("Department"),
              leading: Icon(Icons.group),
              trailing: Icon(Icons.arrow_forward_ios),
              subtitle: Text("$selectedDept"),
            ),

            ListTile(
              onTap: () {
                routeWithAction(context, Designations(), () {
                  setState(() {
                    if (Session.des["name"] != "") {
                      setState(() {
                        selectedDes = Session.des["name"]!;
                      });
                    }
                  });
                });
              },
              title: Text("Designation/Responsibility"),
              leading: Icon(Icons.work),
              trailing: Icon(Icons.arrow_forward_ios),
              subtitle: Text("$selectedDes"),
            ),

            Container(
              padding: SystemTheme.fabBottomMargin,
            ),
            phoneField(context, "Phone Number", phoneController, Icons.phone),

            Container(
              padding: SystemTheme.fabBottomMargin,
            ),

            ListTile(
              onTap: () {
                routeWithAction(context, Gender(), () {
                  if (Session.gender["name"] != null) {
                    setState(() {
                      selectedGender = Session.gender["name"]!;
                    });
                  }
                });
              },
              title: Text("Gender"),
              leading: Icon(Icons.man),
              trailing: Icon(Icons.arrow_forward_ios),
              subtitle: Text("$selectedGender"),
            ),
            passwordTextField(
                context, "Create Password", passwordController, Icons.lock),

            Container(
              padding: SystemTheme.fabBottomMargin,
            ),
            passwordTextField(
                context, "Confirm Password", password2Controller, Icons.lock),

            Container(
              margin: SystemTheme.fabRLMargin,
              child: ElevatedButton(
                  onPressed: () {
                    submit(context);
                  },
                  child: Text("Create Account")),
            ),

            Container(
              alignment: Alignment.center,
              padding: SystemTheme.fabRLMargin,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Have an account?"),
                  TextButton(
                      onPressed: () {
                        routeTo(context, LogginPage());
                      },
                      child: Text("Sign In")),
                ],
              ),
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
            snap: false,
            iconTheme: IconThemeData(color: ThemeColors.colorPrimary),
            elevation: 0,
          )
        ];
      },
    ));
  }

  void submit(BuildContext context) async {
    if (nameController.text.trim() == "") {
      showActionSnackbar(context, "Name Field is Empty", "", () {});
      return;
    }
    if (phoneController.text.trim() == "") {
      showActionSnackbar(context, "Phone Field is Empty", "", () {});
      return;
    }

    if (passwordController.text.trim() == "") {
      showActionSnackbar(context, "Create a Password", "", () {});
      return;
    }

    if (nameController.text.trim() == "") {
      showActionSnackbar(context, "Confirm your Password", "", () {});
      return;
    }

    if (passwordController.text.trim() != password2Controller.text.trim()) {
      showActionSnackbar(context, "Passwords Must Match", "", () {});
      return;
    }

    if (Session.dept["id"] == "") {
      showActionSnackbar(context, "Select your department", "", () {});
      return;
    }

    if (Session.des["id"] == "") {
      showActionSnackbar(context, "Select your designation", "", () {});
      return;
    }

    if (Session.gender["gender"] == "") {
      showActionSnackbar(context, "Select your gender", "", () {});
      return;
    }

    Uri uri = Uri.http(systemHost, systemUrl, {
      "register": "true",
      "contact": phoneController.text,
      "dept_id": Session.dept["id"],
      "des_id": Session.des["id"],
      "gender": Session.gender["gender"],
      "name": nameController.text,
      "pass": passwordController.text,
    });

    loadingDialog(context);

    try {
      http.Response response = await http.get(uri);

      if (!response.body.isEmpty) {
        print(response.body);
        Map data = jsonDecode(response.body);

        String message = data["message"];

        if (message == "success") {
          // Session.contact = data["data"]["contact"];
          // Session.email = data["data"]["email"];
          // Session.name = data["data"]["name"];
          // Session.lastAction = data["data"]["last_login"];
          // Session.today = data["data"]["today"];

          phoneController.clear();
          password2Controller.clear();
          passwordController.clear();
          nameController.clear();

          Navigator.pop(context);
          showActionSnackbar(
              context, "Signed up successfully, you can now ", "Login", () {});
        } else if (message == "contact_exists") {
          Navigator.pop(context);
          showTextSnackbar(context, "Phone number already exists");
        } else {
          Navigator.pop(context);
          showActionSnackbar(context, "Signup failed", "", () {});
        }
      } else {
        Navigator.pop(context);
        showActionSnackbar(
            context, "Something went wrong!!", "Try Again", submit);
      }
    } catch (exception) {
      showActionSnackbar(context, "Connection Error", "Try Again", submit);

      print("Data");
      print(exception);
      Navigator.pop(context);
    }
  }
}
