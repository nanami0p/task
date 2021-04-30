import 'package:flutter/material.dart';
import '../import/import.dart';
import '../function/userTable.dart';
import '../common/ViewCommon.dart';
class UserName{
    Widget NameEdit(TextEditingController controller) {
        return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: relativeWidth(16),
            ),
            child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    labelText: 'ニックネーム',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey,
                        ),
                    ),
                )
            ),
        );
    }
    
    Widget UserStatus(TextEditingController controller) {
        return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: relativeWidth(16),
            ),
            child: TextField(
                maxLines: 10,
                controller: controller,
                decoration: InputDecoration(
                    labelText: 'コメント',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey,
                        ),
                    ),
                ),
            ),
        );
    }
    
    Widget NameBtn(TextEditingController controller, User user, BuildContext context) {
        userTable _oUserData = new userTable();
        return TextButton(
            onPressed: (){
                String name = controller.text;
                _oUserData.createUserData(user, name, context).then((result) {
                });
            },
            child: Text('登録')
        );
    }
    
    Widget editNameBtn(TextEditingController namectrl, TextEditingController statusctrl, User user, BuildContext context) {
        userTable _oUserData = new userTable();
        return TextButton(
            onPressed: (){
                String name = namectrl.text;
                String status = statusctrl.text;
                _oUserData.editUserData(user, name, status, context).then((result) {
                });
            },
            child: Text('保存')
        );
    }
}