import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void routeTo(BuildContext context, Widget page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return page;
  }));
}

void routeWithAction(BuildContext context, Widget page, Function action) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return page;
  })).then((value) {
    action();
  });
}

void routePermanentlyTo(BuildContext context, Widget page) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
    return page;
  }));
}
