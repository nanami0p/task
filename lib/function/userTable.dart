import 'package:flutter/material.dart';
import '../import/import.dart';
import '../ui/Home.dart';
import 'functionMove.dart';

class userTable{
    Future<bool> chkUserData(User user) async {
        DocumentSnapshot data = await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid).get();
        if (data.data() != null) {
            return true;
        }
        return false;
    }
    Future<bool> createUserData(User user, String name, BuildContext context) async {
        Move _Move = new Move();
        DocumentSnapshot data = await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .set(
            {
                "id": user.uid,
                "username": name,
                'image': ''
            })
            .then((content) {
            _Move.ReplaceMove(context, Home());
        });
    }

    Future<bool> editUserData(User user, String name, String status, BuildContext context) async {
        Move _Move = new Move();
        DocumentSnapshot _userData = await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get();
    
        String _name = _userData["username"];
        String _status = _userData["status"];
    
        if (name == ""){
            name = _name;
        }
        if (status == "") {
            status = _status;
        }
        DocumentSnapshot data = await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .update(
            {
                "username" : name,
                "status" : status
            })
            .then((content) {
            //_Move.ReplaceMove(context, Profile());
        });
    
    }
}