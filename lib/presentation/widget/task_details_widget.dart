import 'package:flutter/material.dart';
import 'package:Tasky/presentation/widget/custom_task_details_container_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/riverpod/todos_riv.dart';

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
    final todoDetails = ref.watch(todosProvider);
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          CustomTaskDetailsContainerWidget(
            isDate: true,
            icon: Icons.date_range_outlined,
            title: Text('${todoDetails[widget.index]['createdAt']}'.substring(0,10)),
          ),
          SizedBox(height: 10,),
          CustomTaskDetailsContainerWidget(
            title: Text(
              todoDetails[widget.index]['status'],
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            icon: Icons.favorite,
            isDate: false,
          ),
          SizedBox(height: 10,),
          CustomTaskDetailsContainerWidget(
            title: Row(
              children: [
                Icon(
                  Icons.flag_outlined,
                  color: Colors.deepPurple,
                ),
                Text(
                  todoDetails[widget.index]['priority'],
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 18,
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
