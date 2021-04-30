import '../import/import.dart';
import '../common/FirebaseCommon.dart';
import 'package:uuid/uuid.dart';
class funcTask {
    void createTask(Map list, DateTime start, DateTime end, String task) async{
        FirebaseAuth.instance;
        User _oUser = FirebaseAuth.instance.currentUser;
        var uuid = Uuid().v1();
        // 登録者側のtaskに追加
         await FirebaseFirestore.instance
            .collection(g_strFBCollectionUsers)
            .doc(_oUser.uid)
            .collection("task")
            .doc(uuid)
            .set({
            "id": list["other_id"],
            "group_id": list["group_id"],
            "start": start,
            "limit": end,
            "task": task,
            "turn": true,
            "cmp": false,
        });
        
        // task共有者側に追加
        await FirebaseFirestore.instance
            .collection(g_strFBCollectionUsers)
            .doc(list["other_id"])
            .collection("task")
            .doc(uuid)
            .set({
            "id": _oUser.uid,
            "group_id": list["group_id"],
            "start": start,
            "limit": end,
            "task": task,
            "turn": false,
            "cmp": false,
        });
    }
    void UpDataTask(Map data, String docid) async{
        FirebaseAuth.instance;
        User _oUser = FirebaseAuth.instance.currentUser;
        await FirebaseFirestore.instance
            .collection(g_strFBCollectionUsers)
            .doc(_oUser.uid)
            .collection("task")
            .doc(docid)
            .update({
            "id": data['id'],
            "group_id": data["group_id"],
            "start": data["start"],
            "limit": data["limit"],
            "task": data["task"],
            "turn": false,
            "cmp": false,
        });
        await FirebaseFirestore.instance
            .collection(g_strFBCollectionUsers)
            .doc(data['id'])
            .collection("task")
            .doc(docid)
            .update({
            "id": _oUser.uid,
            "group_id": data["group_id"],
            "start": data["start"],
            "limit": data["limit"],
            "task": data["task"],
            "turn": true,
            "cmp": false,
        });
            
    }
}