import 'package:flutter/material.dart';
import 'package:sampleorder/view/store/common/common_drawer.dart';

// ==== [追加] ダミーメニューアイテム定義 ====
class MockMenuItem {
  final String name;
  final int price;

  MockMenuItem({required this.name, required this.price});
}

class MenuRegistrationScreen extends StatelessWidget {
  // ==== [追加] ダミーデータ ====
  final List<MockMenuItem> dummyMenuItems = [
    MockMenuItem(name: "からあげ", price: 300),
    MockMenuItem(name: "ポテトフライ", price: 200),
    MockMenuItem(name: "ビール", price: 500),
    MockMenuItem(name: "ソフトドリンク", price: 150),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("メニュー登録(仮)"),
      ),
      drawer: CommonDrawer(),
      body: Column(
        children: [
          // ==== [追加] ヘッダー的なラベルやボタン ====
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "カテゴリー：未選択 (仮)",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    // Todo: 後々「メニュー追加ダイアログ」を表示
                  },
                  tooltip: 'メニュー追加(仮)',
                ),
              ],
            ),
          ),
          Divider(height: 1),
          Expanded(
            child: ListView.separated(
              itemCount: dummyMenuItems.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                final item = dummyMenuItems[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text("価格: ¥${item.price}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {},
                        tooltip: '編集(仮)',
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {},
                        tooltip: '削除(仮)',
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
