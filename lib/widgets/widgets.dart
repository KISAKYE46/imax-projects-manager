import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workers/pages/DetailsPage.dart';
import 'package:workers/pages/LogginPage.dart';
import 'package:workers/pages/Notifications.dart';
import 'package:workers/pages/Preferences.dart';
import 'package:workers/router/page_router.dart';
import 'package:workers/session/Session.dart';
import 'package:workers/values/Theme.dart';
import 'package:workers/values/colors.dart';
import 'package:workers/values/dimen.dart';
import 'package:workers/values/strings.dart';

import '../pages/TaskDetails.dart';

Widget headline(
    BuildContext context,
    String title,
    String subtitle,
    String category,
    String date,
    String author,
    String details,
    String image,
    String id) {
  return GestureDetector(
    onTap: () {
      routeTo(
          context,
          DetailsPage(title, subtitle, details, category, author, id, date,
              date, image));
    },
    child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: headlineHeight,
        ),
        child: Card(
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            height: headlineHeight,
            child: Stack(
              children: [
                headlineImage(image),
                headlineBookmarkBadge(context, {
                  "id": id,
                  "title": title,
                  "subtitle": subtitle,
                  "author": author,
                  "details": details,
                  "image": image,
                  "category": category,
                  "date": date
                }),
                headlineAside(),
                headlineTitle("${title}"),
              ],
            ),
          ),
        )),
  );
}

Widget commentPhoto(BuildContext context, String image) {
  return SizedBox(
      height: commentImageSize,
      child: ClipRRect(
        borderRadius: SystemTheme.imageRadius,
        child: Image.network(
          "$systemImageUrl$image",
          errorBuilder:
              (BuildContext context, Object object, StackTrace? trace) {
            return Text("Error loading image");
          },
        ),
      ));
}

Widget comment(BuildContext context, String name, String body, String date,
    String image, String commentId, String articleId) {
  return Container(
      padding: SystemTheme.fabMargin,
      child: ListTile(
        isThreeLine: true,
        enabled: true,
        tileColor: ThemeColors.systemColorLight,
        leading: commentPhoto(context, image),
        title: Row(
          children: [
            Text(
              "$name",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Text(
              " . ",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Text(
              "$date",
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(dummyComment),
          GestureDetector(
              onTap: () {
                routeTo(context, LogginPage());
                // showCupertinoModalPopup(
                //     semanticsDismissible: true,
                //     barrierDismissible: true,
                //     context: context,
                //     builder: (context) {
                //       return ConstrainedBox(
                //         constraints:
                //             BoxConstraints(minHeight: 250, maxHeight: 400),
                //         child: Container(
                //             margin: SystemTheme.fabMargin,
                //             padding: SystemTheme.fabMargin,
                //             color: ThemeColors.systemColorLight,
                //             child: loggin(context)),
                //       );
                //     });
              },
              child: Container(
                margin: SystemTheme.fabTopMargin,
                child: Text(
                  "Reply",
                  style: Theme.of(context).textTheme.button,
                ),
              ))
        ]),
      ));
}

Widget loggin(BuildContext context) {
  var fieldController = TextEditingController();

  return Container(
    alignment: Alignment.center,
    padding: SystemTheme.fabMargin,
    child: ListView(
      children: [
        Text(
          "You are not logged in",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5,
        ),
        textField(context, "Input", fieldController, null),
        ElevatedButton(onPressed: () {}, child: Text("Login"))
      ],
    ),
  );
}

Widget termsAndConditions(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    padding: SystemTheme.fabRLMargin,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Accept Our"),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Terms and Conditions",
              style: TextStyle(decoration: TextDecoration.underline),
            ))
      ],
    ),
  );
}

