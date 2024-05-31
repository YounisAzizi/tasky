import 'package:Tasky/models/priorities_enum.dart';
import 'package:Tasky/models/ui_status_enum.dart';

const defaultTaskModel = TaskModel(
  id: '',
  image: '',
  title: '',
  desc: '',
  priority: PrioritiesEnum.medium,
  status: UiStatus.waiting,
  userId: '',
  createdAt: '',
);

class TaskModel {
  final String id;
  final String? image;
  final String title;
  final String desc;
  final PrioritiesEnum priority;
  final UiStatus status;
  final String userId;
  final String createdAt;

  const TaskModel({
    required this.id,
    required this.image,
    required this.title,
    required this.desc,
    required this.priority,
    required this.status,
    required this.userId,
    required this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['id'] ?? '',
        image: json['image'] ?? '',
        title: json['title'] ?? '',
        desc: json['desc'] ?? '',
        priority: PrioritiesEnum.fromString(json['priority'] ?? ''),
        status: UiStatus.fromString(json['status'] ?? ''),
        userId: json['user'] ?? '',
        createdAt: json['createdAt'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'title': title,
        'desc': desc,
        'priority': priority.name,
        'user': userId,
        'status': status.name,
        'createdAt': createdAt,
      };

  TaskModel copyWith({
    String? id,
    String? image,
    String? title,
    String? desc,
    PrioritiesEnum? priority,
    UiStatus? status,
    String? user,
    String? createdAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      image: image ?? this.image,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      userId: user ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
