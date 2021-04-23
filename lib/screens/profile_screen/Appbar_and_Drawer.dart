import 'package:flutter/material.dart';


// ignore: must_be_immutable
class CostumListTile extends StatelessWidget {
  IconData icon;
  IconData icons;
  String text;
  Function onTap;
  CostumListTile({this.icon,this.icons,this.text,this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color:Colors.grey.shade400))
        ),
        child: InkWell(
          //splashColor: Colors.blueAccent,
          onTap: onTap,
          child: Container(
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(text,style: TextStyle(
                        fontSize: 17,
                      ),),
                    ),
                  ],
                ),
                Icon(icons,color: Colors.black,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}