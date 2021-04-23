import 'package:alemadmin/screens/favorites_screen/companents/favorite_gridviev.dart';

import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return FavCategoryGridView();
  }
}
