import 'package:flutter/material.dart';
import 'package:task/common/FirebaseCommon.dart';
import 'package:task/import/import.dart';
import '../menu/appbar.dart';
import '../function/functionTask.dart';

class createTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _createTask();
  }
}
class _createTask extends StatefulWidget {
  @override
  _createTaskState createState() => _createTaskState();
}

class _createTaskState extends State<_createTask> {
    String _selectedItem = "共有相手を選択";
    DateTime _StartDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0);
    DateTime _EndDay = DateTime(DateTime.now().year, DateTime.now().month + 1, DateTime.now().day, 0, 0);
    String _strStartDay = DateTime.now().year.toString() + "年" + DateTime.now().month.toString() + "月" + DateTime.now().day.toString() + "日";
    String _strEndDay = DateTime.now().year.toString() + "年" + (DateTime.now().month + 1).toString() + "月" + DateTime.now().day.toString() + "日";
    TextEditingController _taskContoroller = new TextEditingController();
    Map _setlist;
  @override
  Widget build(BuildContext context) {
    appbar _clsAppBar = new appbar();
    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      appBar: _clsAppBar.createAppbar(),
      body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder(
                  future: EntryGroupId(),
                  builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                          return Text("");
                      }
                      List _listData = snapshot.data;
                      return TextButton(
                          child: Text(_selectedItem),
                          onPressed: () async{
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                      return SimpleDialog(
                                          title: Text("タイトル"),
                                          children: <Widget>[
                                          // コンテンツ領域
                                              for(int idx = 0; _listData.length > idx; idx++)
                                                  SimpleDialogOption(
                                                      child: Text(_listData[idx]["name"]),
                                                      onPressed: () {
                                                          set(_listData[idx]);
                                                          Navigator.pop(context);
                                                      },
                                                  ),
                                          ],
                                      );
                                  },
                              );
                          },
                      );
                  }
              ),
              Container(
                
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                      TextButton(
                          child: Text(_strStartDay),
                          onPressed: () async{
                              startDateDialg(_StartDay);
                          },
                      ),
                      Text(" ~ "),
                      TextButton(
                          child: Text(_strEndDay),
                          onPressed: () async{
                              endDateDialg(_EndDay);
                          },
                      ),
                  ]
                ),
              ),
                SingleChildScrollView(
                    reverse: true,
                    child: Padding(
                        padding: EdgeInsets.only(top: 20, bottom: bottomSpace, right: 30, left: 30),
                        child: Column(
                            children:[ TextFormField(
                                controller: _taskContoroller,
                                maxLines: 10,
                                decoration: InputDecoration(
                                    labelText: 'タスク',
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey,
                                        ),
                                    ),
                                 ),
                              ),
                              TextButton(
                                  child: Text('タスクを追加する'),
                                  onPressed: (){
                                      if (_setlist == null){
                                          return;
                                      }
                                      funcTask _funcTask = new funcTask();
                                      _funcTask.createTask(_setlist, _StartDay, _EndDay, _taskContoroller.text);
                                      Navigator.pop(context);
                                  },
                              )
                          ]
                        ),
                    ),
                ),
            ],
          ),
      )
    );
  }
  Future<List> EntryGroupId() async{
    FirebaseAuth.instance;
    User _oUser = FirebaseAuth.instance.currentUser;
    List _listData = [];
    QuerySnapshot data = await FirebaseFirestore.instance
        .collection(g_strFBCollectionUsers)
        .doc(_oUser.uid)
        .collection(g_strFBCollectionEntryGroup)
        .get();
    
    String entry = data.docs[0].data()["entry"];
    QuerySnapshot datalist = await FirebaseFirestore.instance
        .collectionGroup("taskgroup")
        .where("id", isEqualTo: entry)
        .where('user_id', isNotEqualTo: _oUser.uid)
        .get();
    
    for (int index = 0; datalist.docs.length > index; index++) {
      DocumentSnapshot _DocSnap = await FirebaseFirestore.instance
          .collection(g_strFBCollectionUsers)
          .doc(datalist.docs[index].data()["user_id"])
          .get();
      Map _mapdata = {
        'id': datalist.docs[index].data()["user_id"],
        "name": _DocSnap['username'],
        "image": _DocSnap["image"],
        "other_id": _DocSnap["id"],
        "group_id": entry
      };
      
      _listData.add(_mapdata);
    }
    return _listData;
  }
  void set(Map list){
      setState((){
          _setlist = list;
          _selectedItem = list["name"];
      });
  }
    void startDateDialg(DateTime start) async {
        // showDatePicker() の引数で locale を指定
        
        var selectedDate = await showDatePicker(
            context: context,
            locale: const Locale("ja"),
            initialDate: start,
            firstDate: DateTime(DateTime.now().year, DateTime.now().month - 1),
            lastDate: DateTime(start.year + 10),
            builder: (BuildContext context, Widget widget) {
                return widget;
            },
        );
    
        if (selectedDate != null) {
            setState(() {
                _StartDay = selectedDate;
                _strStartDay = _StartDay.year.toString() + "年" + _StartDay.month.toString() + "月" + _StartDay.day.toString() + "日";
                if (_StartDay.isAfter(_EndDay)) {
                    _EndDay = _StartDay;
                    _strEndDay = _EndDay.year.toString() + "年" + _EndDay.month.toString() + "月" + _EndDay.day.toString() + "日";
                }
            });
        }
    }
    void endDateDialg(DateTime end) async {
        // showDatePicker() の引数で locale を指定
        var selectedDate = await showDatePicker(
            context: context,
            locale: const Locale("ja"),
            initialDate:  _StartDay,
            firstDate: _StartDay,
            lastDate: DateTime(_StartDay.year + 10),
            builder: (BuildContext context, Widget widget) {
                return widget;
            },
        );
        if (selectedDate != null) {
            setState(() {
                _EndDay = selectedDate;
                _strEndDay = _EndDay.year.toString() + "年" + _EndDay.month.toString() + "月" + _EndDay.day.toString() + "日";
            });
        }
    }
}
