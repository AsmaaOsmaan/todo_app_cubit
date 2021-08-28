

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/cubit/cubit/cubit.dart';
import 'package:todoapp/cubit/cubit/states.dart';
import 'package:todoapp/presentaion/add_task.dart';
import 'package:todoapp/widgets/button.dart';

import '../size_config.dart';
import '../theme.dart';
class HomeLayOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BlocProvider(
      create: (BuildContext context)=>AppCubit()..createDatabase(),

      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context,AppStates state){
          // if (state is AppInsertDataBaseState){
          //
          // //  Navigator.pop(context);
          // }
        },
          builder: (BuildContext context,AppStates state){
            AppCubit cubit=AppCubit.get(context);

            return Scaffold(
              appBar: AppBar(
                title: Row(
               //   crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("My Tasks",style: headingTextStyle,),
                    MyButton(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddTask()),
                        );
                      },
                      label: '+ Add Task',
                    )
                  ],
                ),
               // leading: Text("Tasks",style: headingTextStyle,),
                elevation: 0,
                backgroundColor: Colors.white12,
                // actions: [
                //   MyButton(
                //     onTap: (){
                //
                //     },
                //     label: 'Add Task',
                //   )
                // ],
              ),
           body: cubit.screens[cubit.currentIndex],

           bottomNavigationBar: BottomNavigationBar(
             items: [
               BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
               BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Done'),
               BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'Archived'),
             ],
             onTap: (index) {
               cubit.changeIndex(index);

             },
             currentIndex: cubit.currentIndex,
           ),
         );
          }

      ),
    );
  }
}
