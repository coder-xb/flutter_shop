import 'package:provide/provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/config/index.dart'; // 配置信息
import '../../../core/states/tabs.dart'; // 状态管理
import '../../../core/states/cart.dart'; // 状态管理
import '../../../core/states/detail.dart'; // 状态管理

class DetailBotBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      color: ColorMap.colorfff,
      height: ScreenUtil().setHeight(80),
      child: Row(
        children: <Widget>[
          _cartIcon(context),
          _addToCart(context),
          _buyBtn(context),
        ],
      ),
    );
  }

  // 购物车图标
  Widget _cartIcon(BuildContext context) {
    return Stack(
      children: <Widget>[
        InkWell(
          onTap: () {
            // 跳转到购物车界面
            Provide.value<TabIndex>(context).changeIndex(2);
            Navigator.pop(context);
          },
          child: Container(
            width: ScreenUtil().setWidth(120),
            alignment: Alignment.center,
            child: Icon(
              Icons.shopping_cart,
              size: 35,
              color: ColorMap.priceText,
            ),
          ),
        ),
        // 购物车里的商品数量
        Provide<CartState>(
          builder: (context, child, val) {
            return Positioned(
              top: 5,
              right: 15,
              child: Container(
                padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
                decoration: BoxDecoration(
                  color: ColorMap.primary,
                  border: Border.all(width: 2, color: ColorMap.colorfff),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '${Provide.value<CartState>(context).totalCount}',
                  style: TextStyle(
                    color: ColorMap.colorfff,
                    fontSize: ScreenUtil().setSp(20),
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  // 加入购物车按钮
  Widget _addToCart(BuildContext context) {
    var goodsInfo = Provide.value<DetailState>(context).goodsInfo.info;
    return InkWell(
      onTap: () {
        // 添加购物车
        Provide.value<CartState>(context).addToCart(
            goodsInfo.id, goodsInfo.img, goodsInfo.name, 1, goodsInfo.price);
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(310),
        height: ScreenUtil().setHeight(80),
        color: ColorMap.addToCart,
        child: Text(
          StringMap.addToCart,
          style: TextStyle(
            color: ColorMap.colorfff,
            fontSize: ScreenUtil().setSp(28),
          ),
        ),
      ),
    );
  }

  // 加入购物车按钮
  Widget _buyBtn(BuildContext context) {
    return InkWell(
      onTap: () async {
        // TODO 立即购买
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(320),
        height: ScreenUtil().setHeight(80),
        color: ColorMap.primary,
        child: Text(
          StringMap.buyBtn,
          style: TextStyle(
            color: ColorMap.colorfff,
            fontSize: ScreenUtil().setSp(28),
          ),
        ),
      ),
    );
  }
}
