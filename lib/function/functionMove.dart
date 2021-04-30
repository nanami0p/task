import 'package:flutter/material.dart';
class Move{
    void moveTo(BuildContext context, Widget pushPage) {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pushPage),
        );
    }
    // 前ページを削除して遷移
    void ReplaceMove(BuildContext context, Widget pushPage) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => pushPage),
        );
    }
}