import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workers/values/colors.dart';

import '../values/Theme.dart';
import '../widgets/widgets.dart';

class Preferences extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PreferencesState();
  }
}

class PreferencesState extends State<Preferences> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        body: Container(
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0),
            children: [
              //Checkbox(value: true, onChanged: (value) {}),

              ElevatedButton(
                  style: ButtonStyle(backgroundColor: StateBtnColor(0)),
                  onPressed: () {},
                  child: Text("Polictics")),
              ElevatedButton(onPressed: () {}, child: Text("Health")),
              ElevatedButton(onPressed: () {}, child: Text("Education")),
              ElevatedButton(onPressed: () {}, child: Text("Technology")),
              ElevatedButton(onPressed: () {}, child: Text("Religion")),
              ElevatedButton(onPressed: () {}, child: Text("Science")),
              ElevatedButton(onPressed: () {}, child: Text("Family")),
              ElevatedButton(onPressed: () {}, child: Text("Entertainment")),
              ElevatedButton(onPressed: () {}, child: Text("Gossip")),

              ElevatedButton(onPressed: () {}, child: Text("Nature")),
              ElevatedButton(onPressed: () {}, child: Text("Sports")),
            ],
          ),
        ),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              centerTitle: true,
              floating: true,
              snap: true,
              title: Text("Preferences"),
              // actions: [navActions(context, Icons.share, null)],
            )
          ];
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
