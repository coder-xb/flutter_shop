import 'package:provide/provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/config/index.dart';
import '../../core/service/http.dart';
import '../../core/models/types.dart'; // 引入数据模型
import '../../core/states/types.dart'; // 引入状态管理
import '../../core/models/goods.dart'; // 引入数据模型
import '../../core/states/goods.dart'; // 引入状态管理
import '../../core/routers/index.dart';

// 分类页
class TypePage extends StatefulWidget {
  @override
  _TypeState createState() => _TypeState();
}

class _TypeState extends State<TypePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(StringMap.typeTitle), centerTitle: true),
      body: Container(
        child: Row(
          children: <Widget>[
            _LeftNavType(),
            Column(
              children: <Widget>[
                _RightType(),
                _GoodsList(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// 左侧分类导航
class _LeftNavType extends StatefulWidget {
  @override
  _LeftNavState createState() => _LeftNavState();
}

class _LeftNavState extends State<_LeftNavType> {
  List<TypeModel> typeList = List<TypeModel>();
  int typeIndex = 0; // 索引值

  @override
  void initState() {
    super.initState();
    _getTypes();
  }

  // 获取分类标签数据
  void _getTypes() async {
    await $http('POST', 'types').then((res) {
      if (res.data != null) {
        List<TypeModel> data = List<TypeModel>();
        res.data.forEach((v) {
          data.add(TypeModel.fromJson(v));
        });
        setState(() {
          typeList = data;
        });
        Provide.value<TypeState>(context).getSubType(typeList[0].data, 4);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provide<TypeState>(
      builder: (context, child, val) {
        // TODO 根据分类获取商品列表
        _getGoodsList(context);
        typeIndex = val.preTypeIndex;
        return Container(
          width: ScreenUtil().setWidth(140),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(width: 1, color: ColorMap.defaultBorder),
            ),
          ),
          child: ListView.builder(
            itemCount: typeList.length,
            itemBuilder: (context, index) {
              return _leftTypes(index);
            },
          ),
        );
      },
    );
  }

  // 构建左侧分类类别子项
  Widget _leftTypes(int index) {
    bool isClick = index == typeIndex;

    return InkWell(
      onTap: () {
        int preTypeId = typeList[index].id;
        List<TypeData> subTypeList = typeList[index].data;
        Provide.value<TypeState>(context).changePreType(preTypeId, index);
        Provide.value<TypeState>(context).getSubType(subTypeList, preTypeId);
        // TODO 根据分类获取商品列表
        _getGoodsList(context, id: preTypeId);
      },
      child: Container(
        height: ScreenUtil().setHeight(65),
        padding: EdgeInsets.only(left: 15, top: 13),
        decoration: BoxDecoration(
          color: isClick ? ColorMap.isClick : ColorMap.colorfff,
          border: Border(
            bottom: BorderSide(width: 1, color: ColorMap.defaultBorder),
            left: BorderSide(
              width: 2,
              color: isClick ? ColorMap.primary : ColorMap.colorfff,
            ),
          ),
        ),
        child: Text(
          typeList[index].name,
          style: TextStyle(
            color: isClick ? ColorMap.primary : Colors.black,
            fontSize: ScreenUtil().setSp(24),
          ),
        ),
      ),
    );
  }

  void _getGoodsList(BuildContext context, {int id}) async {
    Map<String, int> data = {
      'preId': id == null ? Provide.value<TypeState>(context).preTypeId : id,
      'id': Provide.value<TypeState>(context).subTypeId,
      'page': 1
    };

    await $http('POST', 'goods', data: data).then((res) {
      if (res.data != null) {
        List<GoodsModel> resData = List<GoodsModel>();
        res.data.forEach((v) {
          resData.add(GoodsModel.fromJson(v));
        });
        Provide.value<GoodsState>(context).getGoodsList(resData);
      } else
        Provide.value<GoodsState>(context).getGoodsList([]);
    });
  }
}

// 右侧子分类选项卡
class _RightType extends StatefulWidget {
  @override
  _RightState createState() => _RightState();
}

class _RightState extends State<_RightType> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provide<TypeState>(
        builder: (context, child, state) => Container(
              height: ScreenUtil().setHeight(65),
              width: ScreenUtil().setWidth(610),
              decoration: BoxDecoration(
                color: ColorMap.colorfff,
                border: Border(
                  bottom: BorderSide(width: 1, color: ColorMap.defaultBorder),
                ),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.subTypeList.length,
                itemBuilder: (context, index) {
                  return _rightTypes(index, state.subTypeList[index]);
                },
              ),
            ),
      ),
    );
  }

  // 构建左侧分类类别子项
  Widget _rightTypes(int index, TypeData item) {
    bool isClick = index == Provide.value<TypeState>(context).subTypeIndex;

    return InkWell(
      onTap: () {
        Provide.value<TypeState>(context).changeSubIndex(item.id, index);
        // TODO 根据分类获取商品列表
        _getGoodsList(context, id: item.id);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 13, 15, 0),
        child: Text(
          item.name,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: isClick ? ColorMap.primary : Colors.black),
        ),
      ),
    );
  }

  // 获取商品列表
  void _getGoodsList(BuildContext context, {int id}) async {
    Map<String, int> data = {
      'preId': id == null ? Provide.value<TypeState>(context).preTypeId : id,
      'id': id,
      'page': 1
    };

    await $http('POST', 'goods', data: data).then((res) {
      if (res.data != null) {
        List<GoodsModel> resData = List<GoodsModel>();
        res.data.forEach((v) {
          resData.add(GoodsModel.fromJson(v));
        });
        Provide.value<GoodsState>(context).getGoodsList(resData);
      } else
        Provide.value<GoodsState>(context).getGoodsList([]);
    });
  }
}

// 分类商品列表
class _GoodsList extends StatefulWidget {
  @override
  _GoodState createState() => _GoodState();
}

class _GoodState extends State<_GoodsList> {
  var _scrollController = ScrollController(); // 滚动控制器
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  @override
  Widget build(BuildContext context) {
    return Provide<GoodsState>(
      builder: (BuildContext context, child, data) {
        try {
          // 分类切换时滚动条归0
          if (Provide.value<TypeState>(context).page == 1) {
            _scrollController.jumpTo(0);
          }
        } catch (e) {
          print('进入页面第一次初始化ERROR:$e');
        }

        if (data.goodsList.length != 0) {
          return Expanded(
            child: Container(
              width: ScreenUtil().setWidth(610),
              child: EasyRefresh(
                refreshFooter: ClassicsFooter(
                  key: _footerKey,
                  bgColor: ColorMap.colorfff, // 刷新时背景色
                  textColor: ColorMap.refreshText, // 刷新时字体颜色
                  moreInfoColor: ColorMap.refreshText, // 更多数据的字体颜色
                  showMore: true, // 是否显示更多
                  noMoreText: Provide.value<TypeState>(context)
                      .noMoreText, // 没有更多数据时显示的文本
                  loadText: StringMap.loadMore,
                  loadReadyText: StringMap.loadReady,
                  loadingText: StringMap.loadText,
                  loadedText: StringMap.loadOver,
                ),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: data.goodsList.length,
                  itemBuilder: (BuildContext context, index) =>
                      _listItem(data.goodsList, index),
                ),
                loadMore: () async {
                  if (Provide.value<TypeState>(context).noMoreText ==
                      StringMap.noMore) {
                    Fluttertoast.showToast(
                      msg: StringMap.toBottom,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIos: 1,
                      backgroundColor: ColorMap.refreshText,
                      textColor: ColorMap.colorfff,
                      fontSize: 16,
                    );
                  } else {
                    _getMoreGoods(context);
                  }
                },
              ),
            ),
          );
        } else {
          return Text(StringMap.noMoreData);
        }
      },
    );
  }

  // 上拉加载更多数据
  void _getMoreGoods(BuildContext context) async {
    Provide.value<TypeState>(context).addPage();
    Map<String, int> data = {
      'preId': Provide.value<TypeState>(context).preTypeId,
      'id': Provide.value<TypeState>(context).subTypeId,
      'page': Provide.value<TypeState>(context).page
    };

    await $http('POST', 'goods', data: data).then((res) {
      if (res.data != null) {
        List<GoodsModel> resData = List<GoodsModel>();
        res.data.forEach((v) {
          resData.add(GoodsModel.fromJson(v));
        });
        Provide.value<GoodsState>(context).addGoodsList(resData);
      } else
        Provide.value<TypeState>(context).changeNoMore(StringMap.noMore);
    });
  }

  // 商品列表
  Widget _listItem(List<GoodsModel> list, int index) {
    return InkWell(
      onTap: () {
        // TODO 跳转到详情页
        AppRouter.router.navigateTo(context, '/detail?id=${list[index].id}');
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: ColorMap.defaultBorder),
          ),
          color: ColorMap.colorfff,
        ),
        child: Row(
          children: <Widget>[
            _goodsImg(list, index),
            Column(
              children: <Widget>[
                _goodsName(list, index),
                _goodsPrice(list, index),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 商品图片
  Widget _goodsImg(List<GoodsModel> list, int index) {
    return Container(
      width: ScreenUtil().setWidth(140),
      height: ScreenUtil().setHeight(140),
      child: Image.network(list[index].img, fit: BoxFit.cover),
    );
  }

  // 商品名称
  Widget _goodsName(List<GoodsModel> list, int index) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 5, 10, 5),
      width: ScreenUtil().setWidth(450),
      child: Text(
        list[index].title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  // 商品价格
  Widget _goodsPrice(List<GoodsModel> list, int index) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 5, 10, 5),
      width: ScreenUtil().setWidth(450),
      child: Row(
        children: <Widget>[
          Text(
            '价格：￥${list[index].price}',
            style: TextStyle(color: ColorMap.priceText),
          ),
          Text(
            ' ￥${list[index].oriPrice}',
            style: FontMap.oriPriceStyle,
          )
        ],
      ),
    );
  }
}
