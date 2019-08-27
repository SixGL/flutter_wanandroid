import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main/SMainPage.dart';
import 'main/route/Routes.dart';
import 'main/util/Style.dart';

void main() => {
  // 强制竖屏
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
          .then((portait) {
        runApp(new MyApp());
      })
    };

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
      theme: new ThemeData(
          platform: TargetPlatform.iOS,
          primaryColor: Color(Stytle.C_theme),
          accentColor: Color(Stytle.C_theme),
          primaryColorDark: Color(Stytle.C_theme)),
      title: "玩Android",
      debugShowCheckedModeBanner: false,
    );
  }
}
