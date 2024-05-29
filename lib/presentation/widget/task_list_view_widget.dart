import 'package:Tasky/domain/riverpod/sign_in_riv.dart';
import 'package:Tasky/domain/riverpod/todos_riv.dart';
import 'package:Tasky/services/auth_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../core/res/image_res.dart';
import '../../domain/riverpod/tab_bar_riv.dart';
import '../../routes/routes.dart';
import '../../theme/colors.dart';
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
                              color: AppColors.mainThemColor,
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
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${task['title']!}',
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: getStatusColor(task['status']!),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Center(
                                      child: Text(
                                        getStatusText(task['status']!)
                                        ,
                                        maxLines: 1,
                                        style: TextStyle(color: getStatusTextColor(task['status']!)),
                                      ),
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
                            Padding(
                              padding: const EdgeInsets.only(right: 32.0),
                              child: Text(
                                task['desc']!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color.fromRGBO(36, 37, 44, 0.6)
                                ),
                              ),
                            ),
                            SizedBox(height: 8,),
                            Padding(
                              padding: const EdgeInsets.only(right: 32.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        ImageRes.flag,
                                        height: 16,
                                        width: 16,
                                        color: priorityColor(task['priority']!),
                                      ),

                                      Text(
                                        getPriorityText(task['priority']!)
                                        ,
                                        style: TextStyle(color: priorityColor(task['priority']!),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Text('${task['createdAt']!}'.substring(0, 10),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(36, 37, 44, 0.6)
                                  ),),
                                ],
                              ),
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
  String getStatusText(String status) {
    switch (status) {
      case 'waiting':
        return 'Waiting';
      case 'inprogress':
        return 'Inprogress';
      case 'finished':
        return 'Finished';
      default:
        return 'Unknown Status';
    }
  }
  Color getStatusColor(String status) {
    switch (status) {
      case 'inprogress':
        return Color.fromRGBO(240, 236, 255, 1);
      case 'waiting':
        return Color.fromRGBO(255, 228, 242, 1);
      case 'finished':
        return Color.fromRGBO(227, 242, 255, 1);
      default:
        return Colors.grey.withOpacity(0.2);
    }
  }

  Color getStatusTextColor(String status) {
    switch (status) {
      case 'inprogress':
        return AppColors.mainThemColor;
      case 'waiting':
        return Color.fromRGBO(255, 125, 83, 1);
      case 'finished':
        return Color.fromRGBO(0, 135, 255, 1);
      default:
        return Colors.grey;
    }
  }

  String getPriorityText(String status) {
    switch (status) {
      case 'medium':
        return 'Medium';
      case 'low':
        return 'Low';
      case 'high':
        return 'High';
      default:
        return 'Unknown Status';
    }
  }
  Color priorityColor(String priority) {
    switch (priority) {
      case 'medium':
        return AppColors.mainThemColor;
      case 'low':
        return Color.fromRGBO(0, 135, 255, 1);
      case 'high':
        return Color.fromRGBO(255, 125, 83, 1);
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
