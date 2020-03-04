// انشاء Widget كرت المعلومات
// من أجل عدم تكرار الكود قمنا بانشاءه مره واحده و نرسل له البيانات كل مره
import 'package:flutter/material.dart';

import 'project_theme.dart';

Widget getInfoCard(String title, String textInfo, IconData cardIcon) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: Card(
        elevation: 5,
        shape: Border(right: BorderSide(color: gold, width: 5)),
        child: ListTile(
          subtitle: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(title,
                      style: TextStyle(
                        color: gold,
                        fontSize: 12.0,
                        fontFamily: 'JFFlat',
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(textInfo,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontFamily: 'JFFlat',
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          leading: Icon(
            cardIcon,
            color: gold,
          ),
        ),
      ),
    ),
  );
}
