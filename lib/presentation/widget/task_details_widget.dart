import 'package:flutter/material.dart';
import 'package:Tasky/presentation/widget/custom_task_details_container_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/res/image_res.dart';
import '../../domain/riverpod/todos_riv.dart';
import '../../theme/colors.dart';

class TaskDetailsWidget extends ConsumerStatefulWidget {
  const TaskDetailsWidget(
      {super.key, required this.index});
  final int index;

  @override
  ConsumerState<TaskDetailsWidget> createState() => _TaskDetailsWidgetState();
}

class _TaskDetailsWidgetState extends ConsumerState<TaskDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    final todoDetails = ref.watch(todosProvider).todos;
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          CustomTaskDetailsContainerWidget(
            isDate: true,
            icon: Icons.date_range_outlined,
            title: Text('${todoDetails[widget.index]['createdAt']}'.substring(0,10),
            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,
            color: Color.fromRGBO(36, 37, 44, 1)),),
          ),
          SizedBox(height: 10,),
          CustomTaskDetailsContainerWidget(
            title: Text(
              todoDetails[widget.index]['status'],
              style: TextStyle(
                  color: AppColors.mainThemColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            icon: Icons.favorite,
            isDate: false,
          ),
          SizedBox(height: 10,),
          CustomTaskDetailsContainerWidget(
            title: Row(
              children: [
                SvgPicture.asset(
                  ImageRes.flag,
                  height: 24,
                  width: 24,
                  color: AppColors.mainThemColor,
                ),
                Text(
                  '${todoDetails[widget.index]['priority']} priority',
                  style: TextStyle(
                      color: AppColors.mainThemColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
            icon: Icons.favorite,
            isDate: false,
          ),
        ],
      ),
    );
  }
}
