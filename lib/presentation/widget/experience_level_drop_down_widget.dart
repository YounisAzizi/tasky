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
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButton<String>(
        underline: SizedBox(),
        padding: EdgeInsets.only(left: 20),
        hint: const Text('Choose experience level'),
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
          children: [
            SizedBox(width: Utils.screenWidth(context)/4,),
            Icon(Icons.keyboard_arrow_down_outlined),
          ],
        ),
      ),
    );
  }
}