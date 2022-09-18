import 'package:flutter/material.dart';
import 'package:workers/pages/Dashboard.dart';
import 'package:workers/pages/SearchPage.dart';
import 'package:workers/values/colors.dart';
import '../widgets/widgets.dart';
import 'Account.dart';

class HomePage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<HomePage> {
  late List<String> titles;

  late Widget page;
  List<Widget> pages = [Dashboard(), Account()];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    page = pages[currentIndex];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (int index) {
            setState(() {
              page = pages[index];
              currentIndex = index;
              // showActionSnackbar(context, "$index", "", () {});
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard), label: "Dashboard"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account")
          ]),
    );
  }
}
