import 'package:flutter/material.dart';
import 'package:workers/values/Theme.dart';
import 'package:workers/widgets/widgets.dart';

class DetailsPage extends StatefulWidget {
  late String articleTitle;
  late String articleBody;
  late String articleSubtitle;
  late String categoryId;
  late String author;
  late String articleId;
  late String createDate;
  late String updateDate;
  late String articleImage;

  DetailsPage(
      this.articleTitle,
      this.articleSubtitle,
      this.articleBody,
      this.categoryId,
      this.author,
      this.articleId,
      this.createDate,
      this.updateDate,
      this.articleImage);
  @override
  _DetailsPageState createState() => _DetailsPageState(
      this.articleTitle,
      this.articleSubtitle,
      this.articleBody,
      this.categoryId,
      this.author,
      this.articleId,
      this.createDate,
      this.updateDate,
      this.articleImage);
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late String articleTitle;
  late String articleBody;
  late String articleSubtitle;
  late String categoryId;
  late String author;
  late String articleId;
  late String createDate;
  late String updateDate;
  late String articleImage;

  _DetailsPageState(
      this.articleTitle,
      this.articleSubtitle,
      this.articleBody,
      this.categoryId,
      this.author,
      this.articleId,
      this.createDate,
      this.updateDate,
      this.articleImage);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        body: Container(
          child: ListView(
            children: [
              Container(
                padding: SystemTheme.fabMargin,
                child: Text(
                  "${this.articleTitle}",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Container(
                padding: SystemTheme.fabMargin,
                child: Text(
                  "By Tommy Kerry. ${this.createDate}. ${this.author}. ",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Container(
                  padding: SystemTheme.fabTopMargin,
                  child: detailsImageSection(context, articleImage, "+")),
              Container(
                padding: SystemTheme.fabRLTMargin,
                child: Text(
                  "${this.articleBody}",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              Container(
                  padding: SystemTheme.fabTopMargin,
                  child: detailsImageSection(context, articleImage, "")),
              Container(
                padding: SystemTheme.fabMargin,
                child: Text("\nComments and Reviews"),
              ),
              comment(context, "Eddy Gross", "", "Thur 8 Jul 2023", "user1.jpg",
                  "1", ""),
              comment(context, "Eddy Gross", "", "Thur 8 Jul 2023", "user2.jpg",
                  "1", ""),
              comment(context, "Eddy Gross", "", "Thur 8 Jul 2023",
                  "avatar.png", "1", ""),
            ],
          ),
        ),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              centerTitle: true,
              floating: true,
              snap: true,
              title: Text("Details"),
              actions: [navActions(context, Icons.share, null)],
            )
          ];
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_comment_outlined),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }
}
