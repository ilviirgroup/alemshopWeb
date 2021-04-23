import 'package:alemadmin/models/cart.dart';
import 'package:alemadmin/screens/product_detail/product_detail_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final _firestore = FirebaseFirestore.instance;
final user = FirebaseAuth.instance;

class SearchListItem extends StatelessWidget {
  final int subId;
  final int price;
  final String url;
  final String alemid;
  final String name;
  final List colors;
  final List sizes;
  final List urls;
  final String status;
  final String description;
  SearchListItem(
      {this.url,
      this.name,
      this.colors,
      this.sizes,
      this.urls,
      this.subId,
      this.alemid,
      this.price,
      this.status,
      this.description});
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return ListTile(
      contentPadding: EdgeInsets.all(10),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                      name: name,
                      colorTypes: colors,
                      sizeTypes: sizes,
                      urls: urls,
                      subId: subId,
                      alemid: alemid,
                      price: price,
                      url: url,
                      description: description,
                      status: status,
                    )));
      },
      title: Text(name),
      leading: (url != null)
          ? Image.network(url)
          : Center(
              child: Text('Нет изображения'),
            ),
      trailing: Text(price.toString() + " TMT"),
    );
  }
}
