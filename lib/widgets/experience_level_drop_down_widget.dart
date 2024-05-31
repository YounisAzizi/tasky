import 'package:Tasky/models/level_enum.dart';
import 'package:Tasky/state_managers/screens/sign_up_screen_provider.dart';
import 'package:Tasky/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExperienceLevelDropDownWidget extends ConsumerWidget {
  const ExperienceLevelDropDownWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpScreenState = ref.watch(signUpScreenProvider);

    return Container(
      height: 50,
      width: Utils.screenWidth(context),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(186, 186, 186, 1), width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButton<LevelEnum>(
        underline: SizedBox(),
        padding: EdgeInsets.only(left: 20),
        hint: const Text(
          ' Choose experience level',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(47, 47, 47, 1),
          ),
        ),
        value: signUpScreenState.signUpModel.level,
        onChanged: (newValue) {
          final newSignUpModel =
              signUpScreenState.signUpModel.copyWith(level: newValue);
          ref.read(signUpScreenProvider).signUpModel = newSignUpModel;
        },
        items: ref
            .watch(signUpScreenProvider)
            .levels
            .map<DropdownMenuItem<LevelEnum>>((level) {
          return DropdownMenuItem<LevelEnum>(
            value: level,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(level.name),
            ),
          );
        }).toList(),
        isExpanded: true,
        icon: Icon(
          Icons.keyboard_arrow_down_outlined,
          size: 32,
          color: Color.fromRGBO(127, 127, 127, 1).withOpacity(0.8),
        ),
      ),
    );
  }
}
