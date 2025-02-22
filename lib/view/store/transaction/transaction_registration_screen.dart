import 'package:flutter/material.dart';
import 'package:sampleorder/view/store/common/common_drawer.dart';

class MockCategory {
  final String name;
  MockCategory(this.name);
}

class MockItem {
  final String name;
  final int price;
  MockItem({required this.name, required this.price});
}

class TransactionRegistrationScreen extends StatelessWidget {
  final List<MockCategory> dummyCategories = [
    MockCategory("揚げ物"),
    MockCategory("ドリンク"),
    MockCategory("スイーツ"),
  ];

  final List<MockItem> dummyItems = [
    MockItem(name: "ポテトフライ", price: 200),
    MockItem(name: "ビール", price: 500),
    MockItem(name: "チュロス", price: 300),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("取引登録(仮)"),
      ),
      drawer: CommonDrawer(),
      body: Row(
        children: [
          // カテゴリリスト
          Container(
            width: 150,
            color: Colors.grey[200],
            child: ListView.builder(
              itemCount: dummyCategories.length,
              itemBuilder: (context, index) {
                final cat = dummyCategories[index];
                return ListTile(
                  title: Text(cat.name),
                  onTap: () {
                    // 後々: カテゴリ選択時の処理
                  },
                );
              },
            ),
          ),
          VerticalDivider(width: 1),
          // メニューリスト
          Expanded(
            child: ListView.separated(
              itemCount: dummyItems.length,
              separatorBuilder: (context, index) => Divider(height: 1),
              itemBuilder: (context, index) {
                final item = dummyItems[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                            onTap: () {},
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(Icons.remove_circle_outline,
                                  size: 20, color: Colors.grey[700]),
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            "0",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 12),
                          InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(Icons.add_circle_outline,
                                  size: 20, color: Colors.grey[700]),
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
              "合計金額: ¥1000",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // 後々: 登録処理
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
  }
}
