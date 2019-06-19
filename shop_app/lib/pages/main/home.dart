import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/states/tabs.dart';
import '../../core/config/index.dart';
import '../../core/service/http.dart';
import '../../core/models/types.dart';
import '../../core/states/types.dart';
import '../../core/routers/index.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();
  // 防止刷新处理，保持当前状态
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    _getHotGoods(false); // 加载第1页火爆专区的数据
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorMap.mainBg,
      appBar: AppBar(title: Text(StringMap.homeTitle), centerTitle: true),
      body: FutureBuilder(
        future: $http('POST', 'home'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ApiResponse response = snapshot.data;
            List<Map<String, dynamic>> swiperList =
                (response.data['banner'] as List).cast(); // 轮播图数据
            List<Map<String, dynamic>> typeList =
                (response.data['category'] as List).cast(); // 分类按钮数据
            List<Map<String, dynamic>> recommend =
                (response.data['recommend'] as List).cast(); // 推荐商品数据
            List<Map<String, dynamic>> floorList =
                (response.data['floors'] as List).cast(); // 底部推荐商品数据
            Map<String, dynamic> advert = response.data['advert']; // 广告数据

            return EasyRefresh(
              refreshFooter: ClassicsFooter(
                key: _footerKey,
                bgColor: ColorMap.mainBg, // 刷新时背景色
                textColor: ColorMap.refreshText, // 刷新时字体颜色
                moreInfoColor: ColorMap.refreshText, // 更多数据的字体颜色
                showMore: true, // 是否显示更多
                noMoreText: '', // 没有更多数据时显示的文本
                loadText: StringMap.loadMore,
                loadReadyText: StringMap.loadReady,
                loadingText: StringMap.loadText,
                loadedText: StringMap.loadOver,
              ),
              child: ListView(
                children: <Widget>[
                  _SwiperInit(list: swiperList),
                  _TypeNavigator(list: typeList),
                  _Recommend(list: recommend),
                  _AdvPic(advert: advert),
                  _Floor(list: floorList),
                  _hotGoods()
                ],
              ),
              loadMore: () async {
                _getHotGoods(true);
              },
            );
          } else {
            return Center(child: Text(StringMap.loadText));
          }
        },
      ),
    );
  }



  // 获取火爆商品数据
  int page = 1;
  List<Map<String, dynamic>> hotGoods = [];
  void _getHotGoods(bool update) {
    $http('POST', 'hots', data: {'page': page}).then((res) {
      List<Map<String, dynamic>> lists = (res.data as List).cast();
      hotGoods.addAll(lists);
      page++;
      // 刷新界面
      if (update) setState(() {});
    });
  }

  // 火爆专区标题
  Widget _hotTitle = Container(
    margin: EdgeInsets.only(top: 10),
    padding: EdgeInsets.all(5),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: ColorMap.colorfff,
      border:
          Border(bottom: BorderSide(width: .5, color: ColorMap.defaultBorder)),
    ),
    child: Text(
      StringMap.hotGoods,
      style: TextStyle(color: ColorMap.homeSubTitle),
    ),
  );

  // 火爆专区子项
  Widget _hotGoodsList() {
    if (hotGoods.length != 0) {
      List<Widget> _listItem = hotGoods
          .map((val) => InkWell(
                onTap: () {
                  AppRouter.router.navigateTo(context, '/detail?id=${val['id']}');
                },
                child: Container(
                  width: ScreenUtil().setWidth(372),
                  color: ColorMap.colorfff,
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(bottom: 5),
                  child: Column(
                    children: <Widget>[
                      Image.network(
                        val['img'],
                        width: ScreenUtil().setWidth(375),
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        val['title'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: ScreenUtil().setSp(26)),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '￥${val['price']}',
                            style: TextStyle(color: ColorMap.priceText),
                          ),
                          Text(
                            '￥${val['oriPrice']}',
                            style: FontMap.oriPriceStyle,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ))
          .toList();

      return Wrap(
        spacing: 2,
        children: _listItem,
      );
    }
    return Text('');
  }

  // 火爆专区组件整合
  Widget _hotGoods() {
    return Container(
      child: Column(
        children: <Widget>[_hotTitle, _hotGoodsList()],
      ),
    );
  }
}

// 轮播组件
class _SwiperInit extends StatelessWidget {
  final List<Map> list;
  _SwiperInit({Key key, @required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorMap.colorfff,
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(340),
      child: Swiper(
        itemCount: list.length,
        pagination: SwiperPagination(),
        autoplay: true,
        autoplayDelay: 3000,
        itemBuilder: (BuildContext context, int index) => InkWell(
              onTap: () {
                AppRouter.router.navigateTo(context, '/detail?id=${list[index]['id']}');
              },
              child: Image.network('${list[index]['img']}', fit: BoxFit.cover),
            ),
      ),
    );
  }
}

// 分类选项组件
class _TypeNavigator extends StatelessWidget {
  final List<Map> list;
  _TypeNavigator({Key key, @required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (list.length > 10) list.removeRange(10, list.length);
    int index = -1;
    return Container(
      color: ColorMap.colorfff,
      padding: EdgeInsets.only(top: 10),
      height: ScreenUtil().setHeight(300),
      child: GridView.count(
        crossAxisCount: 5, // 2行5列
        padding: EdgeInsets.all(4),
        physics: NeverScrollableScrollPhysics(), // 禁止滚动
        children: list.map((item) {
          index++;
          return _buildItem(context, item, index);
        }).toList(),
      ),
    );
  }

  Widget _buildItem(BuildContext context, item, index) {
    return InkWell(
      onTap: () {
        // TODO 跳转到分类页并标记对应分类选项
        _toTypePage(context, index, item['id']);
      },
      child: Column(
        children: <Widget>[
          Image.network(item['img'], width: ScreenUtil().setWidth(90)),
          Text(item['name'])
        ],
      ),
    );
  }

  void _toTypePage(BuildContext context, int index, int id) async {
    await $http('POST', 'types').then((res) {
      List<TypeModel> data = List<TypeModel>();
      res.data.forEach((v) {
        data.add(TypeModel.fromJson(v));
      });
      Provide.value<TypeState>(context).changePreType(id, index);
      Provide.value<TypeState>(context).getSubType(data[index].data, id);
      Provide.value<TabIndex>(context).changeIndex(1);
    });
  }
}

// 推荐商品
class _Recommend extends StatelessWidget {
  final List<Map> list;
  _Recommend({Key key, @required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[_title(), _listUI(context)],
      ),
    );
  }

  // 推荐商品主标题
  Widget _title() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(15, 8, 0, 8),
      decoration: BoxDecoration(
        color: ColorMap.colorfff,
        border: Border(
            bottom: BorderSide(width: .5, color: ColorMap.defaultBorder)),
      ),
      child: Text(
        StringMap.recommend, // 推荐商品
        style: TextStyle(color: ColorMap.homeSubTitle),
      ),
    );
  }

  // 推荐商品列表
  Widget _listUI(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(280),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) => _listItem(context, index),
      ),
    );
  }

  // 推荐商品列表项
  Widget _listItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        AppRouter.router.navigateTo(context, '/detail?id=${list[index]['id']}');
      },
      child: Container(
        width: ScreenUtil().setWidth(280),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ColorMap.colorfff,
          border: Border(
              left: BorderSide(width: .5, color: ColorMap.defaultBorder)),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Image.network(list[index]['img'], fit: BoxFit.contain),
            ),
            Text(
              '￥${list[index]['price']}',
              style: TextStyle(color: ColorMap.priceText),
            ),
            Text(
              '￥${list[index]['oriPrice']}',
              style: FontMap.oriPriceStyle,
            )
          ],
        ),
      ),
    );
  }
}

