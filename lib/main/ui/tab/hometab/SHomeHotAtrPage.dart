import 'package:first_flutter_app/entity_factory.dart';
import 'package:first_flutter_app/main/Http/SHttp.dart';
import 'package:first_flutter_app/main/Http/SLog.dart';
import 'package:first_flutter_app/main/m/atr_bean_entity.dart';
import 'package:first_flutter_app/main/m/banner_entity.dart';
import 'package:first_flutter_app/main/util/Style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeAtrContentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeAtrState();
  }
}

//AutomaticKeepAliveClientMixin 解决Tab切换状态丢失问题
class HomeAtrState extends State with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  List<AtrBeanDataData> _listAtrData = new List();
  List<BannerData> _listBannerData = new List();
  List<Widget> _listBannerWeiget = new List();

  ScrollController _toSontroller = ScrollController();

  int _curPageIndex = 0;
  int init = 0;

  // _isRefresh  _isLoad不能同时为true  为了区分是下拉刷新、上拉加载
  bool _isRefresh = false;
  bool _isLoad = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("initState   ${init++} ");
    _getData();
    _getBannerata();
    _toSontroller.addListener(() {
      if (_toSontroller.position.pixels ==
          _toSontroller.position.maxScrollExtent) {
        print("列表到达底部");
        _onLoadMore();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_toSontroller != null) {
      _toSontroller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: RefreshIndicator(
          child: ListView.builder(
              controller: _toSontroller,
              itemCount: _listAtrData.length + 1,
              // +1 是为了上拉加载时显示自定义进度条(跟实现原生多种行视图一个道理)
              itemBuilder: _getAtrItem),
          onRefresh: _onRefresh),
    );
  }

  /**
   * Listview item
   * */
  Widget _getAtrItem(BuildContext context, int index) {
    return index < _listAtrData.length ? _getItem(index) : _getLoadItem(index);
  }

  /**
   * 收藏按钮
   * */
  Widget _getStar(int index) {
    return IconButton(
        iconSize: 20,
        icon: Icon(
          Icons.star,
          color: _listAtrData[index].collect == true
              ? Color(0xfff9ed0a)
              : Color(0xffb4b4b4),
        ),
        onPressed: () {
          setState(() {
            var collect = _listAtrData[index].collect;
            if (!collect) {
              _listAtrData[index].collect = true;
            } else {
              _listAtrData[index].collect = false;
            }
            print("收藏 $collect");
          });
        });
  }

  /**
   * 每次请求数据成功 curPageIndex 自动+1
   * */
  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1), () {
      _isRefresh = true;
      _isLoad = false;
      _getData();
    });
  }

  /**
   * 每次请求数据成功 curPageIndex 自动+1
   * */
  void _onLoadMore() {
    _isRefresh = false;
    _isLoad = true;
    _getData();
  }

  /**
   * todo
   * */
  List<AtrBeanDataData> _getData() {
    HttpUtil.get("article/list/$_curPageIndex/json", success: (value) {
      AtrBeanEntity generateOBJ = EntityFactory.generateOBJ(value);
      List<AtrBeanDataData> list = generateOBJ.data.datas;
      setState(() {
        if (_curPageIndex == 0) {
          // ==0代表第一次请请求数据
          if (list != null) {
            _listAtrData.addAll(list);
          }
        }
        if (_isRefresh) {
          // _isRefresh=true  代表下拉刷新
          if (list != null) {
            list.addAll(_listAtrData);
            _listAtrData.clear();
            _listAtrData.addAll(list);
          }
        }

        if (_isLoad) {
          //上拉加载
          _listAtrData.addAll(list);
        }

        _curPageIndex++;
        return list;
      });
    }, error: (msg, code) {
      Log.i("文章列表 Error = $msg  $code");
      return null;
    });
  }

  Widget _getItem(int index) {
    return index > 0
        ? GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/Swebview',
                arguments: {
                  "title": '${_listAtrData[index].title}',
                  "link": '${_listAtrData[index].link}'
                },
              );
            },
            child: Card(
              elevation: 2,
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                children: <Widget>[
                  _getStar(index),
                  Expanded(
                      // 占满可用空间
                      child: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _getText(
                            "${_listAtrData[index].title}", 15, Stytle.C_title),
                        Row(
                          textDirection: TextDirection.ltr,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _getText("作者: ", Stytle.F12, Stytle.C_desc),
                            _getText("${_listAtrData[index].author}",
                                Stytle.F12, Stytle.C_title),
//                        _getText("   分类: ", Stytle.F12, Stytle.C_desc),
//                        _getText("${_listAtrData[index].superChapterName}",
//                            Stytle.F12, Stytle.C_title),
                            _getText("   时间: ", Stytle.F12, Stytle.C_desc),
                            _getText("${_listAtrData[index].niceDate}",
                                Stytle.F12, Stytle.C_title),
                          ],
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ))
        : Center(
            child: Container(
              constraints:
                  BoxConstraints.expand(width: double.infinity, height: 200),
              alignment: Alignment.center,
              child: Swiper(
                viewportFraction: 0.8,
                scale: 0.9,
//                     itemWidth、layout 结合使用
//                itemWidth: 300,
//                layout: SwiperLayout.STACK,
                onTap: (index) {
                  Navigator.pushNamed(
                    context,
                    '/Swebview',
                    arguments: {
                      "title": '${_listBannerData[index].title}',
                      "link": '${_listBannerData[index].url}'
                    },
                  );

                },
                autoplay: true,
                itemBuilder: (BuildContext context, int index) {
                  return _getBanner(index);
                },
                itemCount: _listBannerData.length,
                pagination: new SwiperPagination(),
                control: new SwiperControl(
                    size: 20, iconPrevious: null, iconNext: null),
              ),
            ),
          );
  }

  Widget _getText(String content, double fontsize, int color) {
    return Text(
      content,
      textAlign: TextAlign.left,
//      maxLines: 1,
//      overflow: TextOverflow.ellipsis,
      softWrap: true,
      style: TextStyle(color: Color(color), fontSize: fontsize),
    );
  }

  Widget _getLoadItem(int index) {
    return Center(
      child: Container(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Color(Stytle.C_theme)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text("正在加载..."),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getBanner(int index) {
    return _listBannerWeiget[index];
  }

  void _getBannerata() {
    HttpUtil.get("/banner/json", success: (value) {
      BannerEntity bannerEntity = EntityFactory.generateOBJ(value);
//    var data = bannerEntity.data;
      setState(() {
        _listBannerData.addAll(bannerEntity.data);
        if (_listBannerData.length > 0) {
          _listBannerData.forEach((value) {
            _listBannerWeiget.add(Image.network(
              "${value.imagePath}",
              fit: BoxFit.cover,
            ));
          });
        }
      });
    }, error: (msg, code) {
      Log.i(msg + code);
    });
  }
}

//      var map = {
//        "username": "254369045",
//        "password": "5783653",
//        "repassword": "5783653"
//      };
//      HttpUtil.post("user/lsssogin", data: {
//        "username": "1828088520",
//        "password": "5783653",
//        "repassword": "5783653"
//      }, success: (value) {
//        print("111 $value");
//      }, error: (errorMsg, code) {
//        print("___!!! $errorMsg   \n$code");
//      });
//      HttpUtil.post("user/login",data:  {"username":"1828088521","password":"5783653"});
//      HttpUtil.post("lg/collect/1165/json");
