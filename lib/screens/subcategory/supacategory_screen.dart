import 'package:alemadmin/screens/subcategory/components/subcategory_grid_view.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

class SubCategory extends StatefulWidget {
  final int subcategory;
  final int genderFilter;
  SubCategory({this.subcategory, this.genderFilter = 0});

  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  int subId;

  @override
  void initState() {
    super.initState();
  }

  void changeSub(int id) {
    setState(() {
      subId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(subId);
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('subcategory').orderBy('id').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final categories = snapshot.data.docs.reversed;
        List<GestureDetector> subCategoryList = [];
        for (var categoryId in categories) {
          final category = categoryId.data()['category'];
          final name = categoryId.data()['name'];
          final id = categoryId.data()['id'];

          if (category == widget.subcategory) {
            if (subId == null) {
              subId = id;
            }
            final categoryitem = subcategoryButton(name: name, id: id);
            subCategoryList.add(categoryitem);
          }
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                  height: 30,
                  child: ListView.builder(
                    itemCount: subCategoryList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) => subCategoryList[i],
                  )),
            ),
            Expanded(
                child: SubCategoryGridView(
              subId: subId,
              gender: widget.genderFilter,
            ))
          ],
        );
      },
    );
  }

  Widget subcategoryButton({String name, int id}) {
    return GestureDetector(
      child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 25),
          child: Text(
            name,
            style: TextStyle(color: Colors.blue, fontSize: 16.0),
          )),
      onTap: () {
        changeSub(id);
      },
    );
  }
}
