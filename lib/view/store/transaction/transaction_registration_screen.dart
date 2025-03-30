import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleorder/view/store/common/common_drawer.dart';
import 'package:sampleorder/domain/menu.dart';
import 'package:sampleorder/domain/transaction.dart';
import 'package:sampleorder/domain/order.dart';
import 'package:uuid/uuid.dart';
import 'package:sampleorder/viewmodel/category_viewmodel.dart';
import 'package:sampleorder/viewmodel/menu_viewmodel.dart';
import 'package:sampleorder/viewmodel/transaction_viewmodel.dart';
import 'package:sampleorder/viewmodel/order_viewmodel.dart';

class TransactionRegistrationScreen extends StatefulWidget {
  @override
  _TransactionRegistrationScreenState createState() =>
      _TransactionRegistrationScreenState();
}

class _TransactionRegistrationScreenState
    extends State<TransactionRegistrationScreen> {
  String? selectedCategoryId;
  Map<String, int> selectedItems = {}; // メニューIDと数量のマップ
  int totalAmount = 0;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryViewModel()),
        ChangeNotifierProvider(create: (_) => MenuViewModel()),
        ChangeNotifierProvider(create: (_) => TransactionViewModel()),
        ChangeNotifierProvider(create: (_) => OrderViewModel()),
      ],
      child: Builder(
        builder: (context) {
          final categoryViewModel = Provider.of<CategoryViewModel>(context);
          final menuViewModel = Provider.of<MenuViewModel>(context);

          // カテゴリに基づいてメニューアイテムをフィルタリング
          List<MenuItem> filteredItems = [];
          if (selectedCategoryId != null) {
            filteredItems = menuViewModel.menuItems
                .where((item) => item.categoryId == selectedCategoryId)
                .toList();
          } else if (categoryViewModel.categories.isNotEmpty) {
            // デフォルトで最初のカテゴリを選択
            selectedCategoryId = categoryViewModel.categories.first.id;
            filteredItems = menuViewModel.menuItems
                .where((item) => item.categoryId == selectedCategoryId)
                .toList();
          }

          return Scaffold(
            appBar: AppBar(
              title: Text("取引登録"),
            ),
            drawer: CommonDrawer(),
            body: Row(
              children: [
                // カテゴリリスト
                Container(
                  width: 150,
                  color: Colors.grey[200],
                  child: ListView.builder(
                    itemCount: categoryViewModel.categories.length,
                    itemBuilder: (context, index) {
                      final cat = categoryViewModel.categories[index];
                      return ListTile(
                        title: Text(cat.name),
                        selected: selectedCategoryId == cat.id,
                        onTap: () {
                          setState(() {
                            selectedCategoryId = cat.id;
                          });
                        },
                      );
                    },
                  ),
                ),
                VerticalDivider(width: 1),
                // メニューリスト
                Expanded(
                  child: filteredItems.isEmpty
                      ? Center(child: Text('このカテゴリには商品がありません'))
                      : ListView.separated(
                          itemCount: filteredItems.length,
                          separatorBuilder: (context, index) =>
                              Divider(height: 1),
                          itemBuilder: (context, index) {
                            final item = filteredItems[index];
                            final quantity = selectedItems[item.id] ?? 0;

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // 商品名と価格
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item.name,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "¥${item.price}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 6),
                                  // 数量調整ボタン
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (quantity > 0) {
                                            setState(() {
                                              selectedItems[item.id] =
                                                  quantity - 1;
                                              if (selectedItems[item.id] == 0) {
                                                selectedItems.remove(item.id);
                                              }
                                              _calculateTotal(
                                                  menuViewModel.menuItems);
                                            });
                                          }
                                        },
                                        borderRadius: BorderRadius.circular(12),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Icon(
                                            Icons.remove_circle_outline,
                                            size: 20,
                                            color: quantity > 0
                                                ? Colors.blue
                                                : Colors.grey[700],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        "$quantity",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedItems[item.id] =
                                                (quantity + 1);
                                            _calculateTotal(
                                                menuViewModel.menuItems);
                                          });
                                        },
                                        borderRadius: BorderRadius.circular(12),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Icon(
                                            Icons.add_circle_outline,
                                            size: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
            // 画面下部に取引登録ボタンを配置
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "合計金額: ¥$totalAmount",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: selectedItems.isEmpty
                        ? null
                        : () => _registerTransaction(context),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: Text(
                      "取引登録",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _calculateTotal(List<MenuItem> menuItems) {
    int sum = 0;
    selectedItems.forEach((itemId, quantity) {
      final item = menuItems.firstWhere((item) => item.id == itemId);
      sum += item.price * quantity;
    });
    setState(() {
      totalAmount = sum;
    });
  }

  void _registerTransaction(BuildContext context) {
    final transactionViewModel =
        Provider.of<TransactionViewModel>(context, listen: false);
    final orderViewModel = Provider.of<OrderViewModel>(context, listen: false);

    // ランダムな引換券番号生成
    final voucherNumber =
        'V${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}';

    // トランザクション登録
    final transaction = Transaction(
      id: Uuid().v4(),
      dateTime: DateTime.now(),
      voucherNumber: voucherNumber,
      totalAmount: totalAmount,
      receivedAmount: totalAmount, // 仮で合計金額と同じ（実際は支払い処理追加）
      change: 0, // 仮でお釣り0円（実際は支払い処理追加）
      items: selectedItems,
    );

    // オーダー項目の作成
    final orderItems = selectedItems.entries.map((entry) {
      return OrderItem(
        menuItemId: entry.key,
        quantity: entry.value,
        status: OrderItemStatus.pending,
      );
    }).toList();

    // オーダー登録
    final order = Order(
      id: Uuid().v4(),
      voucherNumber: voucherNumber,
      dateTime: DateTime.now(),
      items: orderItems,
    );

    // データ保存
    transactionViewModel.addTransaction(transaction);
    orderViewModel.addOrder(order);

    // ダイアログ表示
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('取引登録完了'),
        content: Text('引換券番号: $voucherNumber\n合計金額: ¥$totalAmount'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // 選択リセット
              setState(() {
                selectedItems.clear();
                totalAmount = 0;
              });
            },
            child: Text('閉じる'),
          ),
        ],
      ),
    );
  }
}
