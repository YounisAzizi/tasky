import 'package:Tasky/const/image_res.dart';
import 'package:Tasky/state_managers/data/new_task_data_provider.dart';
import 'package:Tasky/state_managers/screens/new_task_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDatePicker extends ConsumerWidget {
  const CustomDatePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditing = ref.watch(newTaskScreenProvider).isEditing;
    final newTaskDataState = ref.watch(newTaskDataProvider);
    final taskModel = newTaskDataState.taskModel;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Due date',
          style: TextStyle(
            color: Color.fromRGBO(110, 106, 124, 1),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        GestureDetector(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (picked != null && picked != ref.watch(newTaskScreenProvider)) {
              final newTaskModel = taskModel.copyWith(dueDate: '$picked');

              ref.read(newTaskDataProvider).taskModel = newTaskModel;
            }
          },
          child: Container(
            height: 50,
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    (taskModel.dueDate == null || taskModel.dueDate!.isEmpty)
                        ? 'choose due date'
                        : '${taskModel.dueDate}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                SvgPicture.asset(
                  ImageRes.calender,
                  height: 24,
                  width: 24,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
