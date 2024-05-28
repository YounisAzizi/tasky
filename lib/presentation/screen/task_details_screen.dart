import 'package:Tasky/core/res/image_res.dart';
import 'package:Tasky/domain/riverpod/is_todo_editing_riv.dart';
import 'package:Tasky/domain/riverpod/sign_in_riv.dart';
import 'package:Tasky/presentation/widget/qr_code_widget.dart';
import 'package:Tasky/routes/routes.dart';
import 'package:Tasky/services/auth_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:Tasky/presentation/widget/task_details_widget.dart';
import 'package:Tasky/theme/text_style.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../domain/riverpod/todos_riv.dart';

class TaskDetailsScreen extends ConsumerStatefulWidget {
  const TaskDetailsScreen({super.key, required this.index});
  final int index;

  @override
  ConsumerState<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends ConsumerState<TaskDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        print(widget.index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final todoDetails = ref.watch(todosProvider).todos;
    AuthServices authServices = AuthServices();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 22.0, left: 10, right: 10),
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
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Task Details',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      )),
                  PopupMenuButton<String>(
                    color: Colors.white,
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
                            context.go('${Routes.addNewTaskScreen}${widget.index}');
                            context.go('${Routes.addNewTaskScreen.replaceFirst(':index', '${widget.index}')}');
                            ref.read(isTodoEditingProvider).setEditing(true);

                          },
                          value: 'edit',
                          child: Text(
                            'Edit',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                         PopupMenuItem(
                          onTap: ()async {
                          await  authServices.deleteTodo(todoDetails[widget.index]['_id'], ref.watch(appDataProvider).storeToken,context,ref,widget.index);
                          },
                          value: 'delete',
                          child: Text(
                            'Delete',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ];
                    },
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            widget.index < todoDetails.length &&  todoDetails[widget.index]['image'] != null && todoDetails[widget.index]['image'] != ''?
            CachedNetworkImage(
              imageUrl: todoDetails[widget.index]['image'],
              placeholder: (context, url) => Center(
                  child: SizedBox(
                height: 13,
                width: 13,
                child: CircularProgressIndicator(
                  color: Colors.deepPurple,
                  strokeWidth: 1,
                  strokeAlign: 5,
                ),
              )),
              errorWidget: (context, url, error) => Image.asset('assets/shopping_icon.png'),
            )
            :Image.asset(ImageRes.shoppingIcon),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todoDetails[widget.index]['title'],
                    style: Styles.titleStyle,
                  ),
                  Text(
                    textAlign: TextAlign.start,
                    todoDetails[widget.index]['desc'],
                    style: Styles.fadeTextStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                   TaskDetailsWidget(index: widget.index,),
                  QRCodeWidget(id: todoDetails[widget.index]['_id']),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
