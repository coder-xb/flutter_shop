import 'package:provide/provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/config/index.dart'; // 配置信息
import '../../../core/states/detail.dart'; // 状态管理

// 商品详情页 - 首屏区域（封面图、名称、价格、编号等UI）
class DetailTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailState>(
      builder: (BuildContext context, child, data) {
        var goodsInfo = Provide.value<DetailState>(context).goodsInfo.info;
        if (goodsInfo != null) {
          return Container(
            color: ColorMap.colorfff,
            child: Column(
              children: <Widget>[
                _goodsImage(goodsInfo.img),
                _goodsName(goodsInfo.name),
                _goodsSerialId(goodsInfo.serialId),
                _goodsPrice(goodsInfo.price, goodsInfo.oriPrice),
              ],
            ),
          );
        } else {
          return Center(child: Text(StringMap.loadText));
        }
      },
    );
  }

  // 封面图
  Widget _goodsImage(String url) {
    return Image.network(
      url,
      fit: BoxFit.fitWidth,
      width: ScreenUtil().setWidth(750),
    );
  }

  // 商品名称
  Widget _goodsName(String name) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.only(top: 5, left: 12, right: 12),
      child: Text(
        name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  // 商品编号
  Widget _goodsSerialId(String text) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.only(left: 12),
      margin: EdgeInsets.only(top: 5),
      child: Text(
        '${StringMap.detailGoodsId + text}',
        style: TextStyle(color: ColorMap.detailGoodsId),
      ),
    );
  }

  // 商品价格
  Widget _goodsPrice(double price, double oriPrice) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.only(left: 12, bottom: 10),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(width: 1, color: ColorMap.defaultBorder)),
      ),
      child: Row(
        children: <Widget>[
          Text(
            '${StringMap.price}$price ',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(30),
              color: ColorMap.priceText,
            ),
          ),
          Text(
            '${StringMap.oriPrice}$oriPrice',
            style: TextStyle(
                color: ColorMap.detailGoodsId,
                fontSize: ScreenUtil().setSp(26),
                decoration: TextDecoration.lineThrough),
          )
        ],
      ),
    );
  }
}
