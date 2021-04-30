import 'package:flutter/material.dart';
import '../import/import.dart';
import "../common/FirebaseCommon.dart";
import '../common/ViewCommon.dart';
import '../ui/SignInGroup.dart';
import '../function/functionMove.dart';
import '../ui/createGroup.dart';
class drawer{
    Widget widgetDrawer(BuildContext context) {
        FirebaseAuth.instance;
        User _oUser = FirebaseAuth.instance.currentUser;
        return Drawer(
            child: Column(
              children:[
                  DrawerHeader(
                      child: Container(
                          width: double.infinity,
                          child: Text('ヘッダー')
                      ),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                      ),
                  ),
                  Expanded(
                    child: PaginateFirestore(
                        itemBuilderType:  PaginateBuilderType.listView,
                        query: FirebaseFirestore.instance
                            .collection(g_strFBCollectionUsers)
                            .doc(_oUser.uid)
                            .collection("taskgroup"),
                        itemsPerPage: 10,
                        itemBuilder: (index, context, documentSnapshot) {
                            return ListTile(
                                title: Text(documentSnapshot.data()["name"]),
                               onTap: () async{
                                   await FirebaseFirestore
                                       .instance
                                       .collection(g_strFBCollectionUsers)
                                       .doc(_oUser.uid)
                                       .collection("entrygroup")
                                       .doc("entry")
                                       .set({
                                       "entry": documentSnapshot.data()["id"],
                                   });
                               },
                            );
                        }
                    ),
                  ),
                  Row(
                      children: [
                          Expanded(
                              flex: 1,
                              child: Column(
                                  children: [
                                      IconButton(
                                          icon: Icon(Icons.add_box_outlined),
                                          onPressed: () {
                                            Move _Move = new Move();
                                            _Move.moveTo(context, SignGroup());
                                          }
                                      ),
                                      Text("参加")
                                  ],
                              ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Column(
                                  children: [
                                      IconButton(
                                          icon: Icon(Icons.add_box),
                                          onPressed: () {
                                              Move _Move = new Move();
                                              _Move.moveTo(context, createGroup());
                                            }
                                      ),
                                      Text("新規作成")
                                  ],
                              ),
                          )
                      ],
                  ),
                  SizedBox(height: relativeWidth(10)),
                  
              ]
            ),
        );
    }
}