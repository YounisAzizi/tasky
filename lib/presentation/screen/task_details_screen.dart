import 'package:Tasky/core/res/image_res.dart';
import 'package:Tasky/core/utils/utils.dart';
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
import '../../theme/colors.dart';

class TaskDetailsScreen extends ConsumerStatefulWidget {
  const TaskDetailsScreen({super.key, required this.index});
  final int index;

  @override
  ConsumerState<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends ConsumerState<TaskDetailsScreen> {
  @override
  void initState() {
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
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Task Details',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                              fontSize: 16),
                            )
                          ],
                        )),
                    PopupMenuButton<String>(
                     shape: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(12),
                       borderSide: BorderSide(
                         color: Colors.white
                       )
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
                              context.go('${Routes.addNewTaskScreen}${widget.index}');
                              context.go('${Routes.addNewTaskScreen.replaceFirst(':index', '${widget.index}')}');
                              ref.read(isTodoEditingProvider).setEditing(true);

                            },
                            value: 'edit',
                            child: Text(
                              'Edit',
                              style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
                            ),
                          ),
                          PopupMenuDivider(
                            height: 1,
                          ),
                           PopupMenuItem(
                            onTap: ()async {
                            await  authServices.deleteTodo(todoDetails[widget.index]['_id'], ref.watch(appDataProvider).storeToken,context,ref,widget.index);
                            },
                            value: 'delete',
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 125, 83, 1), fontWeight: FontWeight.w500,fontSize: 16),
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
              SizedBox(height: 30,),
              widget.index < todoDetails.length &&  todoDetails[widget.index]['image'] != null && todoDetails[widget.index]['image'] != ''?
              CachedNetworkImage(
                height: 225,
                width: Utils.screenWidth(context),
                imageUrl: todoDetails[widget.index]['image'],
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
                errorWidget: (context, url, error) => Image.asset('assets/shopping_icon.png'),
              )
              :Image.asset(ImageRes.shoppingIcon,height: 225,width: Utils.screenWidth(context),),
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
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(36, 37, 44, 1)
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      textAlign: TextAlign.start,
                      todoDetails[widget.index]['desc'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(36, 37, 44, 0.6)
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                     TaskDetailsWidget(index: widget.index,),
                    QRCodeWidget(id: todoDetails[widget.index]['_id']),
                    const SizedBox(
                      height: 10,
                    ),
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
