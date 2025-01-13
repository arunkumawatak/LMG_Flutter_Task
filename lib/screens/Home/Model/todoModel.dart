class TodoModel {
  int? id;
  String title;
  String description;
  int? status; // 0: TODO [not done], 1: In-Progress, 2: Done
  int? time;
  TodoModel({
    this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'time': time,
    };
  }

  static TodoModel fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] is int
          ? map['id'] as int
          : int.tryParse(map['id'].toString()),
      title: map['title'] as String,
      description: map['description'] as String,
      time: map['time'] is int
          ? map['time'] as int
          : int.tryParse(map['time'].toString()), // Safely parse time
      status: map['status'] is int
          ? map['status'] as int
          : int.tryParse(map['status'].toString()), // Safely parse status
    );
  }
}



// class TodoModel {
//   int? id;
//   String title;
//   String description;
//   bool? status;

//   TodoModel(
//       {this.id,
//       required this.title,
//       required this.description,
//       required this.status});

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'description': description,
//       'status': status,
//     };
//   }

//   static TodoModel fromMap(Map<String, dynamic> map) {
//     return TodoModel(
//       id: map['id'],
//       title: map['title'],
//       description: map['description'],
//       status: map['status'],
//     );
//   }
// }