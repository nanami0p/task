import '../function/functionMove.dart';
import '../import/import.dart';
import '../function/userTable.dart';
import '../ui/initPage.dart';
import '../ui/Home.dart';
import 'package:flutter/material.dart';

class funcSingIn {
    BuildContext _m_oContext = null;
    funcSingIn(BuildContext context) {
        _m_oContext = context;
    }
    Future<void> Signup_google() async {
        await Firebase.initializeApp();
        final GoogleSignIn _googleSignIn = GoogleSignIn();
        final FirebaseAuth _auth = await FirebaseAuth.instance;
        userTable _userTable = new userTable();
        Move _Move = new Move();
        try {
            GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
            GoogleSignInAuthentication _googleAuth = await _googleUser
                .authentication;
            // Firebaseのユーザー認証を行う証明書を取得
            final AuthCredential credential = GoogleAuthProvider.credential(
                idToken: _googleAuth.idToken,
                accessToken: _googleAuth.accessToken);
            User user = (await _auth.signInWithCredential(credential)).user;
            if (user != null) {
                _userTable.chkUserData(user).then((result){
                    if (result) {
                        return _Move.ReplaceMove(_m_oContext, Home());
                    }else{
                        return _Move.ReplaceMove(_m_oContext, initPage());
                    }
                });
            }
        } catch(e){
        
        }
    }
}