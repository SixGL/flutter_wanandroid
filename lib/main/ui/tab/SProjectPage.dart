import 'package:first_flutter_app/main/Http/SHttp.dart';
import 'package:first_flutter_app/main/Http/SLog.dart';
import 'package:first_flutter_app/main/m/WX_Autor_entity.dart';
import 'package:flutter/material.dart';

import '../../../entity_factory.dart';

class ProjectContentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProjectState();
  }
}

class ProjectState extends State {
  List<WXAutorData> data = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
//      length: data != null ? data.length : 0,
      length: data.length,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            labelStyle: TextStyle(fontSize: 16),
            unselectedLabelStyle: TextStyle(fontSize: 14),
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            tabs: _getTabItem(),
          ),
        ),
        body: TabBarView(children: _getTabItem(index: 2)),
      ),
    );
  }

  /**
   * todo
   * */
  List _getData() {
    HttpUtil.get("wxarticle/chapters/json  ", success: (value) {
      Log.i("公众号 Error = $value ");
      WXAutorEntity generateOBJ = EntityFactory.generateOBJ(value);
      setState(() {
        if (data != null) {
          data.clear();
          data.addAll(generateOBJ.data);
        }
      });
    }, error: (msg, code) {
      Log.i("文章列表 Error = $msg  $code");
      return null;
    });
  }

  List<Widget> _getTabItem({int index}) {
    List<Widget> listWidgetTitle = new List();
    List<Widget> listWidgetContent = new List();
    if (data != null) {
      for (int i = 0; i < data.length; i++) {
        if (index == 2) {
          listWidgetContent.add(Center(child: Text(data[i].name)));
        } else {
          listWidgetTitle.add(Tab(text: data[i].name));
        }
      }
      if (index != 2)
        return listWidgetTitle;
      else
        return listWidgetContent;
    }
  }
}
