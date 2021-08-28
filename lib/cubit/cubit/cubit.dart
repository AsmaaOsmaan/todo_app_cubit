import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/cubit/cubit/states.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/presentaion/archived_screen.dart';
import 'package:todoapp/presentaion/done_screen.dart';
import 'package:todoapp/presentaion/tasks_screen.dart';

class AppCubit extends Cubit<AppStates> {
  int currentIndex = 0;
  late Database database;
  List<Task> newTasks = [];
  List<Map> tasks = [];
  List<Task> archivedTasks = [];
  List<Task> doneTasks = [];
  List<Widget> screens = [
    TasksScreen(),
    DoneScreen(),
    ArchivedScreen(),

  ];

  List<String> titles = [
    'TasksScreen',
    'DoneScreen',
    'ArchivedScreen',
  ];
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void createDatabase() {
    openDatabase('todoapp.db', version: 1, onCreate: (database, version) {
      print('database created');
      database
          .execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,note TEXT,status TEXT,startTime TEXT,endTime TEXT,date TEXT)')
          .then((val) {
        print('table created');
      }).catchError((error) {
        print(error.toString());
      });
    }, onOpen: (database) async {
      getDataFromDatabase(database);
      print('database opened');
    }).then((value) {
      database = value;
      print("database${database}");
      emit(AppCreateDataBaseState());
    });
  }

  insertToDatabase({
    required String title,
    required String note,
    required String status,
    required String startTime,
    required String endTime,
    required String date,
  }) {
    database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,note,status,startTime,endTime,date)VALUES("$title","$note","$status","$startTime","$endTime","$date")')
          .then((value) async {
        print("${value}inserted successfully");
        emit(AppInsertDataBaseState());
        getDataFromDatabase(database);

       ;
      }).catchError((error) {
        print("error.toString()${error.toString()}");
      });
      return null;
    });
  }
  /////

  ////
  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(AppGetLoadingBaseState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      tasks = value;

      //  tasks=value;
      print(tasks);
      for (var task in value) {
        if (task['status'] == 'TODO') {
          newTasks.add(Task.fromJson(task));
        } else if (task['status'] == 'Completed') {
          doneTasks.add(Task.fromJson(task));
        } else {
          archivedTasks.add(Task.fromJson(task));
        }
      }

      emit(AppGetDataBaseState());
      print("newTasks${newTasks}");
      print("doneTasks${doneTasks}");
      emit(AppGetDataBaseState());

    });
//    emit(AppGetDataBaseState())
  }

  void updateStatues({required String status, required int id}) {
    database.rawUpdate('UPDATE tasks SET statues = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDateBaseState());
    });
  }

  void delete({required int id}) {
    database.rawDelete('DELETE FROM tasks  WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteFromDateBaseState());
    });
  }

  bool isBottomSheet = false;
  IconData fabIcon = Icons.edit;
  void changeBottomSheetState({required isShow, required IconData icon}) {
    isBottomSheet = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }
}
