import 'package:Tasky/const/const.dart';
import 'package:Tasky/models/ui_status_enum.dart';
import 'package:Tasky/routes/routes.dart';
import 'package:Tasky/services/auth_services.dart';
import 'package:Tasky/state_managers/screens/main_screen_provider.dart';
import 'package:Tasky/state_managers/screens/new_task_screen_provider.dart';
import 'package:Tasky/state_managers/screens/profile_screen_provider.dart';
import 'package:Tasky/theme/colors.dart';
import 'package:Tasky/theme/text_style.dart';
import 'package:Tasky/widgets/custom_tab_bar_widget.dart';
import 'package:Tasky/widgets/task_list_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
      ref.read(mainScreenProvider).fetchListTodos(
            1,
            ref,
            context,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final statusNotifier = ref.watch(mainScreenProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Logo', style: Styles.mainTitleStyle),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              ref
                                  .read(userDataProvider)
                                  .getProfile(
                                    ref,
                                    context,
                                  )
                                  .whenComplete(() {
                                context.go(Routes.profileScreen);
                              });
                            },
                            child: const Icon(
                              Icons.account_circle_outlined,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              AuthServices.logOut(
                                context,
                                ref,
                              );
                            },
                            child: const Icon(
                              Icons.logout,
                              color: AppColors.mainThemColor,
                              size: 24,
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
                    color: Color.fromRGBO(36, 37, 44, 0.6),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: UiStatus.values.map((status) {
                    return CustomTabBarWidget(
                      data: status.name,
                      isSelected: statusNotifier.selectedStatus == status,
                      onTap: () => ref
                          .read(mainScreenProvider)
                          .setSelectedStatus(status),
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
            child: InkWell(
              onTap: () {
                context.go(Routes.qrScanner);
              },
              child: CircleAvatar(
                backgroundColor: Color.fromRGBO(235, 229, 255, 1),
                radius: 24,
                child: Icon(
                  Icons.qr_code_rounded,
                  color: AppColors.mainThemColor,
                  size: 24,
                ),
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
              ref.read(newTaskScreenProvider).isEditing = false;
              final index = 0;
              context.go('${Routes.addNewTaskScreen}${index}');
              context.go(
                  '${Routes.addNewTaskScreen.replaceFirst(':$paramsFieldName', '${index}')}');
            },
            shape: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              borderSide: BorderSide(color: Colors.white),
            ),
            backgroundColor: AppColors.mainThemColor,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}
