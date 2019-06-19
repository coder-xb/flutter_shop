import 'package:provide/provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/config/index.dart'; // 配置信息
import '../../../core/states/detail.dart'; // 状态管理

class DetailWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String goodsImgs =
        Provide.value<DetailState>(context).goodsInfo.info.detail;
    return Provide<DetailState>(
      builder: (BuildContext context, child, val) {
        return Provide.value<DetailState>(context).tabDetail
            ? Container(
                child: Html(
                  data: goodsImgs,
                ),
                alignment: Alignment.center,
                width: ScreenUtil().setWidth(750),
                padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(68)),
              )
            : Container(
                width: ScreenUtil().setWidth(750),
                padding: EdgeInsets.all(15),
                alignment: Alignment.center,
                child: Text(
                  '暂时没有评论数据...',
                  style: TextStyle(color: ColorMap.primary),
                ),
              );
      },
    );
  }
}
