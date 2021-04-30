import 'package:flutter/material.dart';
import '../import/import.dart';
import '../widget/widgetUserName.dart';
class initPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _initPage();
  }
}

class _initPage extends StatefulWidget {
  @override
  _initPageState createState() => _initPageState();
}

class _initPageState extends State<_initPage> {
  @override
  Widget build(BuildContext context) {
    UserName _oUserName = new UserName();
    FirebaseAuth.instance;
    User _oUser = FirebaseAuth.instance.currentUser;
    final TextEditingController _textController = TextEditingController();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _oUserName.NameEdit(_textController),
            _oUserName.NameBtn(_textController, _oUser, context),
          ],
        ),
      ),
    );
  }
}

