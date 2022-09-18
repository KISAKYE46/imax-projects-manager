import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DataPageState();
  }
}

class DataPageState extends State<DataPage> {
  @override
  Widget build(BuildContext context) {
    var dpi = MediaQuery.of(context).devicePixelRatio;
    var brightness = MediaQuery.of(context).platformBrightness;
    var size = MediaQuery.of(context).size;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var width = size.width;
    var height = size.height;
    var prefferedFontSize = 14.0;

    var backgroundColor =
        brightness == Brightness.dark ? Colors.black : Colors.white;
    var textColor = brightness == Brightness.dark ? Colors.white : Colors.black;

    var styleOfText = TextStyle(color: textColor);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          title: Text("Device Specs", style: styleOfText),
        ),
        body: Container(
            color: backgroundColor,
            alignment: Alignment.topLeft,
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.aspect_ratio,
                    color: textColor,
                  ),
                  title: Text(
                    "Device Pixel Ratio",
                    style: styleOfText,
                  ),
                  subtitle: Text(
                    "$dpi",
                    style: TextStyle(
                        fontSize: prefferedFontSize, color: textColor),
                  ),
                ),
                ListTile(
                    leading: Icon(
                      Icons.light,
                      color: textColor,
                    ),
                    title: Text(
                      "Device Brightness",
                      style: styleOfText,
                    ),
                    subtitle: Text(
                        "${brightness == Brightness.light ? 'light' : 'dark'}",
                        style: styleOfText)),
                ListTile(
                  leading: Icon(
                    Icons.table_rows,
                    color: textColor,
                  ),
                  title: Text(
                    "Device Width",
                    style: styleOfText,
                  ),
                  subtitle: Text(
                    "$width",
                    style: styleOfText,
                  ),
                  trailing: Icon(Icons.done),
                ),
                ListTile(
                  leading: Icon(
                    Icons.view_column,
                    color: textColor,
                  ),
                  title: Text(
                    "Device Height",
                    style: styleOfText,
                  ),
                  subtitle: Text(
                    "$height",
                    style: styleOfText,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.format_indent_increase,
                    color: textColor,
                  ),
                  title: Text(
                    "Device Text Scale Factor",
                    style: styleOfText,
                  ),
                  subtitle: Text(
                    "$textScaleFactor",
                    style: styleOfText,
                  ),
                ),
              ],
            )));
  }
}
