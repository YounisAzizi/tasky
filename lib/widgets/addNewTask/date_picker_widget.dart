import 'package:Tasky/const/image_res.dart';
import 'package:Tasky/state_managers/screens/main_screen_provider.dart';
import 'package:Tasky/state_managers/screens/new_task_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDatePicker extends ConsumerStatefulWidget {
  const CustomDatePicker({super.key, required this.index});
  final int index;

  @override
  CustomDatePickerState createState() => CustomDatePickerState();
}

class CustomDatePickerState extends ConsumerState<CustomDatePicker> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (ref.watch(newTaskScreenProvider).isEditing) {
          _controller.text =
              ref.watch(mainScreenProvider).todos[widget.index]['createdAt'];
          ref.read(newTaskScreenProvider).selectedDate = DateTime.parse(
            ref.watch(mainScreenProvider).todos[widget.index]['createdAt'],
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = ref.watch(newTaskScreenProvider).isEditing;
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
          onTap: () {
            _selectDate(context);
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
                    isEditing
                        ? '${ref.watch(newTaskScreenProvider).selectedDate}'
                        : 'choose due date',
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != ref.watch(newTaskScreenProvider)) {
      ref.read(newTaskScreenProvider.notifier).selectedDate = picked;
      _controller.text = '${ref.watch(newTaskScreenProvider).selectedDate}';
    }
  }
}
