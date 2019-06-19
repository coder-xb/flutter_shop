import 'package:provide/provide.dart';
import 'package:flutter/material.dart';

import './app.dart';
import './core/states/tabs.dart';
import './core/states/cart.dart';
import './core/states/types.dart';
import './core/states/goods.dart';
import './core/states/detail.dart';

void main() {
  var providers = Providers();
  providers
    ..provide(Provider<TabIndex>.value(TabIndex()))
    ..provide(Provider<TypeState>.value(TypeState()))
    ..provide(Provider<GoodsState>.value(GoodsState()))
    ..provide(Provider<DetailState>.value(DetailState()))
    ..provide(Provider<CartState>.value(CartState()));

  runApp(ProviderNode(
    child: ShopApp(),
    providers: providers,
  ));
}
