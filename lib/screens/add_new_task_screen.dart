import 'package:Tasky/const/image_res.dart';
import 'package:Tasky/routes/routes.dart';
import 'package:Tasky/services/auth_services.dart';
import 'package:Tasky/state_managers/screens/main_screen_provider.dart';
import 'package:Tasky/state_managers/screens/new_task_screen_provider.dart';
import 'package:Tasky/utils/shared_prefs.dart';
import 'package:Tasky/utils/utils.dart';
import 'package:Tasky/widgets/addNewTask/add_image_widget.dart';
import 'package:Tasky/widgets/addNewTask/date_picker_widget.dart';
import 'package:Tasky/widgets/addNewTask/priority_selector_widget.dart';
import 'package:Tasky/widgets/addNewTask/status_selector_widget.dart';
import 'package:Tasky/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class AddNewTaskScreen extends ConsumerStatefulWidget {
  const AddNewTaskScreen({super.key, required this.index});
  final int index;
  @override
  ConsumerState<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends ConsumerState<AddNewTaskScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        print(widget.index);
        if (ref.watch(newTaskScreenProvider).isEditing) {
          titleController.text =
              ref.watch(mainScreenProvider).todos[widget.index]['title'];
          descController.text =
              ref.watch(mainScreenProvider).todos[widget.index]['desc'];
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = ref.watch(newTaskScreenProvider).isEditing;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 42.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        context.go(Routes.mainScreen);
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            ImageRes.backButton,
                            height: 24,
                            width: 24,
                          ),
                          SizedBox(width: 5),
                          Text(
                            isEditing ? 'Edit task' : 'Add new task',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Utils.screenWidth(context),
                    child: AddImageWidget(index: widget.index),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Task title',
                    style: TextStyle(
                      color: Color.fromRGBO(110, 106, 124, 1),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Enter title here...',
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(127, 127, 127, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Task Description',
                    style: TextStyle(
                      color: Color.fromRGBO(110, 106, 124, 1),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: descController,
                    maxLines: 7,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(127, 127, 127, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      hintText: 'Enter description here...',
                    ),
                  ),
                  const SizedBox(height: 20),
                  PrioritySelectorWidget(index: widget.index),
                  if (isEditing) const SizedBox(height: 20),
                  if (isEditing) StatusSelectorWidget(index: widget.index),
                  const SizedBox(height: 20),
                  CustomDatePicker(index: widget.index),
                  const SizedBox(height: 28),
                  CustomElevatedButton(
                    onPressed: () async {
                      if (isEditing) {
                        AuthServices.editTodoById(
                          todoId: ref
                              .watch(mainScreenProvider)
                              .todos[widget.index]['_id'],
                          ref: ref,
                          context: context,
                          imageUrl:
                              'https://media.licdn.com/dms/image/C5603AQF2ARgIeZLu5A/profile-displayphoto-shrink_200_200/0/1542094017276?e=2147483647&v=beta&t=S5P-tEwnKA2zfDJ_MMa9gGv5brGT5JFZ9FJwIcPNhVk',
                          title: titleController.text,
                          desc: descController.text,
                          priority:
                              ref.watch(newTaskScreenProvider).selectedPriority,
                          status:
                              ref.watch(newTaskScreenProvider).selectedStatus,
                          userId: SharedPrefs.getStoreId() ?? '',
                        );
                      } else {
                        AuthServices.addTodo(
                          accessToken: SharedPrefs.getStoreToken() ?? '',
                          imageUrl:
                              'https://media.licdn.com/dms/image/C5603AQF2ARgIeZLu5A/profile-displayphoto-shrink_200_200/0/1542094017276?e=2147483647&v=beta&t=S5P-tEwnKA2zfDJ_MMa9gGv5brGT5JFZ9FJwIcPNhVk',
                          title: titleController.text,
                          desc: descController.text,
                          priority:
                              ref.watch(newTaskScreenProvider).selectedPriority,
                          dueDate: ref
                              .watch(newTaskScreenProvider)
                              .selectedDate
                              .toString(),
                          context: context,
                          ref: ref,
                        );
                      }
                    },
                    child: Text(
                      isEditing ? "Edit task" : 'Add task',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
