import 'package:provide/provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/config/index.dart';
import '../../../core/states/cart.dart';

import './item.dart';
import './bottom.dart';

class CartPage extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringMap.cartTitle),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context, snapshot) {
          List<dynamic> cartList = Provide.value<CartState>(context).cartList;
          if (snapshot.hasData && cartList.isNotEmpty) {
            return Stack(
              children: <Widget>[
                Provide<CartState>(
                  builder: (BuildContext context, child, item) {
                    cartList = Provide.value<CartState>(context).cartList;
                    return Container(
                      padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(76)),
                      child: ListView.builder(
                        itemCount: cartList.length,
                        itemBuilder: (BuildContext context, index) =>
                            CartItem(cartList[index]),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: CartBottom(),
                )
              ],
            );
          } else {
            return Center(child: Text(StringMap.loadText));
          }
        },
      ),
    );
  }

  Future _getCartInfo(BuildContext content) async {
    await Provide.value<CartState>(context).getCartInfo();
    return '';
  }
}
