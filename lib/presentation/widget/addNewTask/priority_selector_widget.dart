import 'package:flutter/material.dart';
import 'package:Tasky/core/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/riverpod/is_todo_editing_riv.dart';
import '../../../domain/riverpod/priority_riv.dart';
import '../../../domain/riverpod/todos_riv.dart';

class PrioritySelectorWidget extends ConsumerStatefulWidget {
  const PrioritySelectorWidget({super.key,required this.index});
final int index;
  @override
  ConsumerState<PrioritySelectorWidget> createState() => _PrioritySelectorWidgetState();
}

class _PrioritySelectorWidgetState extends ConsumerState<PrioritySelectorWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(ref.watch(isTodoEditingProvider).isEditing){
        ref.read(priorityManagerProvider).setPriority(ref.watch(todosProvider).todos[widget.index]['priority']);
      }
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Priority',
        style: TextStyle(
          color: Colors.grey
        ),),
        const SizedBox(height: 8,),
        Container(
          width: Utils.screenWidth(context),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.deepPurple[50],
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: ref.watch(priorityManagerProvider).selectedPriority,
              icon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Icon(Icons.favorite, color: Colors.deepPurple),
              ),
              iconSize: 18,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple, fontSize: 16),
              onChanged: (String? newValue) {
                ref.read(priorityManagerProvider.notifier).setPriority(newValue!);
              },
              items: ref.watch(priorityManagerProvider).priorities
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      children: [
                        const Icon(Icons.flag_outlined, color: Colors.deepPurple),
                        const SizedBox(width: 8),
                        Text(value,style: const TextStyle(
                          fontWeight: FontWeight.w500
                        ),),
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
