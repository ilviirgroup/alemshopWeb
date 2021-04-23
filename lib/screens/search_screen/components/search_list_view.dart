import 'package:alemadmin/screens/search_screen/components/search_list_item.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

class SearchListView extends StatelessWidget {
  final String name;
  SearchListView({this.name});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }

        final categories = snapshot.data.docs.reversed;
        List<SearchListItem> categoryList = [];
        for (var category in categories) {
          final id = category.data()['subcategory'];
          final String name = category.data()['name'];
          final colors = category.data()['colors'];
          final sizes = category.data()['size'];

          final urls = category.data()['url'];
          final url = category.data()['url'][0];
          final String alemid = category.data()['alemid'];
          final price = category.data()['price'];
          final description = category.data()['description'];
          final status = category.data()['status'];
          final regex = RegExp('${this.name}');
          final categoryitem = SearchListItem(
            url: url,
            name: name,
            colors: colors,
            sizes: sizes,
            urls: urls,
            subId: id,
            alemid: alemid,
            price: price,
            description: description,
            status: status,
          );
          if ((regex.hasMatch(alemid.toLowerCase()) ||
                  regex.hasMatch(name) ||
                  regex.hasMatch(name.toLowerCase())) &&
              this.name != '') {
            categoryList.add(categoryitem);
          }
        }
        return ListView(
          children: categoryList,
          padding: EdgeInsets.all(10.0),
        );
      },
    );
  }
}
