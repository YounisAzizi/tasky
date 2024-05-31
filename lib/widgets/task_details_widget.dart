import 'package:Tasky/state_managers/screens/main_screen_provider.dart';
import 'package:Tasky/widgets/custom_task_details_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../const/image_res.dart';
import '../../theme/colors.dart';

class TaskDetailsWidget extends ConsumerWidget {
  final int index;

  const TaskDetailsWidget({required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoDetails = ref.watch(mainScreenProvider).todos[index];

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          CustomTaskDetailsContainerWidget(
            isDate: true,
            icon: Icons.date_range_outlined,
            title: Text(
              '${todoDetails.createdAt}'.substring(0, 10),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(36, 37, 44, 1),
              ),
            ),
          ),
          SizedBox(height: 10),
          CustomTaskDetailsContainerWidget(
            title: Text(
              todoDetails.status.name,
              style: TextStyle(
                color: AppColors.mainThemColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            icon: Icons.favorite,
            isDate: false,
          ),
          SizedBox(height: 10),
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
                  '${todoDetails.priority.name} priority',
                  style: TextStyle(
                    color: AppColors.mainThemColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
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
