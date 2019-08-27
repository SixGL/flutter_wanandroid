import 'package:first_flutter_app/main/Http/SHttp.dart';
import 'package:flutter/material.dart';

import 'hometab/SHomeHotAtrPage.dart';
import 'hometab/SHomeHotProjectPage.dart';
import 'package:dio/dio.dart';

class HomeContentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

List _listTitle = ["热门文章", "热门项目"];

class HomeState extends State {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: _listTitle.length,
        child: Scaffold(

          appBar: AppBar(
            textTheme: TextTheme(),
            elevation: 0,
//            leading: _getHeadIm(),
            title: TabBar(
                labelStyle: TextStyle(fontSize: 16),
                unselectedLabelStyle: TextStyle(fontSize: 14),
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [_getTabTitle(0), _getTabTitle(1)]),
          ),
          body: _getTabView(),
        ));
  }
}

TabBarView _getTabView() {
  return TabBarView(children: [HomeAtrContentPage(), HomeProjectContentPage()]);
}

/**
 *设置Tab的Title
 * */
Widget _getTabTitle(int index) {
  return Tab(
    text: _listTitle[index],
  );
}

Widget _getHeadIm() {
  return IconButton(
    onPressed: () {},
    icon: ClipOval(
      child: Image.asset(
        "images/f_wa.png",
        width: 35,
        height: 35,
        fit: BoxFit.cover,
      ),
    ),
  );
}
