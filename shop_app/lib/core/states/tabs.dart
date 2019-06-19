import 'package:flutter/material.dart';

// 底部通用导航栏状态管理
class TabIndex with ChangeNotifier {
  int curTabIndex = 0;
  void changeIndex(int index) {
    curTabIndex = index;
    notifyListeners();
  }
}
