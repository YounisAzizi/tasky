import 'package:Tasky/core/res/image_res.dart';
import 'package:Tasky/domain/riverpod/date_picker_riv.dart';
import 'package:Tasky/domain/riverpod/is_todo_editing_riv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../domain/riverpod/todos_riv.dart';

class CustomDatePicker extends ConsumerStatefulWidget {
  const CustomDatePicker({super.key,required this.index});
  final int index;

  @override
  CustomDatePickerState createState() => CustomDatePickerState();
}

class CustomDatePickerState extends ConsumerState<CustomDatePicker> {
  final TextEditingController _controller = TextEditingController();
@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(ref.watch(isTodoEditingProvider).isEditing) {
        _controller.text = ref
            .watch(todosProvider)
            .todos[widget.index]['createdAt'];
        ref.read(selectedDateProvider).setDate(DateTime.parse(ref
            .watch(todosProvider)
            .todos[widget.index]['createdAt']));
      }},);
  }
  @override
  Widget build(BuildContext context) {
    final isEditing = ref.watch(isTodoEditingProvider).isEditing;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Due date',
        style: TextStyle(
          color: Color.fromRGBO(110, 106, 124, 1),
          fontSize: 12,
          fontWeight: FontWeight.w400,


        ),),
        const SizedBox(height: 8,),
        GestureDetector(
          onTap: () {
            _selectDate(context);
          },
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(isEditing
                      ?'${ref.watch(selectedDateProvider).selectedDate}'
                    :'choose due date',
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
    if (picked != null && picked != ref.watch(selectedDateProvider)) {

      ref.read(selectedDateProvider.notifier).setDate(picked);
        _controller.text = '${ref.watch(selectedDateProvider).selectedDate}';
    }
  }
}