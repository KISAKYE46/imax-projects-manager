import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:workers/pages/IndexPage.dart';
import 'package:workers/pages/Preferences.dart';
import 'package:workers/router/page_router.dart';
import 'package:workers/session/Session.dart';
import 'package:workers/values/colors.dart';
import 'pages/HomePage.dart';
import 'pages/intro.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: ThemeColors.systemColorLight,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));
  //Session.updateSession();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Supervisor',
      theme: ThemeData(
          primaryColorLight: ThemeColors.colorPrimary,
          primaryColorDark: ThemeColors.systemColorOnLight,
          primarySwatch: ThemeColors.systemPrimarySwatch,
          primaryColor: ThemeColors.colorPrimary,
          buttonTheme: ButtonThemeData(buttonColor: ThemeColors.colorPrimary),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(backgroundColor: ThemeColors.buttonColor)),
          appBarTheme: AppBarTheme(
              backgroundColor: ThemeColors.colorPrimary, elevation: 1.0),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: ThemeColors.colorPrimary),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(),
          ),
          tabBarTheme: TabBarTheme(
              labelColor: ThemeColors.systemColorLight,
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                      color: ThemeColors.systemColorLight, width: 4.0)))),

      //home: MyHomePage(title: ""),
      //home: DetailsPage(),
      home: HomePage(),

      //home: Notifications(),

      // home: Preferences(),

      //home: MyHomePage(title: 'Device Specs'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Widget currentPage;
  late Response response;

  @override
  void initState() {
    super.initState();
    currentPage = IntroPage();
    Timer(Duration(seconds: 3), () {
      changePage(context);
    });
  }

  void changePage(BuildContext context) async {
    checkServer();

    // MaterialPageRoute pageRoute = MaterialPageRoute(builder: (context) {
    //   return IndexPage();
    // });
    // Navigator.of(context).pushReplacement(pageRoute);
  }

  Future<Response> checkConnection(Uri url) async {
    return await http.get(url);
  }

  void checkServer() async {
    routePermanentlyTo(context, IndexPage());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: currentPage,
      onTap: () {
        changePage(context);
      },
    );
  }
}