// 广告位
class _AdvPic extends StatelessWidget {
  final Map<String, dynamic> advert;
  _AdvPic({Key key, @required this.advert}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: InkWell(child: Image.network(advert['img'])),
    );
  }
}

// 商品推荐底部
class _Floor extends StatelessWidget {
  final List<Map> list;
  _Floor({Key key, @required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // 左侧
          Expanded(
            child: Column(
              children: <Widget>[
                // 左上
                Container(
                  height: ScreenUtil().setHeight(400),
                  child: InkWell(
                    onTap: () {
                      AppRouter.router.navigateTo(context, '/detail?id=${list[0]['id']}');
                    }, // 跳转到详情
                    child: Image.network(list[0]['img'], fit: BoxFit.cover),
                  ),
                ),
                // 左下
                Container(
                  height: ScreenUtil().setHeight(200),
                  child: InkWell(
                    onTap: () {
                      AppRouter.router.navigateTo(context, '/detail?id=${list[1]['id']}');
                    }, // 跳转到详情
                    child: Image.network(list[1]['img'], fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
          ),
          // 右侧
          Expanded(
            child: Column(
              children: <Widget>[
                // 右上
                Container(
                  height: ScreenUtil().setHeight(200),
                  child: InkWell(
                    onTap: () {
                      AppRouter.router.navigateTo(context, '/detail?id=${list[2]['id']}');
                    }, // 跳转到详情
                    child: Image.network(list[2]['img'], fit: BoxFit.cover),
                  ),
                ),
                // 右
                Container(
                  height: ScreenUtil().setHeight(200),
                  child: InkWell(
                    onTap: () {
                      AppRouter.router.navigateTo(context, '/detail?id=${list[3]['id']}');
                    }, // 跳转到详情
                    child: Image.network(list[3]['img'], fit: BoxFit.cover),
                  ),
                ),
                // 右下
                Container(
                  height: ScreenUtil().setHeight(200),
                  child: InkWell(
                    onTap: () {
                      AppRouter.router.navigateTo(context, '/detail?id=${list[4]['id']}');
                    }, // 跳转到详情
                    child: Image.network(list[4]['img'], fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
