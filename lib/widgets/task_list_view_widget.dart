import 'package:Tasky/const/const.dart';
import 'package:Tasky/models/priorities_enum.dart';
import 'package:Tasky/models/ui_status_enum.dart';
import 'package:Tasky/state_managers/screens/main_screen_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../const/image_res.dart';
import '../../routes/routes.dart';
import '../../theme/colors.dart';

class TaskListView extends ConsumerWidget {
  final UiStatus status;

  const TaskListView({super.key, required this.status});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainScreenState = ref.watch(mainScreenProvider);
    final todoDetails = mainScreenState.todos;
    final selectedStatus = mainScreenState.selectedStatus;

    return RefreshIndicator(
      onRefresh: () {
        return ref.read(mainScreenProvider).fetchListTodos(
              1,
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

                if (selectedStatus == UiStatus.all ||
                    task.status == selectedStatus) {
                  return InkWell(
                    onTap: () {
                      context.go("${Routes.taskDetails}${task}");
                      context.go(
                          '${Routes.taskDetails.replaceFirst(':$paramsFieldName', '$index')}');
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: CachedNetworkImage(
                              imageUrl: task.image!,
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
                              errorWidget: (context, url, error) =>
                                  Image.asset('assets/shopping_icon.png'),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '${task.title}',
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black),
                                          maxLines: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: getStatusColor(task.status),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Center(
                                            child: Text(
                                              getStatusText(task.status),
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: getStatusTextColor(
                                                  task.status,
                                                ),
                                              ),
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
                                      task.desc,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Color.fromRGBO(36, 37, 44, 0.6),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 32.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              ImageRes.flag,
                                              height: 16,
                                              width: 16,
                                              color: priorityColor(
                                                task.priority,
                                              ),
                                            ),
                                            Text(
                                              getPriorityText(task.priority),
                                              style: TextStyle(
                                                color: priorityColor(
                                                  task.priority,
                                                ),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '${task.createdAt!}'.substring(0, 10),
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Color.fromRGBO(36, 37, 44, 0.6),
                                          ),
                                        ),
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

  String getStatusText(UiStatus status) {
    switch (status) {
      case UiStatus.waiting:
        return 'Waiting';
      case UiStatus.inprogress:
        return 'Inprogress';
      case UiStatus.finished:
        return 'Finished';
      default:
        return 'Unknown Status';
    }
  }

  Color getStatusColor(UiStatus status) {
    switch (status) {
      case UiStatus.inprogress:
        return Color.fromRGBO(240, 236, 255, 1);
      case UiStatus.waiting:
        return Color.fromRGBO(255, 228, 242, 1);
      case UiStatus.finished:
        return Color.fromRGBO(227, 242, 255, 1);
      default:
        return Colors.grey.withOpacity(0.2);
    }
  }

  Color getStatusTextColor(UiStatus status) {
    switch (status) {
      case UiStatus.inprogress:
        return AppColors.mainThemColor;
      case UiStatus.waiting:
        return Color.fromRGBO(255, 125, 83, 1);
      case UiStatus.finished:
        return Color.fromRGBO(0, 135, 255, 1);
      default:
        return Colors.grey;
    }
  }

  String getPriorityText(PrioritiesEnum status) {
    switch (status) {
      case PrioritiesEnum.medium:
        return 'Medium';
      case PrioritiesEnum.low:
        return 'Low';
      case PrioritiesEnum.high:
        return 'High';
      default:
        return 'Unknown Status';
    }
  }

  Color priorityColor(PrioritiesEnum priority) {
    switch (priority) {
      case PrioritiesEnum.medium:
        return AppColors.mainThemColor;
      case PrioritiesEnum.low:
        return Color.fromRGBO(0, 135, 255, 1);
      case PrioritiesEnum.high:
        return Color.fromRGBO(255, 125, 83, 1);
      default:
        return Colors.grey;
    }
  }
}
