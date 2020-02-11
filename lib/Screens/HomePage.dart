import 'package:flutter/material.dart';

import '../NavigationDrawer.dart';

class HomePage extends StatefulWidget {
  // قمنا بتعريف key كإسم للصفحة الرئيسية من أجل استدعاء الشاشاه للانتقال اليها
  static const id = "MyHomePage_screen";
  HomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TU RFID Attendance'),
      ),
      drawer: Drawer(
        child: NavigationDrawer(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'هنا سيظهر محتوى التطبيق',
            ),
            Text(
              '',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
