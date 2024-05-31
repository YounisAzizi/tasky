import 'package:Tasky/apis/apis.dart';
import 'package:Tasky/const/end_point.dart';
import 'package:Tasky/routes/routes.dart';
import 'package:Tasky/state_managers/screens/loading_notifier_riv.dart';
import 'package:Tasky/state_managers/screens/main_screen_provider.dart';
import 'package:Tasky/utils/shared_prefs.dart';
import 'package:Tasky/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final taskDetailsDataProvider = ChangeNotifierProvider<TaskDetailsDataProvider>(
  (ref) => TaskDetailsDataProvider(),
);

class TaskDetailsDataProvider extends ChangeNotifier {
  Future<void> deleteTodo(
    String todoId,
    BuildContext context,
    WidgetRef ref,
    int index,
  ) async {
    final String url = '${Apis.deleteTodo}$todoId';
    try {
      ref.read(loadingProvider).showLoading();
      Utils.showLoadingDialog(context, 'Deleting todo');
      final response = await Api.delete(
        url: url,
        headers: {
          'Authorization': 'Bearer ${SharedPrefs.getStoreToken()}',
        },
      );
      ref.read(loadingProvider).hideLoading();
      Utils.hideLoadingDialog(context);
      if (response == null) {
        Utils.showSnackBar(context, 'Something went wrong!');
      } else if (response.statusCode == 200) {
        context.go(Routes.mainScreen);
        ref.read(mainScreenProvider).removeTodoItem(index);
        Utils.showSnackBar(context, '${response.statusCode}');
      } else {
        Utils.showSnackBar(context, '${response.statusCode}');

        context.go(Routes.mainScreen);
      }
    } catch (e) {
      print(e);
    }
  }
}
