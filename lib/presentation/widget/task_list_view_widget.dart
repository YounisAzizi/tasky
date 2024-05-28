import 'package:Tasky/domain/riverpod/sign_in_riv.dart';
import 'package:Tasky/domain/riverpod/todos_riv.dart';
import 'package:Tasky/services/auth_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/riverpod/tab_bar_riv.dart';
import '../../routes/routes.dart';
import '../../theme/text_style.dart';

class TaskListView extends ConsumerStatefulWidget {
  final Status status;

  const TaskListView({super.key, required this.status});

  @override
  ConsumerState<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends ConsumerState<TaskListView> {
  @override
  Widget build(BuildContext context) {
    final todoDetails = ref.watch(todosProvider).todos;
    final authServices = AuthServices();
    final selectedStatus = ref.watch(statusProvider).selectedStatus;

    return RefreshIndicator(
      onRefresh: () {
        return authServices.fetchListTodos(
          1,
          ref.watch(appDataProvider).storeToken,
          ref,
          context,
        );
      },
      backgroundColor: Colors.transparent,
      color: Colors.red,
      child: todoDetails.isEmpty
          ? Center(
        child: Text(
          'No Task',
          style: TextStyle(fontSize: 25),
        ),
      )
          : ListView.builder(
        itemCount: todoDetails.length,
        itemBuilder: (context, index) {
          final task = todoDetails[index];
          if (selectedStatus == Status.all || task['status'] == statusToString(selectedStatus)) {
            return InkWell(
              onTap: () {
                context.go("${Routes.taskDetails}${task}");
                context.go('${Routes.taskDetails.replaceFirst(':index', '$index')}');
              },
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(
                        imageUrl: task['image'],
                        placeholder: (context, url) => Center(
                          child: SizedBox(
                            height: 13,
                            width: 13,
                            child: CircularProgressIndicator(
                              color: Colors.deepPurple,
                              strokeWidth: 1,
                              strokeAlign: 5,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Image.asset('assets/shopping_icon.png'),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                task['title'].toString().length > 12
                                    ? Text(
                                  '${'${task['title']!}'.substring(0, 12)} ...',
                                  style: Styles.titleStyle,
                                  maxLines: 1,
                                )
                                    : Text(
                                  '${task['title']!}',
                                  style: Styles.titleStyle,
                                  maxLines: 1,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: getStatusColor(task['status']!),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Center(
                                    child: Text(
                                      task['status']!,
                                      maxLines: 1,
                                      style: TextStyle(color: getStatusTextColor(task['status']!)),
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.more_vert,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ],
                            ),
                            Text(
                              task['desc']!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.flag_outlined,
                                      color: priorityColor(task['priority']!),
                                    ),
                                    Text(
                                      task['priority']!,
                                      style: TextStyle(color: priorityColor(task['priority']!)),
                                    ),
                                  ],
                                ),
                                Text('${task['createdAt']!}'.substring(0, 10)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Inprogress':
        return Colors.blue.withOpacity(0.2);
      case 'Waiting':
        return Colors.deepOrange.withOpacity(0.2);
      case 'Finished':
        return Colors.green.withOpacity(0.2);
      default:
        return Colors.grey.withOpacity(0.2);
    }
  }

  Color getStatusTextColor(String status) {
    switch (status) {
      case 'inprogress':
        return Colors.blue;
      case 'waiting':
        return Colors.deepOrange;
      case 'finished':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color priorityColor(String priority) {
    switch (priority) {
      case 'medium':
        return Colors.blue;
      case 'low':
        return Colors.deepOrange;
      case 'high':
        return Colors.deepPurple;
      default:
        return Colors.grey;
    }
  }
}

String statusToString(Status status) {
  switch (status) {
    case Status.all:
      return 'all';
    case Status.inProgress:
      return 'inprogress';
    case Status.waiting:
      return 'waiting';
    case Status.finished:
      return 'finished';
    default:
      return '';
  }
}
