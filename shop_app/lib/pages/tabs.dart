import 'package:provide/provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // 屏幕适配

import './main/home.dart'; // 首页
import './main/type.dart'; // 分类
import './main/user.dart'; // 会员中心
import './main/cart/index.dart'; // 会员中心
import '../core/config/index.dart'; // 基础配置
import '../core/states/tabs.dart'; // tab状态管理

class TabsPage extends StatelessWidget {
  final List<BottomNavigationBarItem> botTabs = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text(StringMap.homeTitle),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.category),
      title: Text(StringMap.typeTitle),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      title: Text(StringMap.cartTitle),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text(StringMap.userTitle),
    ),
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    TypePage(),
    CartPage(),
    UserPage()
  ];

  @override
  Widget build(BuildContext context) {
    // 屏幕适配处理
    ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);
    return Provide<TabIndex>(
      builder: (context, child, val) {
        // 获取当前索引状态值
        int curTabIndex = Provide.value<TabIndex>(context).curTabIndex;
        return Scaffold(
          backgroundColor: ColorMap.mainBg,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: curTabIndex,
            items: botTabs,
            onTap: (index) {
              Provide.value<TabIndex>(context).changeIndex(index);
            },
          ),
          body: IndexedStack(
            index: curTabIndex,
            children: tabBodies,
          ),
        );
      },
    );
  }
}
