import 'package:flutter/material.dart';
// 仮画面用
import 'package:sampleorder/view/store/menu/menu_registration_screen.dart';
import 'package:sampleorder/view/store/transaction/transaction_registration_screen.dart';
import 'package:sampleorder/view/store/category/category_registration_screen.dart';
import 'package:sampleorder/view/store/common/common_drawer.dart';

void main() {
  runApp(SampleOrderApp());
}

class SampleOrderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SampleOrder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // ルーティング設定
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(), // アプリ起動時の画面(仮ホーム)
        '/menuRegistration': (context) => MenuRegistrationScreen(),
        '/transactionRegistration': (context) =>
            TransactionRegistrationScreen(),
        '/categoryRegistration': (context) => CategoryRegistrationScreen(),
      },
    );
  }
}

// アプリ起動直後に表示する仮のホーム画面
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SampleOrder Home (仮)"),
      ),
      drawer: CommonDrawer(),
      body: Center(
        child: Text("ここは仮のトップ画面です。"),
      ),
    );
  }
}
