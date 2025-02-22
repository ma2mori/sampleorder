import 'package:flutter/material.dart';

class CommonDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // ヘッダー部分
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'SampleOrder',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),

          // 注文管理へ (Home相当)
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('注文管理(仮)'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),

          // 取引登録へ
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('取引登録(仮)'),
            onTap: () {
              Navigator.pushNamed(context, '/transactionRegistration');
            },
          ),

          // メニュー登録へ
          ListTile(
            leading: Icon(Icons.restaurant_menu),
            title: Text('メニュー登録(仮)'),
            onTap: () {
              Navigator.pushNamed(context, '/menuRegistration');
            },
          ),

          // カテゴリー登録へ
          ListTile(
            leading: Icon(Icons.category),
            title: Text('カテゴリー登録(仮)'),
            onTap: () {
              Navigator.pushNamed(context, '/categoryRegistration');
            },
          ),
        ],
      ),
    );
  }
}
