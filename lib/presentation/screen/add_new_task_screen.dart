import 'package:Tasky/core/res/image_res.dart';
import 'package:Tasky/domain/riverpod/priority_riv.dart';
import 'package:Tasky/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:Tasky/presentation/widget/addNewTask/add_image_widget.dart';
import 'package:Tasky/presentation/widget/addNewTask/date_picker_widget.dart';
import 'package:Tasky/presentation/widget/addNewTask/priority_selector_widget.dart';
import 'package:Tasky/presentation/widget/custom_elevated_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../domain/riverpod/todos_riv.dart';

class AddNewTaskScreen extends ConsumerStatefulWidget {
  const AddNewTaskScreen({super.key, required this.index});
  final int index;

  @override
  ConsumerState<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends ConsumerState<AddNewTaskScreen> {
  final titleController=TextEditingController();
  final descController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      titleController.text = ref.watch(todosProvider)[widget.index]['title'];
      descController.text = ref.watch(todosProvider)[widget.index]['desc'];
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        context.go(Routes.mainScreen);
                      },
                      icon:  Row(
                        children: [
                          SvgPicture.asset(ImageRes.backButton,height: 30,width: 30,),
                          SizedBox(width: 5,),
                          Text(
                            'Add new task',
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                        ],
                      )),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     AddImageWidget(
                      index: widget.index,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Task title',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                     TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                          hintText: 'Enter title here...',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    const SizedBox(height: 20),
                    const Text('Task Description',
                        style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 8),
                     TextField(
                      controller: descController,
                      maxLines: 7,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        hintText: 'Enter description here...',
                      ),
                    ),
                    const SizedBox(height: 20),
                     PrioritySelectorWidget(
                    ),
                    const SizedBox(height: 20),
                     CustomDatePicker(index: widget.index,),
                    const SizedBox(height: 28),
                    CustomElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Add task',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
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
