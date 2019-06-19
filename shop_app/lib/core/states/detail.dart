import 'package:flutter/material.dart';

import '../service/http.dart';
import '../models/detail.dart';

// 商品详情页状态管理
class DetailState with ChangeNotifier {
  DetailModel goodsInfo = DetailModel();
  bool tabDetail = true;
  bool tabComment = false;

  // 获取商品详情
  Future getInfo(String id) async {
    await $http('POST', 'detail', data: {'id': id}).then((res) {
      goodsInfo = DetailModel.fromJson(res.data);
      notifyListeners();
    });
  }

  // 改变tabBar的状态
  void changTabBar(String state) {
    tabDetail = state == 'detail'; // 详情
    tabComment = state == 'comment'; // 评论
    notifyListeners();
  }

}
