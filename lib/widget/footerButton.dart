import 'package:flutter/material.dart';
import '../common/ViewCommon.dart';
import '../function/functionMove.dart';
import '../ui/createTask.dart';
class footerbtn {
    Widget mytask(PageController page_controller){
        return GestureDetector(
            child: Container(
                color: Colors.transparent,
                height: relativeWidth(16),
                width: relativeWidth(36),
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                        children: [
                            Icon(Icons.assignment_ind_outlined,),
                            Text(
                                '自分のタスク',
                                style: TextStyle(
                                    fontSize: relativeWidth(2),
                                ),
                            )
                        ],
                    ),
                ),
            ),
            onTap: () {
                page_controller.animateToPage(
                    0,
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeOutCirc
                );
            },
        );
    }
    
    Widget othertask(PageController page_controller){
        return GestureDetector(
            child: Container(
                color: Colors.transparent,
                height: relativeWidth( 16),
                width: relativeWidth(36),
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    child: Column(
                        children: [
                            Icon(Icons.assignment),
                            Text(
                                '共有タスク',
                                style: TextStyle(
                                    fontSize: relativeWidth(2),
                                ),
                            )
                        ],
                    ),
                ),
            ),
            onTap: () {
                page_controller.animateToPage(
                    1,
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeOutCirc
                );
            },
        );
    }

    Widget floatingBtn(BuildContext context) {
        Move _Move = new Move();
        return TextButton(
            style: TextButton.styleFrom(
                padding: EdgeInsets.all(relativeWidth(3.6)),
                shape: const CircleBorder(
                    side: BorderSide(
                        style: BorderStyle.solid,
                    ),
                ),
                backgroundColor: Colors.blue,
            ),
            child: Icon(
                Icons.add,
                color: Colors.white,
                size: relativeWidth(10),
            ),
            onPressed: () => _Move.moveTo(context, createTask()),
        );
    }
}