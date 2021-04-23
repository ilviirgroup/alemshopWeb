import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'category_item.dart';

final _firestore = FirebaseFirestore.instance;

class CategoryGridView extends StatelessWidget {
  final bool man;
  final bool woman;
  CategoryGridView({this.man, this.woman});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('category')
          .orderBy('id', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final categories = snapshot.data.docs.reversed;
        List<CategoryItem> categoryList = [];
        for (var category in categories) {
          final url = category.data()['url'];
          final name = category.data()['name'];
          final subcategory = category.data()['id'];

          final categoryitem = CategoryItem(
            url: url,
            name: name,
            subcategory: subcategory,
            man: man,
            woman: woman,
          );

          categoryList.add(categoryitem);
        }
        return GridView(
          children: categoryList,
          padding: EdgeInsets.all(10.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        );
      },
    );
  }
}
