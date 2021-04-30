import 'package:flutter/material.dart';
import '../widget/widgetTaskList.dart';
class MyTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _MyTask();
  }
}
class _MyTask extends StatefulWidget {
  @override
  _MyTaskState createState() => _MyTaskState();
}

class _MyTaskState extends State<_MyTask> {
  @override
  Widget build(BuildContext context) {
    TaskList _clsTaskList = new TaskList();
    return RefreshIndicator(
       onRefresh: newState,
        child: Container(
            child: _clsTaskList.list(true)
      ),
    );
  }
  Future<void> newState() async{
    setState((){
        TaskList _clsTaskList = new TaskList();
        _clsTaskList.list(true);
    });
  }
  
}
