import 'package:flutter/material.dart';
import '../import/import.dart';
import '../function/functionMove.dart';
import '../function/userTable.dart';
import '../common/ViewCommon.dart';
import '../function/functionMove.dart';
import '../function/functionSingIn.dart';
class SNSButton {
    funcSingIn _funcSingIn;
    SNSButton(BuildContext context) {
        /**
         * @param cotext　BuildContext
         * */
        _funcSingIn = new funcSingIn(context);
    }
    Widget Googlebtn() {
        // 一つのgoogleボタン塊
        return TextButton(
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color:  Colors.white,
                    borderRadius: BorderRadius.circular(40),
                ),
                child:
    
                /// テキスト
                Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: relativeWidth(3.2),
                    ),
                    child: Stack(
                        children: [
                            Padding(
                                padding: EdgeInsets.only(left: relativeWidth(5)),
                                child: SizedBox(
                                    height: relativeWidth(5.8),
                                    child: Image.asset(
                                        'assets/image/google_logo.png',
                                    ),
                                ),
                            ),
                            Center(
                                child: Text(
                                    'Googleで続ける',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: relativeWidth(4.2),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "HachiMaruPop",
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            onPressed: () {
                // Googleログイン処理
                _funcSingIn.Signup_google();
            }
        );
    }
}