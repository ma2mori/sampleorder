import 'package:flutter/material.dart';
import 'package:sampleorder/view/store/menu/menu_registration_screen.dart';
import 'package:sampleorder/view/store/transaction/transaction_registration_screen.dart';
import 'package:sampleorder/view/store/category/category_registration_screen.dart';
import 'package:sampleorder/view/store/order/order_management_screen.dart';
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
        '/': (context) => OrderManagementScreen(),
        '/transactionRegistration': (context) =>
            TransactionRegistrationScreen(),
        '/menuRegistration': (context) => MenuRegistrationScreen(),
        '/categoryRegistration': (context) => CategoryRegistrationScreen(),
      },
    );
  }
}
