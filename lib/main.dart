import 'package:flutter/material.dart';
import 'import/import.dart';
import 'function/function_chkGroup.dart';
import 'ui/Home.dart';
import 'ui/Sign_up.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() async {
  // 起動時にエラーを発生させないために必要
  WidgetsFlutterBinding.ensureInitialized();
  // 画面縦向き固定
  
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    FirebaseAuth.instance;
    User _oUser = FirebaseAuth.instance.currentUser;
    
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("en"),
        const Locale("ja"),
      ],
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _chkSign(_oUser, context),
    );
  }
  
  _chkSign(User user, BuildContext context){
    chkGroup _clsChkGroup = new chkGroup();
    if (user != null) {
      return Home();
    }
    else {
      return SignUp();
    }
  }
}