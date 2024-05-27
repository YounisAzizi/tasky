import 'package:Tasky/domain/riverpod/date_picker_riv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.text = ref.watch(todosProvider)[widget.index]['createdAt'];
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Due date',
        style: TextStyle(
          color: Colors.grey
        ),),
        const SizedBox(height: 8,),
        GestureDetector(
          onTap: () {
            _selectDate(context);
          },
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text('${ref.watch(selectedDateProvider).day}/${ref.watch(selectedDateProvider).month}/${ref.watch(selectedDateProvider).year}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                const Icon(Icons.date_range, color: Colors.deepPurple),
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
        _controller.text = '${ref.watch(selectedDateProvider).day}/${ref.watch(selectedDateProvider).month}/${ref.watch(selectedDateProvider).year}';
    }
  }
}