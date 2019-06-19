import 'package:fluro/fluro.dart';

import './routes.dart';

class AppRouter {
  static Router router = Router();
  // 路由初始化
  static void init() {
    Routes.config(router);
  }
}
