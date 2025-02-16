import 'package:flutter/material.dart';
import 'package:sampleorder/view/store/common/common_drawer.dart';

class CategoryRegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("カテゴリー登録(仮)"),
      ),
      drawer: CommonDrawer(),
      body: Center(
        child: Text("ここはカテゴリー登録画面の仮UIです。"),
      ),
    );
  }
}
