import 'package:flutter/material.dart';
import 'package:task/common/FirebaseCommon.dart';
import '../import/import.dart';
import 'package:intl/intl.dart';
import '../function/functionTask.dart';
class TaskList {
    Widget list(bool turn) {
        FirebaseAuth.instance;
        User _oUser = FirebaseAuth.instance.currentUser;
        funcTask _funcTask = new funcTask();
        return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(g_strFBCollectionUsers)
                .doc(_oUser.uid)
                .collection(g_strFBCollectionEntryGroup)
                .snapshots(),
            builder: (context, snapshot){
                if (!snapshot.hasData) {
                    return Text("");
                }
                if (snapshot.data.documents.length == 0) {
                    return Center(child: Text("所属がありません"));
                }
                String _strEntryGroup = snapshot.data.documents[0]["entry"];
                
                return PaginateFirestore(
                    itemBuilderType:  PaginateBuilderType.listView,
                    query: FirebaseFirestore.instance
                        .collection(g_strFBCollectionUsers)
                        .doc(_oUser.uid)
                        .collection("task")
                        .where('group_id', isEqualTo: _strEntryGroup)
                        .where('cmp', isEqualTo: false)
                        .where('turn', isEqualTo: turn)
                        .orderBy('limit', descending: false),
                    itemsPerPage: 10,
                    itemBuilder: (index, context, documentSnapshot) {
                        Map _mapData = documentSnapshot.data();
                        String _strTask =  _mapData["task"];
                        String _strOtherId =  _mapData["id"];
                        String _strStartTime =  DateFormat("yyyy/MM/dd").format( _mapData["start"].toDate()).toString();
                        String _strLimitTime =  DateFormat("yyyy/MM/dd").format( _mapData["limit"].toDate()).toString();
                        Widget trailing = null;
                        if (turn) {
                            trailing = PopupMenuButton(
                                itemBuilder: (context) {
                                    return [
                                        PopupMenuItem(
                                            child: TextButton(
                                                child: Text("送信"),
                                                onPressed: (){
                                                    String _strDocId = documentSnapshot.id;
                                                    _funcTask.UpDataTask(_mapData, _strDocId);
                                                    return;
                                                }
                                            ),
                                        ),
                                    ];
                                });
                        }
                        else {
                            trailing = Text("");
                        }
                        return ListTile(
                            leading: Container(
                                child: FutureBuilder(
                                    future: userdata(_strOtherId),
                                    builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                            return Text("");
                                        }
                                        String _name = snapshot.data['name'];
                                        return Text(_name);
                                    }
                                ),
                            ),
                            title: Text(_strTask),
                            subtitle: Text(_strStartTime + "~" + _strLimitTime),
                            trailing: trailing,
                        );
                    }
                );
            }
        );
    }
    Future<Map> userdata(String id) async{
        DocumentSnapshot s = await FirebaseFirestore.instance
            .collection(g_strFBCollectionUsers)
            .doc(id)
            .get();
        var name = s['username'];
        Map _map = {
            'name': name
        };
        return _map;
    }

  
 
}