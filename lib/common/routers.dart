
import 'package:flutter/cupertino.dart';
import 'package:score/pages/home_page.dart';
import 'package:score/pages/match_page.dart';

Map<String, WidgetBuilder> routers = {
  "/": (context) => new MyHomePage(title: "index"),
  "/match": (context) => new MatchPage(id: ModalRoute.of(context).settings.arguments),
};


