import 'package:flutter/material.dart';
import 'package:Tasky/core/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/res/image_res.dart';
import '../../../domain/riverpod/is_todo_editing_riv.dart';
import '../../../domain/riverpod/priority_riv.dart';
import '../../../domain/riverpod/todos_riv.dart';
import '../../../theme/colors.dart';

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
          color: Color.fromRGBO(110, 106, 124, 1),
          fontSize: 12,
          fontWeight: FontWeight.w400,


        ),),
        const SizedBox(height: 8,),
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
              value: ref.watch(priorityManagerProvider).selectedPriority,
              icon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Icon(Icons.favorite, color: AppColors.mainThemColor),
              ),
              iconSize: 18,
              elevation: 16,
              style: const TextStyle(color: AppColors.mainThemColor, fontSize: 16),
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
                        SvgPicture.asset(
                          ImageRes.flag,
                          height: 24,
                          width: 24,
                          color: AppColors.mainThemColor,
                        ),
                        const SizedBox(width: 8),
                        Text(value,style:TextStyle(
                            color: AppColors.mainThemColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
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
