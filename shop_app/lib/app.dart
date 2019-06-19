import 'package:flutter/material.dart';

import './pages/tabs.dart'; // 引入配置文件
import './core/config/index.dart'; // 引入配置文件
import './core/routers/index.dart'; // 路由配置

class ShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppRouter.init(); // 路由初始化
    return MaterialApp(
      title: StringMap.mainTitle, // APP标题
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.router.generator,
      // 定制主题
      theme: ThemeData(primaryColor: ColorMap.primary),
      home: TabsPage(),
    );
  }
}
