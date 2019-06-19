import 'package:provide/provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/config/index.dart';
import '../../../core/states/cart.dart';
import '../../../core/models/cart.dart';

import './count.dart';

// 购物车商品类别项
class CartItem extends StatelessWidget {
  final CartModel item;
  CartItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      decoration: BoxDecoration(
        color: ColorMap.colorfff,
        border: Border(
          bottom: BorderSide(width: 1, color: ColorMap.defaultBorder),
        ),
      ),
      child: Row(
        children: <Widget>[
          _checkBox(context, item),
          _cartImg(item),
          _cartName(item),
          _cartPrice(context, item)
        ],
      ),
    );
  }

  // 多选按钮UI
  Widget _checkBox(BuildContext context, CartModel item) {
    return Container(
      child: Checkbox(
        value: item.isSelect,
        activeColor: ColorMap.primary,
        onChanged: (bool val) {
          Provide.value<CartState>(context).changeSelect(item.id, val);
        },
      ),
    );
  }

  // 商品图片
  Widget _cartImg(CartModel item) {
    return Container(
      width: ScreenUtil().setWidth(110),
      height: ScreenUtil().setHeight(110),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: ColorMap.defaultBorder,
        ),
      ),
      child: Image.network(
        item.img,
        fit: BoxFit.cover,
      ),
    );
  }

  // 商品名称
  Widget _cartName(CartModel item) {
    return Container(
      width: ScreenUtil().setWidth(400),
      height: ScreenUtil().setHeight(120),
      padding: EdgeInsets.only(top: 5, left: 10, right: 10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(
            item.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: CartCount(item),
          )
        ],
      ),
    );
  }

  // 商品价格
  Widget _cartPrice(BuildContext context, CartModel item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text(
            '￥${item.price}',
            style: TextStyle(
              color: ColorMap.priceText,
              fontSize: ScreenUtil().setSp(24),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5),
            child: InkWell(
              onTap: () {
                Provide.value<CartState>(context).delAGoods(item.id);
              },
              child: Icon(
                Icons.delete_forever,
                color: ColorMap.delIcon,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}
