import 'package:first_flutter_app/main/Http/SHttp.dart';
import 'package:first_flutter_app/main/Http/SLog.dart';
import 'package:first_flutter_app/main/m/WX_Autor_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../../entity_factory.dart';
import '../widget.dart';

class KnowledgeContentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return KnowledgeState();
  }
}

class KnowledgeState extends State {
  GlobalKey<TextState> textKey = GlobalKey();

  List<WXAutorData> data = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
  int tv = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                //展开高度
                expandedHeight: 150.0,
                //是否随着滑动隐藏标题
                floating: false,
                //是否固定在顶部
                pinned: true,
                //可折叠的应用栏
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    '可折叠的组件',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  background: Image.network(
                    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549129578802&di=f866c638ea12ad13c5d603bcc008a6c2&imgtype=0&src=http%3A%2F%2Fpic2.16pic.com%2F00%2F07%2F66%2F16pic_766297_b.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ];
          },
          body: ListView(
            children: <Widget>[
              Container(
                color: Colors.red,
                height: 100,
                child: ListTile(
                  title: Text("List___"),
                ),
              ),
              Container(
                color: Colors.red,
                height: 100,
                child: ListTile(
                  title: Text("List___"),
                ),
              ),Container(
                color: Colors.red,
                height: 100,
                child: ListTile(
                  title: Text("List___"),
                ),
              ),Container(
                color: Colors.red,
                height: 100,
                child: ListTile(
                  title: Text("List___"),
                ),
              ),Container(
                color: Colors.red,
                height: 100,
                child: ListTile(
                  title: Text("List___"),
                ),
              ),Container(
                color: Colors.red,
                height: 100,
                child: ListTile(
                  title: Text("List___"),
                ),
              ),Container(
                color: Colors.red,
                height: 100,
                child: ListTile(
                  title: Text("List___"),
                ),
              ),Container(
                color: Colors.red,
                height: 100,
                child: ListTile(
                  title: Text("List___"),
                ),
              ),Container(
                color: Colors.red,
                height: 100,
                child: ListTile(
                  title: Text("List___"),
                ),
              ),Container(
                color: Colors.red,
                height: 100,
                child: ListTile(
                  title: Text("List___"),
                ),
              ),Container(
                color: Colors.red,
                height: 100,
                child: ListTile(
                  title: Text("List___"),
                ),
              ),Container(
                color: Colors.red,
                height: 100,
                child: ListTile(
                  title: Text("List___"),
                ),
              ),Container(
                color: Colors.red,
                height: 100,
                child: ListTile(
                  title: Text("List___"),
                ),
              ),
            ],
          )),
    );
  }

//  Column(
//  children: <Widget>[
//  Container(
//  height: 160,
//  child: Swiper(
////          viewportFraction: 0.8,
////          scale: 0.9,
//  //     itemWidth、layout 结合使用
//  itemWidth: 300,
//  layout: SwiperLayout.STACK,
//  onTap: (index) {
//  print("${index}");
//  },
//  autoplay: true,
//  itemBuilder: (BuildContext context, int index) {
//  return _getBanner(index);
//  },
//  itemCount: 3,
//  pagination: new SwiperPagination(),
//  control: new SwiperControl(
//  size: 20, iconPrevious: null, iconNext: null),
//  ),
//  ),
//  TextWidegt(textKey),
//  RaisedButton(onPressed: () {
//  tv++;
//  textKey.currentState.onPressed(tv);
//  })
//  ],
//  )
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
