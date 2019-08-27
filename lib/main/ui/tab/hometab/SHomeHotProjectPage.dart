import 'package:flutter/material.dart';

class HomeProjectContentPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeProjectState();
  }
}

class HomeProjectState extends State with AutomaticKeepAliveClientMixin{



  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text("HomeProjectContentPage"),
    );
  }


}