Widget textField(BuildContext context, String label,
    TextEditingController? controller, IconData? icon,
    {double? size}) {
  TextEditingController innerController = TextEditingController();
  return Container(
    height: 60,
    padding: SystemTheme.fabMargin,
    child: TextField(
      controller: controller != null ? controller : innerController,
      decoration: InputDecoration(
          hintMaxLines: 20,
          helperMaxLines: 20,
          label: Text(
            label,
            style: TextStyle(fontSize: 12),
          ),
          prefixIcon: Icon(icon == null ? Icons.person : icon),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 0),
              borderRadius: BorderRadius.circular(systemRadius))),
    ),
  );
}

Widget phoneField(BuildContext context, String label,
    TextEditingController? controller, IconData? icon,
    {double? size}) {
  TextEditingController innerController = TextEditingController();
  return Container(
    height: 60,
    padding: SystemTheme.fabMargin,
    child: TextField(
      controller: controller != null ? controller : innerController,
      decoration: InputDecoration(
          hintMaxLines: 20,
          helperMaxLines: 20,
          label: Text(
            label,
            style: TextStyle(fontSize: 12),
          ),
          prefixIcon: Icon(icon == null ? Icons.person : icon),
          focusColor: ThemeColors.systemColorOnLight,
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 0),
              borderRadius: BorderRadius.circular(systemRadius))),
      keyboardType: TextInputType.phone,
    ),
  );
}

Widget largeTextField(BuildContext context, String label,
    TextEditingController? controller, IconData? icon,
    {double? size}) {
  TextEditingController innerController = TextEditingController();
  return Container(
    height: size != null ? size : 60,
    padding: SystemTheme.fabMargin,
    child: TextField(
      maxLines: 20,
      minLines: 12,
      controller: controller != null ? controller : innerController,
      decoration: InputDecoration(
          hintMaxLines: 20,
          helperMaxLines: 20,
          label: Text(
            label,
            style: TextStyle(fontSize: 12),
          ),
          //prefixIcon: Icon(icon == null ? Icons.person : icon),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: .2),
              borderRadius: BorderRadius.circular(systemRadius))),
    ),
  );
}

Widget passwordTextField(BuildContext context, String label,
    TextEditingController? controller, IconData? icon) {
  TextEditingController innerController = TextEditingController();
  return Container(
    height: 60,
    padding: SystemTheme.fabMargin,
    child: TextField(
      controller: controller != null ? controller : innerController,
      obscureText: true,
      autocorrect: false,
      enableSuggestions: false,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          label: Text(
            label,
            style: TextStyle(fontSize: 12),
          ),
          prefixIcon: Icon(icon == null ? Icons.person : icon),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: .2),
              borderRadius: BorderRadius.circular(systemRadius))),
    ),
  );
}

Widget navActions(BuildContext context, IconData icon, Widget? page) {
  return IconButton(
      onPressed: () {
        if (page != null) {
          routeTo(context, page);
        }
      },
      icon: Icon(icon));
}

Widget navMessage(BuildContext context, IconData icon, Function? function) {
  return IconButton(
      onPressed: () {
        if (function != null) {
          function();
        }
      },
      icon: Icon(icon));
}

Widget formTitle(BuildContext context, String title) {
  return Container(
    child: Text(
      "$title",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: ThemeColors.systemColorOnLight,
          fontSize: 19,
          fontWeight: FontWeight.w400),
    ),
    margin: SystemTheme.fabRLBMargin,
  );
}

Widget navBadge(BuildContext context, IconData icon, String value) {
  return Container(
    padding: SystemTheme.fabMargin,
    child: IconButton(
      icon: Badge(
        badgeColor: ThemeColors.colorPrimary,
        child: Icon(Icons.notifications),
        badgeContent: Text(
          "$value",
          style: TextStyle(color: ThemeColors.systemColorLight),
        ),
      ),
      onPressed: () {
        routeTo(context, Notifications());
      },
    ),
  );
}

Widget navSpace() {
  return Container(
    padding: SystemTheme.fabMargin,
  );
}

Widget headlineTitle(String title) {
  return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          dayLabel(Icons.timelapse, "2 days ago"),
          Container(
            padding: SystemTheme.fabMargin,
            child: Text(
              title,
              style: SystemTheme.headingStyle,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ));
}

