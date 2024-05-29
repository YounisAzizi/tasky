import 'package:Tasky/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/riverpod/experience_level_riv.dart';



class ExperienceLevelDropDownWidget extends ConsumerStatefulWidget {
  const ExperienceLevelDropDownWidget({super.key});

  @override
  ConsumerState<ExperienceLevelDropDownWidget> createState() => _ExperienceLevelDropDownWidgetState();
}

class _ExperienceLevelDropDownWidgetState extends ConsumerState<ExperienceLevelDropDownWidget> {

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: Utils.screenWidth(context),
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(186, 186, 186, 1), width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButton<String>(
        underline: SizedBox(),
        padding: EdgeInsets.only(left: 20),
        hint: const Text('Choose experience level',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(47, 47, 47, 1)
        ),),
        value: ref.watch(levelManagerNotifierProvider).selectedLevel,
        onChanged: (String? newValue) {

            ref.read(levelManagerNotifierProvider.notifier).setLevel(newValue);
            print(ref.watch(levelManagerNotifierProvider));
        },
        items: ref.watch(levelManagerNotifierProvider).levels
            .map<DropdownMenuItem<String>>((String level) {
          return DropdownMenuItem<String>(
            value: level,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(level),
            ),
          );
        }).toList(),
        icon:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(width: Utils.screenWidth(context)*0.34,),
            Icon(Icons.keyboard_arrow_down_outlined,
            size: 32,
            color: Color.fromRGBO(127, 127, 127, 1).withOpacity(0.8),),
          ],
        ),
      ),
    );
  }
}
