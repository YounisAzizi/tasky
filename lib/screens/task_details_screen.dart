import 'package:Tasky/const/const.dart';
import 'package:Tasky/const/image_res.dart';
import 'package:Tasky/routes/routes.dart';
import 'package:Tasky/state_managers/data/task_details_data_provider.dart';
import 'package:Tasky/state_managers/screens/main_screen_provider.dart';
import 'package:Tasky/state_managers/screens/new_task_screen_provider.dart';
import 'package:Tasky/utils/utils.dart';
import 'package:Tasky/widgets/qr_code_widget.dart';
import 'package:Tasky/widgets/task_details_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../theme/colors.dart';

class TaskDetailsScreen extends ConsumerWidget {
  final int index;

  const TaskDetailsScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsState = ref.watch(taskDetailsDataProvider);
    final todos = ref.watch(mainScreenProvider).todos;
    final todoDetails = todos[index];
    final hasImage = index < todos.length &&
        todoDetails.image != null &&
        todoDetails.image != '';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 42.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.go(Routes.mainScreen);
                      },
                      icon: Row(
                        children: [
                          SvgPicture.asset(
                            ImageRes.backButton,
                            height: 24,
                            width: 24,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Task Details',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    PopupMenuButton<String>(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      color: Color.fromRGBO(255, 255, 255, 1),
                      onSelected: (value) {
                        // Handle the selected value
                        if (value == 'edit') {
                          // Edit action
                          print('Edit selected');
                        } else if (value == 'delete') {
                          // Delete action
                          print('Delete selected');
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                            onTap: () {
                              context.go('${Routes.addNewTaskScreen}${index}');
                              context.go(
                                  '${Routes.addNewTaskScreen.replaceFirst(':$paramsFieldName', '${index}')}');
                              ref.read(newTaskScreenProvider).isEditing = true;
                            },
                            value: 'edit',
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          PopupMenuDivider(height: 1),
                          PopupMenuItem(
                            onTap: () async {
                              await detailsState.deleteTodo(
                                todoDetails.id,
                                context,
                                ref,
                                index,
                              );
                            },
                            value: 'delete',
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                color: Color.fromRGBO(255, 125, 83, 1),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ];
                      },
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              hasImage
                  ? CachedNetworkImage(
                      height: 225,
                      width: Utils.screenWidth(context),
                      imageUrl: todoDetails.image!,
                      placeholder: (context, url) => Center(
                          child: SizedBox(
                        height: 13,
                        width: 13,
                        child: CircularProgressIndicator(
                          color: AppColors.mainThemColor,
                          strokeWidth: 1,
                          strokeAlign: 5,
                        ),
                      )),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/shopping_icon.png'),
                    )
                  : Image.asset(
                      ImageRes.shoppingIcon,
                      height: 225,
                      width: Utils.screenWidth(context),
                    ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todoDetails.title,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(36, 37, 44, 1)),
                    ),
                    SizedBox(height: 10),
                    Text(
                      textAlign: TextAlign.start,
                      todoDetails.desc,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(36, 37, 44, 0.6),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TaskDetailsWidget(index: index),
                    QRCodeWidget(id: todoDetails.id),
                    const SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
