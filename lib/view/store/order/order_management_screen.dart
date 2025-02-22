import 'package:flutter/material.dart';
import 'package:sampleorder/view/store/common/common_drawer.dart';

class MockOrder {
  final String voucherNumber;
  final DateTime dateTime;
  final String itemName;
  final String status; // pending/prepared/delivered の文字列

  MockOrder({
    required this.voucherNumber,
    required this.dateTime,
    required this.itemName,
    required this.status,
  });
}

class OrderManagementScreen extends StatefulWidget {
  @override
  _OrderManagementScreenState createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // ==== [追加] ダミー注文 ====
  final List<MockOrder> dummyOrders = [
    MockOrder(
      voucherNumber: "V123456",
      dateTime: DateTime.now().subtract(Duration(minutes: 10)),
      itemName: "ポテトフライ x1, ビール x2",
      status: "pending",
    ),
    MockOrder(
      voucherNumber: "V234567",
      dateTime: DateTime.now().subtract(Duration(minutes: 30)),
      itemName: "からあげ x1",
      status: "prepared",
    ),
    MockOrder(
      voucherNumber: "V999999",
      dateTime: DateTime.now().subtract(Duration(hours: 1)),
      itemName: "チュロス x3",
      status: "delivered",
    ),
  ];

  List<MockOrder> _filterOrders(String filter) {
    return dummyOrders.where((o) => o.status == filter).toList();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // 未調理タブ: "pending"
  // 調理済みタブ: "prepared"
  // 提供済みタブ: "delivered"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注文管理(仮)'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.watch_later), text: '未調理'),
            Tab(icon: Icon(Icons.check_circle_outline), text: '調理済み'),
            Tab(icon: Icon(Icons.done_all), text: '提供済み'),
          ],
        ),
      ),
      drawer: CommonDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrderList("pending"),
          _buildOrderList("prepared"),
          _buildOrderList("delivered"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/transactionRegistration');
        },
        child: Icon(Icons.add),
        tooltip: '取引登録',
      ),
    );
  }

  Widget _buildOrderList(String statusFilter) {
    final orders = _filterOrders(statusFilter);
    if (orders.isEmpty) {
      return Center(child: Text('注文はありません'));
    }
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        final elapsedMinutes =
            DateTime.now().difference(order.dateTime).inMinutes;

        return ListTile(
          title: Text('引換券番号: ${order.voucherNumber}'),
          subtitle: Text(
            '注文: ${order.itemName}\n経過時間: ${elapsedMinutes}分前',
          ),
          isThreeLine: true,
          trailing: PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                // 状態変更(仮実装)
                // dummyOrdersの実態を変更して再描画するイメージ
                // ※実際にはIDなどで検索して状態を変える必要がある
              });
            },
            itemBuilder: (context) {
              // 状態変更オプション(仮)
              List<String> possible = ["pending", "prepared", "delivered"];
              possible.remove(order.status);
              return possible
                  .map((s) => PopupMenuItem<String>(
                        value: s,
                        child: Text(s),
                      ))
                  .toList();
            },
          ),
        );
      },
    );
  }
}
