import 'package:Tasky/const/image_res.dart';
import 'package:Tasky/routes/routes.dart';
import 'package:Tasky/state_managers/data/new_task_data_provider.dart';
import 'package:Tasky/state_managers/screens/main_screen_provider.dart';
import 'package:Tasky/state_managers/screens/new_task_screen_provider.dart';
import 'package:Tasky/utils/utils.dart';
import 'package:Tasky/widgets/addNewTask/add_image_widget.dart';
import 'package:Tasky/widgets/addNewTask/date_picker_widget.dart';
import 'package:Tasky/widgets/addNewTask/priority_selector_widget.dart';
import 'package:Tasky/widgets/addNewTask/status_selector_widget.dart';
import 'package:Tasky/widgets/custom_elevated_button.dart';
import 'package:Tasky/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class AddNewTaskScreen extends ConsumerStatefulWidget {
  final int index;

  const AddNewTaskScreen({super.key, required this.index});
  @override
  ConsumerState<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends ConsumerState<AddNewTaskScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        print(widget.index);
        if (ref.watch(newTaskScreenProvider).isEditing) {
          ref.read(newTaskDataProvider).taskModel =
              ref.watch(mainScreenProvider).todos[widget.index];
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = ref.watch(newTaskScreenProvider).isEditing;
    final newTaskDataState = ref.watch(newTaskDataProvider);
    final taskModel = newTaskDataState.taskModel;

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
              Form(
                key: newTaskDataState.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Utils.screenWidth(context),
                      child: AddImageWidget(
                        imageUrl: taskModel.image!,
                      ),
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
                      child: TextFormFieldWidget(
                        text: taskModel.title,
                        inputDecoration: InputDecoration(
                          hintText: 'Enter title here...',
                          hintStyle: TextStyle(
                            color: Color.fromRGBO(127, 127, 127, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onChanged: (title) {
                          final newTaskModel = taskModel.copyWith(title: title);

                          ref.read(newTaskDataProvider).taskModel =
                              newTaskModel;
                        },
                        validator: (title) {
                          if (title == null || title.isEmpty) {
                            return 'Please enter your title';
                          }
                          return null;
                        },
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
                    TextFormFieldWidget(
                      text: taskModel.desc,
                      maxLines: 7,
                      inputDecoration: InputDecoration(
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
                      onChanged: (desc) {
                        final newTaskModel = taskModel.copyWith(desc: desc);

                        ref.read(newTaskDataProvider).taskModel = newTaskModel;
                      },
                      validator: (desc) {
                        if (desc == null || desc.isEmpty) {
                          return 'Please enter your description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    PrioritySelectorWidget(),
                    if (isEditing) const SizedBox(height: 20),
                    if (isEditing) StatusSelectorWidget(),
                    const SizedBox(height: 20),
                    CustomDatePicker(),
                    const SizedBox(height: 28),
                    CustomElevatedButton(
                      onPressed: () async {
                        if (newTaskDataState.formKey.currentState!.validate()) {
                          await ref.read(newTaskScreenProvider).onSavedTask(
                                taskModel: taskModel,
                                ref: ref,
                                context: context,
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
