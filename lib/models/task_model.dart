class TaskModel {
  final String id;
  final String image;
  final String title;
  final String desc;
  final String priority;
  final String dueDate;

  const TaskModel({
    required this.id,
    required this.image,
    required this.title,
    required this.desc,
    required this.priority,
    required this.dueDate,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['id'],
        image: json['image'],
        title: json['title'],
        desc: json['desc'],
        priority: json['priority'],
        dueDate: json['dueDate'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'title': title,
        'desc': desc,
        'priority': priority,
        'dueDate': dueDate,
      };
}
