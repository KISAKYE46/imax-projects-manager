import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void routeTo(BuildContext context, Widget page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return page;
  }));
}

void routePermanentlyTo(BuildContext context, Widget page) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
    return page;
  }));
}
