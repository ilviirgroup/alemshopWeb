import 'package:alemadmin/screens/favorites_screen/companents/foverite_item.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;
final user = FirebaseAuth.instance;

class FavCategoryGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('favorites').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final categories = snapshot.data.docs.reversed;
        List<FavCategoryItem> categoryList = [];
        for (var category in categories) {
          final url = category.data()['url'];
          final id = category.data()['subcategory'];
          final name = category.data()['name'];
          final colors = category.data()['colors'];
          final sizes = category.data()['sizes'];
          final urls = category.data()['urls'];
          final alemid = category.data()['alemid'];
          final price = category.data()['price'];
          final login = category.data()['login'];
          final status = category.data()['status'];
          final description = category.data()['description'];
          final ref = category.reference;
          if (user.currentUser != null) {
            if (login == user.currentUser.phoneNumber) {
              final categoryitem = FavCategoryItem(
                url: url,
                name: name,
                colors: colors,
                sizes: sizes,
                urls: urls,
                subId: id,
                alemid: alemid,
                ref: ref,
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
