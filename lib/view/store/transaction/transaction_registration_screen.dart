import 'package:flutter/material.dart';
import 'package:sampleorder/view/store/common/common_drawer.dart';

class TransactionRegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("取引登録(仮)"),
      ),
      drawer: CommonDrawer(),
      body: Center(
        child: Text("ここは取引登録画面の仮UIです。"),
      ),
    );
  }
}
