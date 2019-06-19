import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../../pages/main/detail/index.dart';

Handler detailHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String goodsId = params['id'].first;
    return DetailPage(goodsId);
  }
);
