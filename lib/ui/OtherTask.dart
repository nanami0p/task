import 'package:flutter/material.dart';
import 'package:task/common/FirebaseCommon.dart';
import 'package:task/import/import.dart';
import '../widget/widgetTaskList.dart';
class OtherTask extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return _OtherTask();
    }
}
class _OtherTask extends StatefulWidget {
    @override
    _OtherTaskState createState() => _OtherTaskState();
}

class _OtherTaskState extends State<_OtherTask> {
    @override
    Widget build(BuildContext context) {
        TaskList _clsTaskList = new TaskList();
        return  RefreshIndicator(
            onRefresh: newState,
            child: Container(
                child: _clsTaskList.list(false)
            ),
        );
    }
    Future<void> newState() async{
        setState((){
            TaskList _clsTaskList = new TaskList();
            _clsTaskList.list(false);
        });
    }
}
