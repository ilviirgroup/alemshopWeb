import 'package:alemadmin/screens/login_and_regis/Regis_page.dart';
import 'package:alemadmin/screens/login_and_regis/login_page.dart';

import 'package:flutter/material.dart';

class MainLoginPage extends StatefulWidget {
  @override
  _MainLoginPageState createState() => _MainLoginPageState();
}

class _MainLoginPageState extends State<MainLoginPage> {
  bool loginSah = true;
  List<Map<String, Object>> _sahypalar;
  void sahCals() {
    setState(() {
      loginSah = !loginSah;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _sahypalar = [
      {
        'sahypa': LoginPage(sahCals),
      },
      {
        'sahypa': RegPage(sahCals),
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    return loginSah ? _sahypalar[0]['sahypa'] : _sahypalar[1]['sahypa'];
  }
}
