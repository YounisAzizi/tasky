import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/res/image_res.dart';
import '../../../core/utils/utils.dart';
import '../../../domain/riverpod/is_todo_editing_riv.dart';
import '../../../domain/riverpod/status_riv.dart';
import '../../../domain/riverpod/todos_riv.dart';
import '../../../theme/colors.dart';

class StatusSelectorWidget extends ConsumerStatefulWidget {
  const StatusSelectorWidget({super.key,required this.index});
  final int index;

  @override
  ConsumerState<StatusSelectorWidget> createState() => _StatusSelectorWidgetState();
}

class _StatusSelectorWidgetState extends ConsumerState<StatusSelectorWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(ref.watch(isTodoEditingProvider).isEditing){
        ref.read(statusManagerProvider).setStatus(ref.watch(todosProvider).todos[widget.index]['status']);
      }
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Status',
          style:TextStyle(
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
              value: ref.watch(statusManagerProvider).selectedStatus,
              icon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Icon(Icons.favorite, color: AppColors.mainThemColor),
              ),
              iconSize: 18,
              elevation: 16,
              style: const TextStyle(color: AppColors.mainThemColor, fontSize: 16),
              onChanged: (String? newValue) {
                print(newValue);
                ref.read(statusManagerProvider.notifier).setStatus(newValue!);
              },
              items: ref.watch(statusManagerProvider).statuses
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
                        ),                        const SizedBox(width: 8),
                        Text(value,style: TextStyle(
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
