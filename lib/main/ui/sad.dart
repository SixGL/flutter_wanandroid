//class TabsDemo extends StatelessWidget {
//  static const String routeName = '/material/tabs';
//
//  @override
//  Widget build(BuildContext context) {
//    return new DefaultTabController(
//      length: _allPages.length,
//      child: new Scaffold(
//        body: new NestedScrollView(
//          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//            return <Widget>[
//              new SliverOverlapAbsorber(
//                handle:
//                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
//                child: new SliverAppBar(
//                  pinned: true,
//                  expandedHeight: 300.0,
//                  // 这个高度必须比flexibleSpace高度大
//                  forceElevated: innerBoxIsScrolled,
//                  bottom: PreferredSize(
//                      child: new Container(
//                        child: new TabBar(
//                          tabs: _allPages.keys
//                              .map(
//                                (_Page page) => new Tab(
//                                  child: new Tab(text: page.label),
//                                ),
//                              )
//                              .toList(),
//                        ),
//                        color: Colors.redAccent[200],
//                      ),
//                      preferredSize: new Size(double.infinity, 46.0)),
//                  // 46.0为TabBar的高度，也就是tabs.dart中的_kTabHeight值，因为flutter不支持反射所以暂时没法通过代码获取
//                  flexibleSpace: new Container(
//                    child: new Column(
//                      children: <Widget>[
//                        new AppBar(
//                          title: Text("this is title"),
//                        ),
//                        new Expanded(
//                          child: new Container(
//                            child: Image.asset(
//                              "images/test.jpg",
//                              repeat: ImageRepeat.repeat,
//                            ),
//                            width: double.infinity,
//                          ),
//                        )
//                      ],
//                    ),
//                  ),
//                ),
//              ),
//            ];
//          },
//          body: new TabBarView(
//            children: _allPages.keys.map((_Page page) {
//              return new SafeArea(
//                top: false,
//                bottom: false,
//                child: new Builder(
//                  builder: (BuildContext context) {
//                    return new CustomScrollView(
//                      key: new PageStorageKey<_Page>(page),
//                      slivers: <Widget>[
//                        new SliverOverlapInjector(
//                          handle:
//                              NestedScrollView.sliverOverlapAbsorberHandleFor(
//                                  context),
//                        ),
//                        new SliverPadding(
//                          padding: const EdgeInsets.symmetric(
//                            vertical: 8.0,
//                            horizontal: 16.0,
//                          ),
//                          sliver: new SliverFixedExtentList(
//                            itemExtent: _CardDataItem.height,
//                            delegate: new SliverChildBuilderDelegate(
//                              (BuildContext context, int index) {
//                                final _CardData data = _allPages[index];
//                                return new Padding(
//                                  padding: const EdgeInsets.symmetric(
//                                    vertical: 8.0,
//                                  ),
//                                  child: new _CardDataItem(
//                                    page: page,
//                                    data: data,
//                                  ),
//                                );
//                              },
//                              childCount: _allPages.length,
//                            ),
//                          ),
//                        ),
//                      ],
//                    );
//                  },
//                ),
//              );
//            }).toList(),
//          ),
//        ),
//      ),
//    );
//  }
//}
