import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sampleorder/domain/category.dart';
import 'package:sampleorder/domain/menu.dart';
import 'package:sampleorder/domain/transaction.dart';
import 'package:sampleorder/domain/order.dart';
import 'package:sampleorder/view/store/menu/menu_registration_screen.dart';
import 'package:sampleorder/view/store/transaction/transaction_registration_screen.dart';
import 'package:sampleorder/view/store/category/category_registration_screen.dart';
import 'package:sampleorder/view/store/order/order_management_screen.dart';
import 'package:sampleorder/view/store/common/common_drawer.dart';
import 'package:sampleorder/viewmodel/category_viewmodel.dart';
import 'package:sampleorder/viewmodel/menu_viewmodel.dart';
import 'package:sampleorder/viewmodel/transaction_viewmodel.dart';
import 'package:sampleorder/viewmodel/order_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hiveの初期化
  await Hive.initFlutter();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  // 既存のカテゴリー・メニューアダプター登録
  Hive.registerAdapter(MenuCategoryAdapter());
  Hive.registerAdapter(MenuItemAdapter());
  // 【追加】 取引・注文用のアダプター登録
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(OrderAdapter());
  Hive.registerAdapter(OrderItemAdapter());
  Hive.registerAdapter(OrderItemStatusAdapter());

  // 各ボックスを開く
  await Hive.openBox('categories');
  await Hive.openBox('menuItems');
  await Hive.openBox('transactions');
  await Hive.openBox('orders');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryViewModel()),
        ChangeNotifierProvider(create: (_) => MenuViewModel()),
        ChangeNotifierProvider(create: (_) => TransactionViewModel()),
        ChangeNotifierProvider(create: (_) => OrderViewModel()),
      ],
      child: SampleOrderApp(),
    ),
  );
}

class SampleOrderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SampleOrder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
