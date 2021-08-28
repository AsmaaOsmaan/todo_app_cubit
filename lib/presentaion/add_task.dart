import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/cubit/cubit/cubit.dart';
import 'package:todoapp/cubit/cubit/states.dart';
import 'package:todoapp/widgets/button.dart';
import 'package:todoapp/widgets/custom_input_field.dart';

import '../theme.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();

  TextEditingController noteController = TextEditingController();

  String _startTime = "8:30 AM";

  String _endTime = "9:30 AM";

  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context,AppStates state){
          if (state is AppInsertDataBaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context,AppStates state){
         return Scaffold(
           //   appBar: _appBar(),
           body: Container(
             padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
             child: SingleChildScrollView(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   GestureDetector(
                       onTap: () {
                         Navigator.pop(context);
                       },
                       child: Icon(
                         Icons.arrow_back_ios,
                         color: primaryClr,
                       )),
                   SizedBox(
                     height: 8.0,
                   ),
                   Text(
                     "Add Task",
                     style: headingTextStyle,
                   ),
                   InputField(
                     title: "Title",
                     controller: titleController,
                     hint: "Enter title",
                   ),
                   InputField(
                       title: "Note",
                       controller: noteController,
                       hint: "Enter note"),
                   InputField(
                     title: "Date",
                     hint: DateFormat.yMd().format(_selectedDate),

                     widget: IconButton(
                       icon: (Icon(
                         FlutterIcons.calendar_ant,
                         color: Colors.grey,
                       )),
                       onPressed: () {
                         //  _showDatePicker(context);
                         _getDateFromUser();
                       },
                     ),
                   ),
                   Row(
                     children: [
                       Expanded(
                         child: InputField(
                           title: "Start Time",
                           // controller: titleController,
                           hint: _startTime,
                           // hint: _startTime,
                           widget: IconButton(
                             icon: (Icon(
                               FlutterIcons.clock_faw5,
                               color: Colors.grey,
                             )),
                             onPressed: () {
                               _getTimeFromUser(isStartTime: true);
                             },
                           ),
                         ),
                       ),
                       SizedBox(
                         width: 12,
                       ),
                       Expanded(
                         child: InputField(
                           title: "End Time",
                           hint: _endTime,
                          /// controller: titleController,
                           widget: IconButton(
                             icon: (Icon(
                               FlutterIcons.clock_faw5,
                               color: Colors.grey,
                             )),
                             onPressed: () {
                               _getTimeFromUser(isStartTime: false);
                             },
                           ),
                         ),
                       )
                     ],
                   ),
                   MyButton(onTap: ()async{
                     print("title${titleController.text}");
                     print("note${noteController.text}");
                     print("startTime${_startTime}");
                     print("endTime${_endTime}");
                     print("selected${_selectedDate}");

                      AppCubit.get(context).insertToDatabase(title:titleController.text, note: noteController.text, status: "TODO", startTime: _startTime, endTime: _endTime, date: DateFormat.yMd().format(_selectedDate),);

                   }, label: "Create Task")

                 ],
               ),
             ),
           ),
         );
        },

      ),
    );
  }
  _getTimeFromUser({required bool isStartTime}) async {
    var _pickedTime = await _showTimePicker();
    print(_pickedTime.format(context));
    String _formatedTime = _pickedTime.format(context);
    print(_formatedTime);
    if (_pickedTime == null)
      print("time canceld");
    else if (isStartTime)
      setState(() {
        _startTime = _formatedTime;
      });
    else if (!isStartTime) {
      setState(() {
        _endTime = _formatedTime;
      });
      //_compareTime();
    }
  }
  _showTimePicker() async {
    return showTimePicker(
      initialTime: TimeOfDay(hour: 8, minute: 30),
      initialEntryMode: //TimePickerEntryMode.dial,
     TimePickerEntryMode.input,
      context: context,
    );
  }

  _getDateFromUser() async {
    final DateTime? _pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (_pickedDate != null) {
      setState(() {
        _selectedDate = _pickedDate;
      });
    }
  }
}
