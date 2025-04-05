import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleorder/view/store/common/common_drawer.dart';
import 'package:sampleorder/domain/menu/model/menu.dart';
import 'package:sampleorder/domain/order/model/order.dart';
import 'package:sampleorder/viewmodel/order_viewmodel.dart';
import 'package:sampleorder/viewmodel/menu_viewmodel.dart';

class OrderManagementScreen extends StatefulWidget {
  @override
  _OrderManagementScreenState createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OrderViewModel()),
        ChangeNotifierProvider(create: (_) => MenuViewModel()),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('注文管理'),
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
                _buildOrderList(context, OrderItemStatus.pending),
                _buildOrderList(context, OrderItemStatus.prepared),
                _buildOrderList(context, OrderItemStatus.delivered),
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
        },
      ),
    );
  }

  Widget _buildOrderList(BuildContext context, OrderItemStatus status) {
    final orderViewModel = Provider.of<OrderViewModel>(context);
    final menuViewModel = Provider.of<MenuViewModel>(context);

    // 注文アイテムのステータスに基づいて注文をフィルタリング
    List<Order> filteredOrders = orderViewModel.orders
        .where((order) => order.items.any((item) => item.status == status))
        .toList();

    if (filteredOrders.isEmpty) {
      return Center(child: Text('注文はありません'));
    }

    return ListView.builder(
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        final order = filteredOrders[index];
        final elapsedMinutes =
            DateTime.now().difference(order.dateTime).inMinutes;

        // 注文アイテムのテキスト生成
        String itemsText = '';
        for (var item in order.items) {
          if (item.status == status) {
            final menuItem = menuViewModel.menuItems.firstWhere(
                (menu) => menu.id == item.menuItemId,
                orElse: () => MenuItem(
                    id: '', name: '不明なアイテム', price: 0, categoryId: ''));
            itemsText += '${menuItem.name} x${item.quantity}, ';
          }
        }

        if (itemsText.isNotEmpty) {
          itemsText =
              itemsText.substring(0, itemsText.length - 2); // 末尾のカンマとスペースを削除
        }

        return ListTile(
          title: Text('引換券番号: ${order.voucherNumber}'),
          subtitle: Text(
            '注文: $itemsText\n経過時間: $elapsedMinutes分前',
          ),
          isThreeLine: true,
          trailing: PopupMenuButton<OrderItemStatus>(
            onSelected: (value) {
              _updateOrderStatus(context, order, status, value);
            },
            itemBuilder: (context) {
              // 現在のステータスに基づいて可能な状態遷移を決定
              List<OrderItemStatus> possible = [];
              switch (status) {
                case OrderItemStatus.pending:
                  possible = [OrderItemStatus.prepared];
                  break;
                case OrderItemStatus.prepared:
                  possible = [
                    OrderItemStatus.delivered,
                    OrderItemStatus.pending
                  ];
                  break;
                case OrderItemStatus.delivered:
                  possible = [OrderItemStatus.prepared];
                  break;
              }

              return possible
                  .map((s) => PopupMenuItem<OrderItemStatus>(
                        value: s,
                        child: Text(_getStatusText(s)),
                      ))
                  .toList();
            },
          ),
        );
      },
    );
  }

  String _getStatusText(OrderItemStatus status) {
    switch (status) {
      case OrderItemStatus.pending:
        return '未調理に戻す';
      case OrderItemStatus.prepared:
        return '調理済みにする';
      case OrderItemStatus.delivered:
        return '提供済みにする';
    }
  }

  void _updateOrderStatus(BuildContext context, Order order,
      OrderItemStatus fromStatus, OrderItemStatus toStatus) {
    final orderViewModel = Provider.of<OrderViewModel>(context, listen: false);

    // 注文の複製
    final updatedItems = order.items.map((item) {
      if (item.status == fromStatus) {
        return OrderItem(
          menuItemId: item.menuItemId,
          quantity: item.quantity,
          status: toStatus,
        );
      }
      return item;
    }).toList();

    final updatedOrder = Order(
      id: order.id,
      voucherNumber: order.voucherNumber,
      dateTime: order.dateTime,
      items: updatedItems,
    );

    // 更新
    orderViewModel.updateOrder(updatedOrder);
  }
}
