import '../import/import.dart';
import '../common/FirebaseCommon.dart';
class chkGroup {
    Future<QuerySnapshot> Group(User _user) async{
      QuerySnapshot _data =  await FirebaseFirestore.instance
            .collection(g_strFBCollectionUsers)
            .doc(_user.uid)
            .collection(g_strFBCollectionEntryGroup)
            .get();
      
      return _data;
    }
}