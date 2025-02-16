import 'package:flutter/material.dart';
import 'package:sampleorder/view/store/common/common_drawer.dart';

class MenuRegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("メニュー登録(仮)"),
      ),
      drawer: CommonDrawer(), // ← 先ほど作成したDrawerを使う
      body: Center(
        child: Text("ここはメニュー登録画面の仮UIです。"),
      ),
    );
  }
}
