import 'package:alemadmin/screens/home_screen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final storage = FirebaseStorage.instance;

class CategoryItem extends StatelessWidget {
  final String url;
  final String name;
  final int subcategory;
  final bool man;
  final bool woman;
  CategoryItem({this.url, this.name, this.subcategory, this.man, this.woman});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            print('surat $url alyndy');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(
                          category: false,
                          subcategory: subcategory,
                          woman: woman,
                          man: man,
                        )));
          },
          child: (url != null)
              ? Image.network(url, scale: 1.0, repeat: ImageRepeat.noRepeat)
              : Center(child: Text('Нет изображения')),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black45,
          title: Text(
            name,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
