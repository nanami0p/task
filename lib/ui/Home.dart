import 'package:flutter/material.dart';
import 'package:task/common/FirebaseCommon.dart';
import 'package:task/import/import.dart';
import 'MyTask.dart';
import 'OtherTask.dart';
import '../menu/footer.dart';
import '../common/ViewCommon.dart';
import '../menu/appbar.dart';
import '../menu/drawer.dart';
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    loadScrenData(context);
    return _Home();
  }
  
}

class _Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: 0);
    appbar _appbar = new appbar();
    drawer _drawer = new drawer();
    footerMenu _ofooter = new footerMenu();
    return Scaffold(
      appBar: _appbar.appHomebar(),
      drawer: _drawer.widgetDrawer(context),
      body: PageView(
        controller: pageController,
        children: [
          MyTask(),
          OtherTask(),
        ],
      ),
      // fottermenuから呼び出し
      bottomNavigationBar: _ofooter.myNavigationBar(pageController),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _ofooter.floatingBtn(context),
    );
  }
}

