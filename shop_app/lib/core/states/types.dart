import 'package:flutter/material.dart';
import '../models/types.dart';

// 分类页状态管理
class TypeState with ChangeNotifier {
  List<TypeData> subTypeList = List<TypeData>();
  int preTypeIndex = 0; // 一级分类索引
  int subTypeIndex = 0; // 二级分类索引
  int preTypeId = 0; // 一级分类ID
  int subTypeId = 0; // 二级分类ID
  int page = 1; // 列表页数
  String noMoreText = ''; // 显示更多的提示
  bool isNewType = true; // 是否切换到新的分类

  // 首页点击分类时更改分类
  void changePreType(int id, int index) {
    preTypeId = id;
    subTypeId = 0;
    preTypeIndex = index;
    notifyListeners();
  }

  // 切换子分类时更改子分类索引
  void changeSubIndex(int id, int index) {
    page = 1;
    noMoreText = '';
    isNewType = true;
    subTypeIndex = id;
    subTypeIndex = index;
    notifyListeners();
  }

  // 获取子分类标签
  void getSubType(List<TypeData> list, int id) {
    page = 1;
    noMoreText = '';
    preTypeId = id;
    subTypeId = 0; // 切换一级分类时将二级分类ID清空
    subTypeIndex = 0;
    // 附加一个'全部'分类
    TypeData all = TypeData();
    all.id = 0;
    all.preId = null;
    all.name = '全部';
    subTypeList = [all];
    subTypeList.addAll(list);
    notifyListeners();
  }

  // 改变moreText的值
  void changeNoMore(String text) {
    noMoreText = text;
    notifyListeners();
  }

  // 改变isNewType为false
  void changeFale() {
    isNewType = false;
  }


  // 页数+1
  void addPage() {
    page++;
  }
}
