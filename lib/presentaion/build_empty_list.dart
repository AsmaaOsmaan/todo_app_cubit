import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/widgets/task_tile.dart';

class tasksBuilder extends StatelessWidget {
  final List <Task>tasks;
  tasksBuilder({required this.tasks});
  @override
  Widget build(BuildContext context) {
    return  BuildCondition(
      condition: //true,
      tasks.length>0,
      builder: (context){
        return  ListView.separated(itemBuilder: (context,index)=>TaskTile(tasks[index]), separatorBuilder: (context,index)=>Container(
          color: Colors.grey[300],
          height: 1.0,
          width: double.infinity,
        ), itemCount: tasks.length
        );
      },
      fallback: (context){
        return  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu,
                size: 100.0,
                color: Colors.grey,
              ),
              Text(
                'No Tasks Yet, Please Add Some Tasks',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
