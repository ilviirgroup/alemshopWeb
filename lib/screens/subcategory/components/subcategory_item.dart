import 'package:alemadmin/models/cart.dart';
import 'package:alemadmin/models/show_alert_dialog.dart';
import 'package:alemadmin/screens/product_detail/product_detail_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final _firestore = FirebaseFirestore.instance;
final user = FirebaseAuth.instance;

class SubCategoryItem extends StatefulWidget {
  final int subId;
  final int price;
  final String url;
  final String status;
  final String alemid;
  final String name;
  final String description;
  final List colors;
  final List sizes;
  final List urls;
  SubCategoryItem(
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
  _SubCategoryItemState createState() => _SubCategoryItemState();
}

class _SubCategoryItemState extends State<SubCategoryItem> {
  bool favoritePushed;
  final _showalert = ShowAlert();

  Widget listTile() {
    return ListTile();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(
                    name: widget.name,
                    colorTypes: widget.colors,
                    sizeTypes: widget.sizes,
                    urls: widget.urls,
                    subId: widget.subId,
                    alemid: widget.alemid,
                    price: widget.price,
                    url: widget.url,
                    status: widget.status,
                    description: widget.description,
                  ),
                ));
          },
          child: (widget.url != null)
              ? Image.network(widget.url)
              : Center(
                  child: Text('Нет изображения'),
                ),
        ),
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              if (user.currentUser != null) {
                _firestore.collection('favorites').add({
                  'status': widget.status,
                  'description': widget.description,
                  'url': widget.url,
                  'subcategory': widget.subId,
                  'price': widget.price,
                  'alemid': widget.alemid,
                  'name': widget.name,
                  'colors': widget.colors,
                  'sizes': widget.sizes,
                  'urls': widget.urls,
                  'login': user.currentUser.phoneNumber
                });
                _showalert.showAlertDialog(
                    context, "Избранное ", "Добавлено в избранное");
              } else {
                _showalert.showAlertDialog(context, "", "Пожалуйста войдите");
              }
            },
          ),
          backgroundColor: Colors.black45,
          title: Text(
            widget.name,
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }
}
