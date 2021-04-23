import 'package:alemadmin/models/cart.dart' show Cart;
import 'package:alemadmin/widgets/cart_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ваша корзина'),
        ),
        body: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Cумма',
                      style: TextStyle(fontSize: 16),
                    ),
                    // Spacer(),
                    Chip(
                      label: Consumer<Cart>(
                        builder: (_, cart, ch) => Text(
                          '${cart.totalAmount.toStringAsFixed(2)} TMT',
                          style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .headline6
                                .color,
                          ),
                        ),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    OrderButton(cart: cart)
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) => CartItem(
                  cart.items.values.toList()[i].id,
                  cart.items.keys.toList()[i],
                  cart.items.values.toList()[i].price,
                  cart.items.values.toList()[i].quantity,
                  cart.items.values.toList()[i].title,
                  cart.items.values.toList()[i].imgUrl,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  showAlertDialog(BuildContext context, String title, String text) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(child: Text(text)),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void sendOrders() {}
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return FlatButton(
      padding: EdgeInsets.all(1.0),
      child: _isLoading ? CircularProgressIndicator() : Text('ЗАКАЗАТЬ СЕЙЧАС'),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () {
              setState(() {
                _isLoading = true;
              });
              Widget okButton = FlatButton(
                child: Text("OK"),
                onPressed: () {
                  if (FirebaseAuth.instance.currentUser != null) {
                    cart.items.forEach((key, value) {
                      DocumentReference docRef =
                          FirebaseFirestore.instance.collection('orders').doc();
                      docRef.set({
                        "id": value.orderId,
                        "documentId": docRef.id,
                        "size": value.sizeList.toList(),
                        "alemid": value.id,
                        "name": value.title,
                        "quantity": value.quantity,
                        "quantities": value.quantityList.toList(),
                        "price": value.price,
                        "userPhone": value.userPhone,
                        "userEmail":value.userEmail,
                        "userName":value.userName,
                        "color": value.colorList.toList(),
                        "date": DateTime.now().toString(),
                        "inProcess": false,
                        "completed": false,
                        "imgUrl": value.imgUrl,
                      });

                      FirebaseFirestore.instance
                          .collection('lastids')
                          .doc('lastIds')
                          .update({'orders': value.orderId + 1});
                    });
                  } else {
                    print('logged');
                  }

                  widget.cart.clear();
                  Navigator.of(context).pop();
                },
              );
              showAlertDialog(context, "Завершение заказа",
                  "Вы действительно хотите завершить заказ!");
              // set up the AlertDialog
              AlertDialog alert = AlertDialog(
                title: Text("Завершение заказа"),
                content: SingleChildScrollView(
                    child: Text("Вы действительно хотите завершить заказ!")),
                actions: [
                  okButton,
                ],
              );
// show the dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );

              setState(() {
                _isLoading = false;
              });
            },
      textColor: Theme.of(context).primaryColor,
    );
  }
}
