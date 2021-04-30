import "package:flutter/material.dart";
import "../common/ViewCommon.dart";
import '../import/import.dart';
import '../common/FirebaseCommon.dart';
class appbar{
    Widget appHomebar() {
        String GroupName = "";
        return AppBar(
            backgroundColor: Colors.blue,
            title: Align(
                alignment: Alignment.centerLeft,
                child: FutureBuilder(
                    future: Groupname(),
                    builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                            return Text("");
                        }
                        if (snapshot.data != null) {
                            GroupName = snapshot.data;
                        }
                        return Text(
                            GroupName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: relativeWidth(5),
                            ),
                        );
                    }
                )
            ),
        );
    }

    Widget createAppbar() {
        return AppBar(
            backgroundColor: Colors.blue,
            title: Align(
                alignment: Alignment.centerLeft,
                child: Text("タスク作成"),
            ),
        );
    }
    Future<String> Groupname() async{
        FirebaseAuth.instance;
        User _oUser = FirebaseAuth.instance.currentUser;
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection(g_strFBCollectionUsers)
            .doc(_oUser.uid)
            .collection(g_strFBCollectionEntryGroup)
            .get();
        String _strGroup = snapshot.docs[0].data()["entry"];
        QuerySnapshot  snap = await FirebaseFirestore.instance
            .collection(g_strFBCollectionGroup)
            .where("id", isEqualTo: _strGroup)
            .get();
    
        return snap.docs[0]["name"];
    }
}