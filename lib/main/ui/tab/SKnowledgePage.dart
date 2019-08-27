import 'package:first_flutter_app/main/Http/SHttp.dart';
import 'package:first_flutter_app/main/Http/SLog.dart';
import 'package:first_flutter_app/main/m/WX_Autor_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../../entity_factory.dart';

class KnowledgeContentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return KnowledgeState();
  }
}

class KnowledgeState extends State {
  List<WXAutorData> data = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _getData();
  }

  List<Widget> listBanner = [
    Image.asset(
      "images/banner_1.jpg",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "images/banner_2.jpg",
      fit: BoxFit.cover,
    ),
    new Image.asset(
      "images/banner_3.jpg",
      fit: BoxFit.cover,
    ),
    new Image.asset(
      "images/banner_4.jpg",
      fit: BoxFit.cover,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("banner"),
      ),
      body: Container(
        height: 160,
        child: Swiper(
//          viewportFraction: 0.8,
//          scale: 0.9,
          //     itemWidth、layout 结合使用
          itemWidth: 300,
          layout: SwiperLayout.STACK,
          onTap: (index) {
            print("${index}");
          },
          autoplay: true,
          itemBuilder: (BuildContext context, int index) {
            return _getBanner(index);
          },
          itemCount: 3,
          pagination: new SwiperPagination(),
          control:
              new SwiperControl(size: 20, iconPrevious: null, iconNext: null),
        ),
      ),
    );
  }

//
//  TabBar(
//  labelStyle: TextStyle(fontSize: 16),
//  unselectedLabelStyle: TextStyle(fontSize: 14),
//  indicatorSize: TabBarIndicatorSize.label,
//  isScrollable: true,
//  tabs: _getTabItem(),
//  ),
//  TabBarView(children: _getTabItem(index: 2)),

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

  Widget _getBanner(int index) {
    return listBanner[index];
  }
}