Widget headlineBookmarkBadge(
    BuildContext context, Map<String, String> article) {
  return Positioned(
      right: 0,
      child: Container(
        padding: SystemTheme.fabMargin,
        child: IconButton(
            splashRadius: 20.0,
            highlightColor: ThemeColors.systemColorLight,
            splashColor: ThemeColors.systemColorLight,
            onPressed: () {
              // Session.bookmarks.add(article);
              showTextSnackbar(context, "Bookmark added successfully");
            },
            icon: Icon(
              Icons.bookmark_add,
              size: iconSize * 1.3,
              color: ThemeColors.colorPrimary,
            )),
      ));
}

Widget headlineAside() {
  return Positioned(
      left: 0,
      child: Container(
        padding: SystemTheme.fabMargin,
        child: Wrap(
          direction: Axis.vertical,
          children: [
            asideItem(Icons.remove_red_eye_rounded, "2k"),
            asideItem(Icons.comment, "2k"),
          ],
        ),
      ));
}

Widget asideItem(IconData icon, String label) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Icon(
        icon,
        size: iconSize * 0.7,
        color: ThemeColors.systemColorLight,
      ),
      Text(
        " $label ",
        style: SystemTheme.textStyle,
      )
    ],
  );
}

Widget headlineImage(String image) {
  try {
    return Container(
        height: 200,
        width: double.maxFinite,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(systemRadius),
          child: Image.network(
            "$systemImageUrl$image",
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress != null) {
                return Container(
                  width: double.maxFinite,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              } else {
                return child;
              }
            },
            errorBuilder:
                (BuildContext context, Object object, StackTrace? trace) {
              return Container(
                  width: double.maxFinite,
                  child: Icon(
                    Icons.error_outline_rounded,
                    size: 30,
                    color: ThemeColors.systemColorLight,
                  ));
            },
            fit: BoxFit.cover,
          ),
        ));
  } catch (exception) {
    return Container(
        height: 200,
        width: double.maxFinite,
        color: ThemeColors.colorPrimary,
        child: Container(
          width: double.maxFinite,
          child: Center(
            child: Text("Error"),
          ),
        ));
  }
}

Widget dayLabel(IconData icon, String label) {
  return Container(
      padding: EdgeInsets.all(systemPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            icon,
            size: iconSize * 0.7,
            color: ThemeColors.systemColorLight,
          ),
          Text(
            " $label ",
            style: SystemTheme.textStyle,
          )
        ],
      ));
}

Widget newSection(
    BuildContext context,
    String title,
    String subtitle,
    String category,
    String date,
    String author,
    String image,
    String details,
    String id) {
  return GestureDetector(
      onTap: () {
        routeTo(
            context,
            DetailsPage(title, subtitle, details, category, author, id, date,
                date, image));
      },
      child: Card(
        elevation: 0.5,
        child: Container(
            child: ListTile(
          isThreeLine: true,
          leading: Container(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(systemPadding),
            child: Image.network(
              "$systemImageUrl$image",
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress != null) {
                  return Container(
                    width: double.maxFinite,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                } else {
                  return child;
                }
              },
              errorBuilder:
                  (BuildContext context, Object object, StackTrace? trace) {
                return Container(
                    width: 89.0,
                    height: double.infinity,
                    color: ThemeColors.colorPrimary,
                    child: Icon(
                      Icons.error_outline_rounded,
                      size: 30,
                      color: ThemeColors.systemColorLight,
                    ));
              },
              fit: BoxFit.fill,
            ),
          )),
          title:
              Text("$title\n", style: TextStyle(fontWeight: FontWeight.w500)),
          subtitle: Row(
            children: [
              Text(
                "Politics",
                style: SystemTheme.newsCategoryTextStyle,
              ),
              Text(
                " 2 days ago",
                style: SystemTheme.newsNewDateTextStyle,
                textAlign: TextAlign.right,
              )
            ],
          ),
          trailing: Icon(
            Icons.share,
            size: iconSize * 0.75,
            color: ThemeColors.colorPrimary,
          ),
          selectedTileColor: ThemeColors.colorPrimary,
        )),
      ));
}

