import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart.dart';

// 购物车状态管理
class CartState with ChangeNotifier {
  List<CartModel> cartList = []; // 商品列表
  double totalPrice = 0; // 总价
  int totalCount = 0; // 商品总数
  bool allSelect = true; // 是否全选

  // 添加至购物车
  void addToCart(id, img, name, count, price) async {
    await _storeHandle((prefs, list) {
      // 判断购物车中是否已经存在该商品
      bool have = false; // 默认没有
      totalPrice = 0;
      totalCount = 0;
      // 将cartList重置并初始化，防止数据混乱
      cartList = [];
      for (int i = 0, len = list.length; i < len; i++) {
        if (list[i]['id'] == id) {
          have = true;
          list[i]['count']++;
          list[i]['isSelect'] = true;
        }
        if (list[i]['isSelect']) {
          totalPrice += (list[i]['price'] * list[i]['count']);
          totalCount += list[i]['count'];
        }
        cartList.add(CartModel.fromJson(list[i]));
      }

      if (!have) {
        Map<String, dynamic> goods = {
          'id': id,
          'img': img,
          'name': name,
          'count': count,
          'price': price,
          'isSelect': true
        };
        list.add(goods);
        cartList.add(CartModel.fromJson(goods));
        totalPrice += (count * price);
        totalCount += count;
      }
      prefs.setString('cartInfo', json.encode(list).toString());
      notifyListeners();
    });
  }

  // 从本地缓存获取购物车数据(供界面显示)
  Future getCartInfo() async {
    await _storeHandle((prefs, list) {
      // 将cartList重置并初始化，防止数据混乱
      cartList = [];
      if (list.isNotEmpty) {
        totalPrice = 0;
        totalCount = 0;
        allSelect = true;
        list.forEach((item) {
          if (item['isSelect']) {
            totalPrice += (item['price'] * item['count']); // 总价计算
            totalCount += item['count']; // 总数计算
          } else
            allSelect = false;

          cartList.add(CartModel.fromJson(item));
        });
      } else
        cartList = [];

      notifyListeners();
    });
  }

  // 修改选择状态
  void changeSelect(String id, bool select) async {
    await _storeHandle((prefs, list) async {
      for (int i = 0, len = list.length; i < len; i++) {
        if (list[i]['id'] == id) {
          list[i]['isSelect'] = select;
          break;
        }
      }
      prefs.setString('cartInfo', json.encode(list).toString());
      await getCartInfo();
    });
  }

  // 删除某一种商品
  void delAGoods(String id) async {
    await _storeHandle((prefs, list) async {
      for (int i = 0, len = list.length; i < len; i++) {
        if (list[i]['id'] == id) {
          list.removeAt(i);
          break;
        }
      }
      prefs.setString('cartInfo', json.encode(list).toString());
      await getCartInfo();
    });
  }

  // 数量增加减少 act -1为减少  1为增加
  void countControll(CartModel cartItem, int act) async {
    await _storeHandle((prefs, list) async {
      for (int i = 0, len = list.length; i < len; i++) {
        if (list[i]['id'] == cartItem.id) {
          cartItem.count += act;
          cartItem.count = max(1, cartItem.count);
          list[i] = cartItem.toJson();
          break;
        }
      }
      prefs.setString('cartInfo', json.encode(list).toString());
      await getCartInfo();
    });
  }

  // 全选
  void changeAllSelect(bool select) async {
    await _storeHandle((prefs, list) async {
      for (int i = 0, len = list.length; i < len; i++)
        list[i]['isSelect'] = select;
      prefs.setString('cartInfo', json.encode(list).toString());
      await getCartInfo();
    });
  }

  // 本地存储操作
  Future _storeHandle(Function callback) async {
    // 初始化SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cartInfo = prefs.getString('cartInfo'); // 获取持久化存储的值
    // 将获取到的值转化为List
    List<Map<String, dynamic>> tempList =
        ((cartInfo == null ? [] : json.decode(cartInfo.toString())) as List)
            .cast();
    callback(prefs, tempList);
  }
}
