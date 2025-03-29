import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sampleorder/domain/category.dart';
import 'package:sampleorder/domain/menu.dart';
import 'package:sampleorder/view/store/menu/menu_registration_screen.dart';
import 'package:sampleorder/view/store/transaction/transaction_registration_screen.dart';
import 'package:sampleorder/view/store/category/category_registration_screen.dart';
import 'package:sampleorder/view/store/order/order_management_screen.dart';
import 'package:sampleorder/view/store/common/common_drawer.dart';
import 'package:sampleorder/viewmodel/category_viewmodel.dart';
import 'package:sampleorder/viewmodel/menu_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hiveの初期化
  await Hive.initFlutter();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  Hive.registerAdapter(MenuCategoryAdapter());
  Hive.registerAdapter(MenuItemAdapter());

  // Hiveボックスを開く（カテゴリーとメニュー用）
  await Hive.openBox('categories');
  await Hive.openBox('menuItems');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryViewModel()),
        ChangeNotifierProvider(create: (_) => MenuViewModel()),
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
