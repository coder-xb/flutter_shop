import 'package:provide/provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/config/index.dart';
import '../../../core/states/detail.dart';

import './topArea.dart';
import './explain.dart';
import './tabBar.dart';
import './detail.dart';
import './bottom.dart';

class DetailPage extends StatelessWidget {
  final String id;
  DetailPage(this.id);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            StringMap.detailTitle,
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: _getInfo(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      DetailTopArea(),
                      DetailExplain(),
                      DetailTabBar(),
                      DetailWeb(),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: ScreenUtil().setHeight(80),
                    child: DetailBotBar(),
                  )
                ],
              );
            } else {
              return Center(child: Text(StringMap.loadText));
            }
          },
        ),
      ),
    );
  }

  // 获取商品详情
  Future _getInfo(BuildContext context) async {
    await Provide.value<DetailState>(context).getInfo(id);
    return '';
  }
}
