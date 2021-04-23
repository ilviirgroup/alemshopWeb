import 'package:alemadmin/screens/product_detail/product_detail_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavCategoryItem extends StatelessWidget {
  final int subId;
  final int price;
  final String url;
  final String alemid;
  final String name;
  final List colors;
  final List sizes;
  final List urls;
  final DocumentReference ref;
  final String status;
  final String description;

  FavCategoryItem(
      {this.url,
      this.name,
      this.colors,
      this.sizes,
      this.urls,
      this.subId,
      this.alemid,
      this.price,
      this.ref,
      this.status,
      this.description});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(
                          colorTypes: colors,
                          sizeTypes: sizes,
                          urls: urls,
                          subId: subId,
                          alemid: alemid,
                          price: price,
                          url: url,
                          status: status,
                          description: description,
                        )));
          },
          child: Image.network(url),
        ),
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              ref.delete();
            },
          ),
          backgroundColor: Colors.black45,
          title: Text(
            '${name}',
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }
}
