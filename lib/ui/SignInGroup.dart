import 'package:flutter/material.dart';
import 'package:task/common/FirebaseCommon.dart';
import '../common/ViewCommon.dart';
import '../import/import.dart';
class SignGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _SignGroup();
  }
}
class _SignGroup extends StatefulWidget {
  @override
  _SignGroupState createState() => _SignGroupState();
}

class _SignGroupState extends State<_SignGroup> {
  @override
  Widget build(BuildContext context) {
      TextEditingController _IDcontroller = new TextEditingController();
      TextEditingController _PASScontroller = new TextEditingController();
      return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                        horizontal: relativeWidth(16),
                        ),
                        child: TextField(
                          controller: _IDcontroller,
                          decoration: InputDecoration(
                              labelText: 'GROUP_ID',
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey,
                                  ),
                              ),
                          )
                        ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: relativeWidth(16),
                        ),
                        child: TextField(
                            controller: _PASScontroller,
                            decoration: InputDecoration(
                                labelText: 'PASS',
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey,
                                    ),
                                ),
                            )
                        ),
                    ),
                    TextButton(
                        child: Text("参加する"),
                        onPressed: (){
                            sign(_IDcontroller.text, _PASScontroller.text);
                            Navigator.pop(context);
                        },
                    ),
                ]
            ),
        ),
      );
  }
  Future sign(String id, String pass) async {
      FirebaseAuth.instance;
      User _oUser = FirebaseAuth.instance.currentUser;
      
      QuerySnapshot group = await FirebaseFirestore
          .instance
          .collection(g_strFBCollectionGroup)
          .where("group_id", isEqualTo: id)
          .where("pass", isEqualTo: pass)
          .get();
        if (group.docs.isEmpty) {
            return;
        }
      await FirebaseFirestore
          .instance
          .collection(g_strFBCollectionUsers)
          .doc(_oUser.uid)
          .collection(g_strFBCollectionEntryGroup)
          .doc("entry")
          .set({
                "entry": group.docs[0].data()["id"]
          });

      QuerySnapshot signed = await FirebaseFirestore
          .instance
          .collection(g_strFBCollectionUsers)
          .doc(_oUser.uid)
          .collection("taskgroup")
          .where("id", isEqualTo: group.docs[0].data()["id"])
          .get();
      if (!signed.docs.isEmpty) {
          return;
      }
      await FirebaseFirestore
          .instance
          .collection(g_strFBCollectionUsers)
          .doc(_oUser.uid)
          .collection("taskgroup")
          .doc()
          .set({
          "id": group.docs[0].data()["id"],
          "name": group.docs[0].data()["name"],
          "user_id": _oUser.uid
      });
  }
}