Widget drawerView(BuildContext context) {
  return Wrap(
    children: [
      DrawerHeader(
          child: Container(
        width: double.maxFinite,
        child: Card(
          color: ThemeColors.colorPrimary,
        ),
      )),
      drawerTile(context, Icons.settings, "Settings"),
      DrawerController(
        child: drawerTile(context, Icons.bookmark, "Bookmarks"),
        alignment: DrawerAlignment.start,
      )
    ],
  );
}

Widget drawerTile(BuildContext context, IconData icon, String title) {
  return ListTile(
    onTap: () {
      routeTo(context, Preferences());
    },
    leading: Icon(icon),
    title: Text("$title"),
  );
}

Widget detailsImageSection(BuildContext context, String image, String caption) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 220, minHeight: 220),
          child: Container(
            color: ThemeColors.colorPrimary,
            child: Image.network(
              "$systemImageUrl${image}",
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress != null) {
                  return Container(
                    width: double.maxFinite,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                } else {
                  return child;
                }
              },
              errorBuilder:
                  (BuildContext context, Object object, StackTrace? trace) {
                return Container(
                    width: double.maxFinite,
                    child: Icon(
                      Icons.error_outline_rounded,
                      size: 30,
                      color: ThemeColors.systemColorLight,
                    ));
              },
              fit: BoxFit.cover,
            ),
          )),
      Container(
        alignment: Alignment.center,
        child: Text(
          "Image Credit: Piterest.com",
          style: Theme.of(context).textTheme.caption,
        ),
      )
    ],
  );
}

Widget dialog(BuildContext context, String title, String content,
    IconData? icon, Function? action) {
  return AlertDialog(
    elevation: 0,
    icon: Icon(icon == null ? Icons.network_cell_sharp : icon),
    title: Text("$title"),
    actions: [
      TextButton(
          onPressed: () {
            if (action != null) {
              action();
            }
            Navigator.of(context, rootNavigator: true).pop('dialog');
          },
          child: Text("Retry"))
    ],
    content: Text("$content"),
  );
}

