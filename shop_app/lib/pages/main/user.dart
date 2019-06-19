import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/config/index.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringMap.userPage),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          _topArea(),
          _orderTitle(),
          _orderType(),
          _actionList()
        ],
      ),
    );
  }

  // 头像区域
  Widget _topArea() {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color: ColorMap.primary,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            child: ClipOval(
              child: SizedBox(
                width: ScreenUtil().setWidth(200),
                height: ScreenUtil().setHeight(200),
                child: Image.asset(
                  'assets/images/avatar.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              'APP',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(36),
                color: ColorMap.colorfff,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 我的订单
  Widget _orderTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: ScreenUtil().setWidth(750),
      decoration: BoxDecoration(
        color: ColorMap.colorfff,
        border: Border(
          top: BorderSide(
            width: 1,
            color: ColorMap.defaultBorder,
          ),
          bottom: BorderSide(
            width: 1,
            color: ColorMap.defaultBorder,
          ),
        ),
      ),
      child: ListTile(
        leading: Icon(
          Icons.list,
          size: 30,
        ),
        title: Text(StringMap.myOrder),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
      ),
    );
  }

  // 订单类型
  Widget _orderType() {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: ColorMap.colorfff,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: ColorMap.defaultBorder,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(180),
            child: Column(
              children: <Widget>[
                Icon(Icons.payment, size: 30),
                Text(StringMap.waitPay)
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(180),
            child: Column(
              children: <Widget>[
                Icon(Icons.local_shipping, size: 30),
                Text(StringMap.waitSend)
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(180),
            child: Column(
              children: <Widget>[
                Icon(Icons.local_mall, size: 30),
                Text(StringMap.waitRecive)
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(180),
            child: Column(
              children: <Widget>[
                Icon(Icons.message, size: 30),
                Text(StringMap.waitComment)
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 更多操作
  Widget _actionList() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: ColorMap.colorfff,
        border: Border(
          top: BorderSide(
            width: 1,
            color: ColorMap.defaultBorder,
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          _myList('领取优惠券', Icons.local_offer),
          _myList('已领取优惠券', Icons.loyalty),
          _myList('地址管理', Icons.not_listed_location),
          _myList('客户管理', Icons.room_service),
          _myList('关于我们', Icons.account_box),
        ],
      ),
    );
  }

  Widget _myList(String title, IconData icon) {
    return Container(
      width: ScreenUtil().setWidth(750),
      decoration: BoxDecoration(
        color: ColorMap.colorfff,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: ColorMap.defaultBorder,
          ),
        ),
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
      ),
    );
  }
}
