class TaskModel {
  final String image;
  final String title;
  final String desc;
  final String priority;
  final String dueDate;

  TaskModel({
    required this.image,
    required this.title,
    required this.desc,
    required this.priority,
    required this.dueDate,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      image: json['image'],
      title: json['title'],
      desc: json['desc'],
      priority: json['priority'],
      dueDate: json['dueDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'desc': desc,
      'priority': priority,
      'dueDate': dueDate,
    };
  }
}
