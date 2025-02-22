import 'package:flutter/material.dart';
import 'package:sampleorder/view/store/common/common_drawer.dart';

// ==== [追加] ダミーカテゴリー ====
class MockCategory {
  final String name;

  MockCategory(this.name);
}

class CategoryRegistrationScreen extends StatelessWidget {
  final List<MockCategory> dummyCategories = [
    MockCategory("揚げ物"),
    MockCategory("ドリンク"),
    MockCategory("スイーツ"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("カテゴリー登録(仮)"),
      ),
      drawer: CommonDrawer(),
      body: Column(
        children: [
          // 上部に「カテゴリー追加」ボタンなど
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("カテゴリー一覧(仮)", style: TextStyle(fontSize: 16)),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    // 後々: カテゴリ追加ダイアログ
                  },
                  tooltip: 'カテゴリー追加(仮)',
                )
              ],
            ),
          ),
          Divider(height: 1),
          Expanded(
            child: ListView.separated(
              itemCount: dummyCategories.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                final cat = dummyCategories[index];
                return ListTile(
                  title: Text(cat.name),
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
