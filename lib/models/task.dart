class Task {
  late int id;
  late String title;
  late String note;
  //int isCompleted;
  late String  status;
  late String date;
  late  String startTime;
  late String endTime;
  //int color;
  //int remind;
 // String repeat;

  Task({
    required this.id,
    required this.title,
    required this.note,
    required this.status,
    required this.date,
    required this.startTime,
    required this.endTime,
   // this.color,

  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    status = json['status'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    // color = json['color'];
    // remind = json['remind'];
    // repeat = json['repeat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.date;
    data['note'] = this.note;
    data['Status'] = this.status;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;

    return data;
  }
}
