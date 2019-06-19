import 'package:flutter/material.dart';
import 'dart:async';
// 启动页
class StartPage extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<StartPage> {
  @override
  void initState() {
    super.initState();
    // 加载页停顿3秒
    Future.delayed(
      Duration(seconds: 3),
      () {
        print('启动页加载完毕...');
        Navigator.of(context).pushReplacementNamed('/login');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/start.jpg',
              fit: BoxFit.cover,
            ),
            Center(
              child: Text(
                '这是APP启动页',
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 36.0,
                  decoration: TextDecoration.none,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
