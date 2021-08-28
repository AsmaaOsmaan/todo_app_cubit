
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/cubit/cubit/cubit.dart';
import 'package:todoapp/cubit/cubit/states.dart';

import 'build_empty_list.dart';
class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){

      },
      builder: (context,state){
        var tasks=AppCubit.get(context).newTasks;
        print("LengthTasks${tasks.length}");

        return  tasksBuilder(tasks: tasks,);
      },

    );
  }
}
