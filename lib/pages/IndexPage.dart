import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:workers/pages/SearchPage.dart';
import 'package:workers/values/colors.dart';
import '../widgets/widgets.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late List<String> titles;

  @override
  void initState() {
    super.initState();
    titles = [
      "Headlines",
      "Gossip",
      "Entertainment",
      "Health",
      "Politics",
      "Technology",
      "Business"
    ];
    tabController = TabController(length: titles.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: drawerView(context),
        ),
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  elevation: 0,
                  backgroundColor: ThemeColors.systemColorLight,
                  centerTitle: true,
                  title: Text(
                    "",
                    style: TextStyle(color: ThemeColors.colorPrimary),
                  ),
                  actions: [
                    navActions(context, Icons.search, SearchPage()),
                    navBadge(context, Icons.notifications, "9"),
                  ],
                  floating: true,
                  pinned: true,
                  snap: true,
                  bottom: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: EdgeInsets.zero,
                    unselectedLabelColor: ThemeColors.systemColorOnLight,
                    isScrollable: true,
                    controller: tabController,
                    indicator: BoxDecoration(
                        backgroundBlendMode: BlendMode.darken,
                        color: ThemeColors.colorPrimary,
                        borderRadius: BorderRadius.circular(20)),
                    tabs: titles.map((title) {
                      return Tab(
                        iconMargin: EdgeInsets.all(0),
                        // icon: Badge(
                        //   badgeColor: ThemeColors.systemColorLight,
                        //   badgeContent: Text("4"),
                        // ),
                        //icon: Icon(Icons.bookmark),
                        text: title,
                      );
                    }).toList(),
                  ),
                )
              ];
            },
            body: Container()));
    //   body: TabBarView(
    //     children: titles.map((title) {
    //       if (title.contains("Headlines")) {
    //        /// return HeadlinesPage();
    //       } else {
    //       //  return NewsPage();
    //       }
    //     }).toList(),
    //     controller: tabController,
    //   ),
    // ));
  }
}
