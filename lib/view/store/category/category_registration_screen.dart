import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleorder/view/store/common/common_drawer.dart';
import 'package:sampleorder/viewmodel/category_viewmodel.dart';

class CategoryRegistrationScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("カテゴリー登録"),
      ),
      drawer: CommonDrawer(),
      body: Consumer<CategoryViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("カテゴリー一覧", style: TextStyle(fontSize: 16)),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        _showAddCategoryDialog(context);
                      },
                      tooltip: 'カテゴリー追加',
                    ),
                  ],
                ),
              ),
              Divider(height: 1),
              Expanded(
                child: viewModel.categories.isEmpty
                    ? Center(child: Text("カテゴリーがありません"))
                    : ListView.separated(
                        itemCount: viewModel.categories.length,
                        separatorBuilder: (context, index) => Divider(),
                        itemBuilder: (context, index) {
                          final category = viewModel.categories[index];
                          return ListTile(
                            title: Text(category.name),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    viewModel.deleteCategory(category);
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

  void _showAddCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("カテゴリー追加"),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: "カテゴリー名"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("キャンセル"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  Provider.of<CategoryViewModel>(context, listen: false)
                      .addCategory(_controller.text);
                  _controller.clear();
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
