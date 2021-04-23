import 'package:flutter/material.dart';

class Subcategory with ChangeNotifier {
  final String id;
  final String alemid;
  final String name;
  final String descrip;
  final String quantity;
  final String price;
  final String color;
  final String size;
  final String status;
  bool isFavorite;

  Subcategory({
    @required this.id,
    @required this.alemid,
    @required this.name,
    @required this.descrip,
    @required this.quantity,
    @required this.price,
    @required this.color,
    @required this.size,
    @required this.status,
    this.isFavorite = false,
  });
  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id: json['id'] as String,
      alemid: json['alemid'] as String,
      name: json['name'] as String,
      descrip: json['descrip'] as String,
      quantity: json['quantity'] as String,
      price: json['price'] as String,
      color: json['color'] as String,
      size: json['size'] as String,
      status: json['status'] as String,
    );
  }

  void _setFavValue(bool value) {
    isFavorite = value;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    /*  final url = 'https://flutter-update.firebaseio.com/products/$id.json';
    try {
      final response = await http.patch(
        url,
        body: json.encode({
          'isFavorite': isFavorite,
        }),
      );
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }*/
  }
}
