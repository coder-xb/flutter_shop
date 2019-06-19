import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import './handlers.dart';

class Routes {
  static String root = '/';
  static String detail = '/detail';

  static void config(Router router) {
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print('ROUTER ERROR: Invalid route');
      }
    );
    router.define(detail, handler: detailHandler); // 详情页
  }
}
