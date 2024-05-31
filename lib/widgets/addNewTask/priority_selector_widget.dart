import 'package:Tasky/models/priorities_enum.dart';
import 'package:Tasky/state_managers/data/new_task_data_provider.dart';
import 'package:Tasky/state_managers/screens/new_task_screen_provider.dart';
import 'package:Tasky/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../const/image_res.dart';
import '../../../theme/colors.dart';

class PrioritySelectorWidget extends ConsumerWidget {
  const PrioritySelectorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskModel = ref.watch(newTaskDataProvider).taskModel;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Priority',
          style: TextStyle(
            color: Color.fromRGBO(110, 106, 124, 1),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          height: 60,
          width: Utils.screenWidth(context),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color.fromRGBO(240, 236, 255, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: taskModel.priority.name,
              icon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Icon(Icons.favorite, color: AppColors.mainThemColor),
              ),
              iconSize: 18,
              elevation: 16,
              style:
                  const TextStyle(color: AppColors.mainThemColor, fontSize: 16),
              onChanged: (String? newValue) {
                final newTaskModel = taskModel.copyWith(
                    priority: PrioritiesEnum.fromString(newValue!));

                ref.read(newTaskDataProvider).taskModel = newTaskModel;
              },
              items: ref
                  .watch(newTaskScreenProvider)
                  .priorities
                  .map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                  value: value.name,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          ImageRes.flag,
                          height: 24,
                          width: 24,
                          color: AppColors.mainThemColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          value.name,
                          style: TextStyle(
                            color: AppColors.mainThemColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