void showTextSnackbar(BuildContext context, String message) {
  var snackbar = SnackBar(
      backgroundColor: ThemeColors.colorPrimary, content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

void showLongSnackbar(BuildContext context, String message) {
  var snackbar = SnackBar(
      duration: Duration(seconds: 12),
      backgroundColor: ThemeColors.colorPrimary,
      content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

void showActionSnackbar(
    BuildContext context, String message, String actionText, Function action) {
  var snackbar = SnackBar(
      backgroundColor: ThemeColors.colorPrimary,
      action: SnackBarAction(
          textColor: ThemeColors.systemColorLight,
          label: actionText,
          onPressed: () {
            action();
          }),
      content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

void showPersistentSnackbar(BuildContext context, String message,
    {Color? color}) {
  var snackbar = SnackBar(
    backgroundColor: color == null ? ThemeColors.colorPrimary : color,
    content: Text(message),
    duration: Duration(seconds: 15),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

Widget errorWidget(String message, IconData? icon) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(
        icon == null ? Icons.cloud_off : icon,
        size: errorIconSize,
        color: ThemeColors.colorPrimary,
      ),
      Text(message)
    ],
  );
}

Widget loadingWidget({Color color = ThemeColors.colorPrimary}) {
  return Container(
    padding: SystemTheme.fabMargin,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          color: color,
        ),
      ],
    ),
  );
}

Widget noWidget() {
  return Text("");
}

Widget dashBoardCard(BuildContext context, String text, IconData icon,
    {Widget? page, Color? color, Function? action}) {
  return Card(
    elevation: 3,
    shadowColor: ThemeColors.colorPrimary,
    child: GestureDetector(
      onTap: () {
        if (page != null) {
          routeTo(context, page);
        }

        if (action != null) {
          action();
        }
      },
      child: Container(
        color: color,
        padding: SystemTheme.fabMargin,
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: ThemeColors.colorPrimary,
            ),
            Text(
              "\n" + text,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    ),
  );
}

Widget historyCard(BuildContext context, String heading,
    {String startDate = "", String? endDate, Map? task}) {
  return Container(
    margin: SystemTheme.fabBottomMargin,
    child: ListTile(
      tileColor: ThemeColors.systemColorLight,
      iconColor: ThemeColors.colorPrimary,
      leading: Icon(endDate == null ? Icons.work_history : Icons.check,
          color: endDate == null
              ? ThemeColors.colorDanger
              : ThemeColors.colorSuccess),
      title: Text(heading),
      subtitle: Text(
        "From $startDate  till ${endDate == null ? 'unspecified time' : endDate.toString().split(' ')[0]}",
        style: TextStyle(
            color: endDate == null
                ? ThemeColors.colorDanger
                : ThemeColors.colorSuccess),
      ),
      onTap: () {
        if (task != null) {
          routeTo(context, TaskDetails(task));
        }
      },
    ),
  );
}

Widget taskHeadingCard(BuildContext context, String heading,
    {String startDate = "",
    String? endDate,
    String? location = "",
    String? body = ""}) {
  return Container(
    child: ListTile(
      tileColor: ThemeColors.systemColorLight,
      iconColor: ThemeColors.colorPrimary,
      leading: Icon(endDate == null ? Icons.work_history : Icons.check,
          color: endDate == null
              ? ThemeColors.colorDanger
              : ThemeColors.colorSuccess),
      title: Text(heading),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "From $startDate  till ${endDate == null ? 'unspecified time' : endDate.toString().split(' ')[0]}",
            style: TextStyle(
                color: endDate == null
                    ? ThemeColors.colorDanger
                    : ThemeColors.colorSuccess),
          ),
          Container(
            padding: SystemTheme.fabTBMargin,
            child: Row(
              children: [Icon(Icons.location_on), Text(" ${location}")],
            ),
          ),
          Container(
            padding: SystemTheme.fabTBMargin,
            child: Text("$body"),
          )
        ],
      ),
      onTap: () {
        //routeTo(context, TaskDetails());
      },
    ),
  );
}

Widget descriptionBody(BuildContext context, String desc) {
  return ConstrainedBox(
    constraints: BoxConstraints(minHeight: 80),
    child: Container(
        child: Card(
      child: Container(
        margin: SystemTheme.fabTBMargin,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(desc)],
        ),
        padding: SystemTheme.fabMargin,
      ),
    )),
  );
}

Widget locationCard(BuildContext context, String heading,
    {String startDate = "", String? endDate, Map? task}) {
  return Card(
    child: GestureDetector(
      onTap: () {
        if (task != null) {
          routeTo(context, TaskDetails(task));
        }
      },
      child: Container(
          padding: SystemTheme.fabMargin,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: ThemeColors.colorDanger,
              ),
              Text(
                "\n$heading",
                textAlign: TextAlign.center,
              )
            ],
          )),
    ),
  );
}

Widget labelText(BuildContext context, String label) {
  return Container(
    margin: SystemTheme.fabTBMargin,
    child: Text(
      "$label",
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}

Widget statusMessage(BuildContext context, String message) {
  return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            subtitle: Text("Nothing here!!"),
          )
        ],
      ));
}

void loadingDialog(BuildContext context) {
  showDialog(
      barrierColor: ThemeColors.systemColorLight,
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: SystemTheme.fabTopMargin,
          margin: SystemTheme.fabTopMargin,
          height: double.maxFinite,
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              loadingWidget(),
              Text(
                "Please Wait..",
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          ),
        );
      });
}

Widget noDataWidget({String text = "No Records Found"}) {
  return Container(
    alignment: Alignment.center,
    child: Text(
      text,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
  );
}

Widget companyLogo(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    padding: SystemTheme.fabBottomMargin,
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 200, maxHeight: 200),
      child: Image.asset("assets/images/logo.png"),
    ),
  );
}
