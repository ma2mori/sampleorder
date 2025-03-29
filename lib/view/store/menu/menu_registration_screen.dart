import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleorder/view/store/common/common_drawer.dart';
import 'package:sampleorder/viewmodel/menu_viewmodel.dart';
import 'package:sampleorder/viewmodel/category_viewmodel.dart';

class MenuRegistrationScreen extends StatefulWidget {
  @override
  _MenuRegistrationScreenState createState() => _MenuRegistrationScreenState();
}

class _MenuRegistrationScreenState extends State<MenuRegistrationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String? _selectedCategoryId;
  String? _selectedCategoryName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("メニュー登録"),
      ),
      drawer: CommonDrawer(),
      body: Consumer2<MenuViewModel, CategoryViewModel>(
        builder: (context, menuViewModel, categoryViewModel, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        _showCategorySelectionDialog(
                            context, categoryViewModel);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Text(
                              _selectedCategoryName != null
                                  ? "カテゴリー：$_selectedCategoryName"
                                  : "カテゴリー：未選択",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        _showAddMenuDialog(context, categoryViewModel);
                      },
                      tooltip: 'メニュー追加',
                    ),
                  ],
                ),
              ),
              Divider(height: 1),
              Expanded(
                child: menuViewModel.menuItems.isEmpty
                    ? Center(child: Text("メニューがありません"))
                    : ListView.separated(
                        itemCount: menuViewModel.menuItems.length,
                        separatorBuilder: (context, index) => Divider(),
                        itemBuilder: (context, index) {
                          final item = menuViewModel.menuItems[index];
                          // Find category name for this menu item - using try-catch to handle potential errors
                          String categoryName = "未分類";
                          try {
                            final category =
                                categoryViewModel.categories.firstWhere(
                              (cat) => cat.id == item.categoryId,
                            );
                            categoryName = category.name;
                          } catch (e) {
                            // If category not found, keep the default "未分類" value
                          }

                          return ListTile(
                            title: Text(item.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("価格: ¥${item.price}"),
                                Text(
                                  "カテゴリー: $categoryName",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[600]),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    menuViewModel.deleteMenuItem(item.id);
                                  },
                                  tooltip: '削除',
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showCategorySelectionDialog(
      BuildContext context, CategoryViewModel categoryViewModel) {
    if (categoryViewModel.categories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("カテゴリーがありません。先にカテゴリーを追加してください。")),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("カテゴリーを選択"),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: categoryViewModel.categories.length,
              itemBuilder: (context, index) {
                final category = categoryViewModel.categories[index];
                return ListTile(
                  title: Text(category.name),
                  onTap: () {
                    setState(() {
                      _selectedCategoryId = category.id;
                      _selectedCategoryName = category.name;
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("キャンセル"),
            ),
          ],
        );
      },
    );
  }

  void _showAddMenuDialog(
      BuildContext context, CategoryViewModel categoryViewModel) {
    _nameController.clear();
    _priceController.clear();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("メニュー追加"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(hintText: "メニュー名"),
              ),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "価格"),
              ),
              SizedBox(height: 16),
              // Show selected category
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("選択中のカテゴリー", style: TextStyle(fontSize: 12)),
                    Text(_selectedCategoryName ?? "未選択",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              if (_selectedCategoryId == null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "カテゴリーを選択してください",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("キャンセル"),
            ),
            ElevatedButton(
              onPressed: _selectedCategoryId == null
                  ? null
                  : () {
                      if (_nameController.text.isNotEmpty &&
                          _priceController.text.isNotEmpty) {
                        final price = int.tryParse(_priceController.text) ?? 0;
                        Provider.of<MenuViewModel>(context, listen: false)
                            .addMenuItem(_nameController.text, price,
                                _selectedCategoryId!);
                        Navigator.pop(context);
                      }
                    },
              child: Text("追加"),
            ),
          ],
        );
      },
    );
  }
}
