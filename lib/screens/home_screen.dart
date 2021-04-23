import 'package:alemadmin/screens/search_screen/search_screen.dart';
import 'package:alemadmin/widgets/app_bar.dart';
import 'package:alemadmin/widgets/app_drawer.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'category_screen/components/category_grid_view.dart';
import 'favorites_screen/favorite.dart';
import 'login_and_regis/main_login.dart';
import 'subcategory/supacategory_screen.dart';

final _firestore = FirebaseFirestore.instance;

class HomeScreen extends StatefulWidget {
  final bool category;
  final int subcategory;
  final int tabIndex;
  final bool man;
  final bool woman;
  HomeScreen(
      {this.category = true,
      this.subcategory,
      this.tabIndex = 0,
      this.man = true,
      this.woman = true});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;
  int _saylananIndex;
  List<Map<String, Object>> _sahypalar;
  bool filterMan;
  bool filterWoman;
  int genderFilter = 0;

  void changeGenderFilter(int gender) {
    setState(() {
      switch (gender) {
        case 1:
          filterMan = !filterMan;
          genderFilter = 1;
          if (filterWoman && filterMan) {
            genderFilter = 0;
          }
          break;
        case 2:
          filterWoman = !filterWoman;
          genderFilter = 2;
          if (filterWoman && filterMan) {
            genderFilter = 0;
          }
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.setPersistence(Persistence.NONE);
    filterMan = widget.man;
    filterWoman = widget.woman;
    controller = new TabController(length: 4, vsync: this);
    _saylananIndex = widget.tabIndex;
    _sahypalar = [
      {
        'sahypa': widget.category
            ? CategoryGridView(
                woman: widget.man,
                man: widget.woman,
              )
            : SubCategory(
                subcategory: widget.subcategory,
                genderFilter: genderFilter,
              ),
        'renk': Colors.deepOrange,
      },
      {'sahypa': Search(), 'renk': Colors.deepOrange},
      {'sahypa': FavoritePage(), 'renk': Colors.deepOrange},
      {'sahypa': MainLoginPage(), 'renk': Colors.deepOrange}
    ];
  }

  void sahCals(int index) {
    setState(() {
      _saylananIndex = index;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  showAlertDialog(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context),
        drawer: AppDrawer(
          genderChanger: changeGenderFilter,
          man: widget.man,
          woman: widget.woman,
        ),
        body: _sahypalar[_saylananIndex]['sahypa'],
        bottomNavigationBar: Material(
          color: Colors.white,
          child: TabBar(
            labelColor: Colors.orange,
            onTap: (index) {
              sahCals(index);
            },
            controller: controller,
            indicatorColor: _sahypalar[_saylananIndex]['renk'],
            tabs: [
              Tab(
                icon: Icon(Icons.home,
                    color: _saylananIndex == 0 ? Colors.orange : Colors.orange),
              ),
              Tab(
                icon: Icon(Icons.search,
                    color: _saylananIndex == 1 ? Colors.orange : Colors.orange),
              ),
              Tab(
                icon: Icon(Icons.star,
                    color: _saylananIndex == 2 ? Colors.orange : Colors.orange),
              ),
              Tab(
                icon: Icon(Icons.person,
                    color: _saylananIndex == 3 ? Colors.orange : Colors.orange),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
