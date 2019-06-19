import 'package:provide/provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/config/index.dart';
import '../../../core/states/cart.dart';
import '../../../core/models/cart.dart';

class CartCount extends StatelessWidget {
  final CartModel item;
  CartCount(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(183),
      height: ScreenUtil().setHeight(45),
      margin: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: ColorMap.defaultBorder),
      ),
      child: Row(
        children: <Widget>[
          _minBtn(context),
          _numShow(context),
          _addBtn(context)
        ],
      ),
    );
  }

  // 减少按钮
  Widget _minBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        Provide.value<CartState>(context).countControll(item, -1);
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: item.count > 1 ? ColorMap.colorfff : ColorMap.defaultBorder,
          border: Border(
            right: BorderSide(width: 1, color: ColorMap.defaultBorder),
          ),
        ),
        child: Icon(Icons.remove),
      ),
    );
  }

  // 增加按钮
  Widget _addBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        Provide.value<CartState>(context).countControll(item, 1);
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ColorMap.colorfff,
          border: Border(
            left: BorderSide(width: 1, color: ColorMap.defaultBorder),
          ),
        ),
        child: Icon(Icons.add),
      ),
    );
  }

  // 数字区域
  Widget _numShow(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      child: Text('${item.count}'),
    );
  }
}
