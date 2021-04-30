import "package:flutter/material.dart";
import '../import/import.dart';
import '../function/functionMove.dart';
import '../function/userTable.dart';
import '../widget/widgetSnsButton.dart';
import '../common/ViewCommon.dart';
class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Sign_up();
  }
}

class _Sign_up extends StatefulWidget {
  @override
  _Sign_upState createState() => _Sign_upState();
}

class _Sign_upState extends State<_Sign_up> {
  @override
  Widget build(BuildContext context) {
      loadScrenData(context);
      SNSButton _SNSButton = new SNSButton(context);
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Center(
                  child:  _SNSButton.Googlebtn(),
                ),
            ]
        ),
    );
  }
}
