import 'package:flutter/material.dart';

import 'ui/tab/SHomePage.dart';
import 'ui/tab/SKnowledgePage.dart';
import 'ui/tab/SProjectPage.dart';
import 'ui/tab/SWXPage.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainBodyPage();
  }
}

class MainBodyPage extends State<MainPage> {
//  with AutomaticKeepAliveClientMixin
//
//  @override
//  // TODO: implement wantKeepAlive
//  bool get wantKeepAlive => true;

  List _listTitle = ["首页", "微信公众号", "项目", "项目涉及知识"];
  List _listIcon = [
    "images/f_atr_unselect.png",
    "images/f_wx_unselect.png",
    "images/f_project_unselect.png",
    "images/f_project_unselect.png"
  ];
  List _listActiveIcon = [
    "images/f_atr_select.png",
    "images/f_wx_select.png",
    "images/f_project_select.png",
    "images/f_project_select.png"
  ];
  List<Widget> _listPage = [
    HomeContentPage(),
    WXContentPage(),
    ProjectContentPage(),
    KnowledgeContentPage()
  ];
  int _tapCurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

        body: IndexedStack(
            // 解决底部tab切换page状态丢失问题
            index: _tapCurrentIndex,
            children: _listPage),
        bottomNavigationBar: _getBottomNavigationBar());
  }

  BottomNavigationBar _getBottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        _BottomNavigationBarItem(0),
        _BottomNavigationBarItem(1),
        _BottomNavigationBarItem(2),
        _BottomNavigationBarItem(3),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: _tapCurrentIndex,
      onTap: (index) {
        setState(() {
          _tapCurrentIndex = index;
        });
      },
    );
  }

  BottomNavigationBarItem _BottomNavigationBarItem(int index) {
    return BottomNavigationBarItem(
      icon: _getIcon(index),
      activeIcon: _getActiveIcon(index),
      title: Text(_listTitle[index]),
    );
  }

  Widget _getIcon(int index) {
    return new Image.asset(
      _listIcon[index],
      width: 25,
      height: 25,
    );
  }

  Widget _getActiveIcon(int index) {
    return new Image.asset(
      _listActiveIcon[index],
      width: 25,
      height: 25,
    );
  }
}
