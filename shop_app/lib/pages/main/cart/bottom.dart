import 'package:provide/provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/config/index.dart';
import '../../../core/states/cart.dart';
import '../../../core/models/cart.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: ColorMap.colorfff,
        border: Border(
          top: BorderSide(width: 1, color: ColorMap.defaultBorder),
          bottom: BorderSide(width: 1, color: ColorMap.defaultBorder),
        ),
      ),
      child: Provide<CartState>(
        builder: (BuildContext context, child, cart) => Row(
              children: <Widget>[
                _selectAll(context),
                _allPrice(context),
                _goBtn(context)
              ],
            ),
      ),
    );
  }

  // 全选按钮
  Widget _selectAll(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Row(
        children: <Widget>[
          Checkbox(
            value: Provide.value<CartState>(context).allSelect,
            activeColor: ColorMap.primary,
            onChanged: (bool val) {
              Provide.value<CartState>(context).changeAllSelect(val);
            },
          ),
          Text(
            StringMap.allSelect,
            style: TextStyle(fontSize: ScreenUtil().setSp(24)),
          ),
        ],
      ),
    );
  }

  // 合计价格
  Widget _allPrice(BuildContext context) {
    String _price =
        Provide.value<CartState>(context).totalPrice.toStringAsFixed(2);
    return Container(
      width: ScreenUtil().setWidth(445),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              '${StringMap.totalPrice + _price}',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                color: double.parse(_price) == 0
                    ? ColorMap.priceDark
                    : ColorMap.priceText,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              StringMap.cartTips,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(18),
                color: ColorMap.tipsText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 结算按钮
  Widget _goBtn(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      height: ScreenUtil().setHeight(65),
      padding: EdgeInsets.only(left: 10, right: 5),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorMap.primary,
            borderRadius: BorderRadius.circular(5)
          ),
          child: Text(
            '结算 (${Provide.value<CartState>(context).totalCount})',
            style: TextStyle(
              color: ColorMap.colorfff,
              fontSize: ScreenUtil().setSp(22)
            ),
          ),
        ),
      ),
    );
  }
}
