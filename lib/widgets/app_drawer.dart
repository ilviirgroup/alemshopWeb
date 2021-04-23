import 'package:alemadmin/screens/contacts/about_us.dart';
import 'package:alemadmin/screens/contacts/contacts.dart';
import 'package:alemadmin/screens/home_screen.dart';
import 'package:alemadmin/screens/my_orders/my_ordersScreen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

final user = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class AppDrawer extends StatefulWidget {
  final Function genderChanger;
  final bool man;
  final bool woman;
  AppDrawer({this.genderChanger, this.man, this.woman});
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool filterMan;
  bool filterWoman;
  String userName = '';
  @override
  void initState() {
    if (user.currentUser != null) {
      userName = user.currentUser.email;
    } else {
      userName = "";
    }
    filterWoman = widget.woman;
    filterMan = widget.man;
    super.initState();
  }

  // void _singOut() {
  //   FirebaseAuth.instance.signOut();
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/world.jpg"), fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ColorizeAnimatedTextKit(
                  repeatForever: true,
                  text: ["ALEM", "SHOP"],
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    fontFamily: 'Quicksand',
                  ),
                  colors: [
                    Colors.purple,
                    Colors.blue,
                    Colors.yellow,
                    Colors.red,
                  ],
                ),
                CircleAvatar(
                  radius: 20,
                  child: Icon(Icons.person),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  userName ?? '',
                  style: TextStyle(color: Colors.orange[700]),
                )
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('update').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }
              final update = snapshot.data.docs.reversed.first.data()['update'];

              if (update) {
                return ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen(
                                  category: true,
                                )));
                  },
                  title: Text(
                    'Обновление доступно',
                    style: TextStyle(color: Colors.red),
                  ),
                  leading: Icon(Icons.warning),
                );
              } else {
                return Container();
              }
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(
                            category: true,
                          )));
            },
            title: Text('Alem shop',
                style: TextStyle(fontWeight: FontWeight.w600)),
            leading: Icon(Icons.home),
          ),
          ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUs()));
              },
              title:
                  Text('О нас', style: TextStyle(fontWeight: FontWeight.w600)),
              leading: Icon(Icons.info_rounded)),

          ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Contacts()),
                );
              },
              title: Text('Контакты',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              leading: Icon(Icons.email)),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyOrders()));
            },
            title: Text('Мои заказы',
                style: TextStyle(fontWeight: FontWeight.w600)),
            leading: Icon(Icons.shop),
          ),
          ListTile(
              onTap: () {
                Navigator.pop(context);
                user.signOut();
              },
              title:
                  Text('Выйти', style: TextStyle(fontWeight: FontWeight.w600)),
              leading: Icon(Icons.logout)),
          // ListTile(
          //     onTap: () {
          //       _singOut();
          //     },
          //     title:
          //         Text('Выйти', style: TextStyle(fontWeight: FontWeight.w600)),
          //     leading: Icon(Icons.logout)),
          Divider(),
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('category').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }
              final categories = snapshot.data.docs.reversed;
              List<ListTile> categoryList = [];
              for (var category in categories) {
                final url = category.data()['url'];
                final name = category.data()['name'];
                final subcategory = category.data()['id'];

                final categoryitem = ListTile(
                  leading: Icon(Icons.account_tree),
                  title: Text(name ?? "",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen(
                                category: false, subcategory: subcategory)));
                  },
                );

                categoryList.add(categoryitem);
              }
              return Column(
                children: categoryList,
              );
            },
          ),

          /* Row(
            children: [
              Expanded(
                child: ListTile(
                  contentPadding: EdgeInsets.all(5),
                  title: Text("мужской"),
                  trailing: Checkbox(
                    value: filterMan,
                    onChanged: (val){
                      filterMan=!filterMan;
                      widget.genderChanger(1);
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text("женщинский"),
                  trailing: Checkbox(
                    value: filterWoman,
                    onChanged: (val){
                      filterWoman=!filterWoman;
                      widget.genderChanger(2);
                    },
                  ),
                ),
              ),
            ],
          )*/
        ],
      ),
    );
  }
}
