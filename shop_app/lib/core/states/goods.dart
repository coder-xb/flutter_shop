import 'package:flutter/material.dart';
import '../models/goods.dart';

// 分类商品列表数据
class GoodsState with ChangeNotifier {
  List<GoodsModel> goodsList = [];

  // 获取
  void getGoodsList(List<GoodsModel> list) {
    goodsList = list;
    notifyListeners();
  }
  // 上拉加载更多
  void addGoodsList(List<GoodsModel> list) {
    goodsList.addAll(list);
    notifyListeners();
  }
}
