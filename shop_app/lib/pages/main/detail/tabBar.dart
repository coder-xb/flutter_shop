import 'package:provide/provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/config/index.dart'; // 配置信息
import '../../../core/states/detail.dart'; // 状态管理

// 商品详情页 - 选项卡
class DetailTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailState>(
      builder: (BuildContext context, child, val) {
        bool tabDetail = Provide.value<DetailState>(context).tabDetail;
        bool tabComment = Provide.value<DetailState>(context).tabComment;
        return Container(
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 1,
                color: ColorMap.defaultBorder,
              ),
            ),
          ),
          child: Row(
            children: <Widget>[
              _tabDetail(context, tabDetail),
              _tabComment(context, tabComment)
            ],
          ),
        );
      },
    );
  }

  Widget _tabDetail(BuildContext context, bool detail) {
    return InkWell(
      onTap: () {
        Provide.value<DetailState>(context).changTabBar('detail');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: ColorMap.colorfff,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: detail ? ColorMap.detailText : ColorMap.defaultBorder,
            ),
          ),
        ),
        child: Text(
          StringMap.detailTabLeft,
          style: TextStyle(color: detail ? ColorMap.detailText : Colors.black),
        ),
      ),
    );
  }

  Widget _tabComment(BuildContext context, bool comment) {
    return InkWell(
      onTap: () {
        Provide.value<DetailState>(context).changTabBar('comment');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: ColorMap.colorfff,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: comment ? ColorMap.detailText : ColorMap.defaultBorder,
            ),
          ),
        ),
        child: Text(
          StringMap.detailTabRight,
          style: TextStyle(
            color: comment ? ColorMap.detailText : Colors.black,
          ),
        ),
      ),
    );
  }
}
