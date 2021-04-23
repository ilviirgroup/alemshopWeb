import 'package:alemadmin/screens/subcategory/components/subcategory_item.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

class SubCategoryGridView extends StatelessWidget {
  final int subId;
  final int gender;
  SubCategoryGridView({this.subId, this.gender});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('products').orderBy('alemid').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }

        final categories = snapshot.data.docs.reversed;
        List<SubCategoryItem> categoryList = [];

        for (var category in categories) {
          final urls = category.data()['url'];
          final url = urls[0];
          final id = category.data()['subcategory'];
          final name = category.data()['name'];
          final status = category.data()['status'];
          final description = category.data()['description'];
          final colors = category.data()['colors'];
          final sizes = category.data()['size'];
          final alemid = category.data()['alemid'];
          final price = category.data()['price'];
          final genderFilter = category.data()['gender'];

          if (gender == 0) {
            if (id == subId) {
              final categoryitem = SubCategoryItem(
                url: url,
                name: name,
                colors: colors,
                sizes: sizes,
                urls: urls,
                subId: id,
                alemid: alemid,
                price: price,
                status: status,
                description: description,
              );
              categoryList.add(categoryitem);
            }
          } else {
            if (id == subId && gender == genderFilter) {
              final categoryitem = SubCategoryItem(
                url: url,
                name: name,
                colors: colors,
                sizes: sizes,
                urls: urls,
                subId: id,
                alemid: alemid,
                price: price,
                status: status,
                description: description,
              );
              categoryList.add(categoryitem);
            }
          }
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
