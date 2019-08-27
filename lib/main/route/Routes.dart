import 'package:first_flutter_app/main/ui/tab/SHomePage.dart';
import 'package:first_flutter_app/main/ui/web/SWebView.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import '../SMainPage.dart';

final Map<String, Function> routes = {
  '/': (context, {arguments}) => MainPage(),
  '/Swebview': (context, {arguments}) => Swebview(arguments: arguments),
//  "/routeNamedPage": (context, {arguments}) => RouteNamedPage(content: arguments),
//  "/routeB_Page": (context) => B_Page(),
//  "/routeC_Page": (context) => C_Page(),
//  "/routeDrawerItemPage": (context) => DrawerItemPage()
};

var onGenerateRoute = (RouteSettings settings) {
// 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
