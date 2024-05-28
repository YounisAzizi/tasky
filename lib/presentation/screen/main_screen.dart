import 'package:Tasky/core/res/image_res.dart';
import 'package:Tasky/domain/riverpod/is_todo_editing_riv.dart';
import 'package:Tasky/domain/riverpod/todos_riv.dart';
import 'package:Tasky/routes/routes.dart';
import 'package:Tasky/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:Tasky/theme/text_style.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/riverpod/sign_in_riv.dart';
import '../../domain/riverpod/tab_bar_riv.dart';
import '../widget/custom_tab_bar_widget.dart';
import '../widget/task_list_view_widget.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AuthServices().fetchListTodos(
        1,
        ref.watch(appDataProvider).storeToken,
        ref,
        context,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final statusNotifier = ref.watch(statusProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Logo',
                        style: Styles.mainTitleStyle,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              AuthServices()
                                  .getProfile(ref.watch(appDataProvider).storeToken, ref, context)
                                  .whenComplete(() {
                                context.go(Routes.profileScreen);
                              });
                            },
                            icon: const Icon(
                              Icons.account_circle_outlined,
                              color: Colors.black,
                              size: 34,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              AuthServices().logOut(
                                ref.watch(appDataProvider).storeToken,
                                context,
                                ref,
                              );
                            },
                            icon: const Icon(
                              Icons.logout,
                              color: Colors.deepPurple,
                              size: 34,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Text(
                  'My Tasks',
                  style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: Status.values.map((status) {
                    return CustomTabBarWidget(
                      data: statusToString(status),
                      isSelected: statusNotifier.selectedStatus == status,
                      onTap: () => ref.read(statusProvider).setSelectedStatus(status),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: TaskListView(status: statusNotifier.selectedStatus),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 100,
            right: 25,
            child: Container(
              height: 55,
              width: 55,
              color: Colors.white,
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                radius: 30,
                child: Icon(Icons.qr_code, color: Colors.deepPurple),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 70,
        width: 70,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              ref.read(isTodoEditingProvider).setEditing(false);
              final index = 0;
              context.go('${Routes.addNewTaskScreen}${index}');
              context.go('${Routes.addNewTaskScreen.replaceFirst(':index', '${index}')}');
            },
            shape: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(color: Colors.white),
            ),
            backgroundColor: Colors.deepPurple,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
String statusToString(Status status) {
  switch (status) {
    case Status.all:
      return 'All';
    case Status.inProgress:
      return 'Inprogress';
    case Status.waiting:
      return 'Waiting';
    case Status.finished:
      return 'Finished';
    default:
      return '';
  }
}
