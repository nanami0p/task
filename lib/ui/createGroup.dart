import 'package:flutter/material.dart';
import 'package:task/common/FirebaseCommon.dart';
import '../common/ViewCommon.dart';
import '../import/import.dart';
import 'package:uuid/uuid.dart';
class createGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _craeteGroup();
  }
}

class _craeteGroup extends StatefulWidget {
  @override
  _craeteGroupState createState() => _craeteGroupState();
}

class _craeteGroupState extends State<_craeteGroup> {
  @override
  Widget build(BuildContext context) {
      TextEditingController _IDcontroller = new TextEditingController();
      TextEditingController _Passcontroller = new TextEditingController();
      TextEditingController _Namecontroller = new TextEditingController();
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
                            controller: _Namecontroller,
                            decoration: InputDecoration(
                                labelText: 'グループ名',
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
                            controller: _Passcontroller,
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
                        child: Text("作成する"),
                        onPressed: (){
                            create(_Namecontroller.text, _IDcontroller.text, _Passcontroller.text);
                            Navigator.pop(context);
                        },
                    ),
                ]
            ),
        ),
    );
  }
  
  Future create(String name, String id, String pass) async{
      FirebaseAuth.instance;
      User _oUser = FirebaseAuth.instance.currentUser;
      
      QuerySnapshot group = await FirebaseFirestore.instance
          .collection(g_strFBCollectionGroup)
          .where('group_id', isEqualTo: id)
          .get();
      if (!group.docs.isEmpty) {
          return;
      }
      var uuid = Uuid().v1();
      await FirebaseFirestore.instance
          .collection(g_strFBCollectionGroup)
          .doc()
          .set({
            'group_id': id,
            'name': name,
            'pass': pass,
            'id': uuid
      });
      

      await FirebaseFirestore
          .instance
          .collection(g_strFBCollectionUsers)
          .doc(_oUser.uid)
          .collection("taskgroup")
          .doc()
          .set({
          "id": uuid,
          "name": name,
          "user_id": _oUser.uid
      });

      await FirebaseFirestore
          .instance
          .collection(g_strFBCollectionUsers)
          .doc(_oUser.uid)
          .collection("entrygroup")
          .doc("entry")
          .set({
          "entry": uuid,
      });
      
  }
}

