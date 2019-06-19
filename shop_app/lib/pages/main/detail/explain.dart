import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/config/index.dart'; // 配置信息

// 商品详情页 - 说明
class DetailExplain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ColorMap.colorfff,
        border: Border(
          top: BorderSide(width: 1, color: ColorMap.defaultBorder),
          bottom: BorderSide(width: 1, color: ColorMap.defaultBorder)
        ),
      ),
      width: ScreenUtil().setWidth(750),
      child: Text(
        StringMap.detailExplain,
        style: TextStyle(
          color: ColorMap.priceText,
          fontSize: ScreenUtil().setSp(28)
        ),
      ),
    );
  }
}
