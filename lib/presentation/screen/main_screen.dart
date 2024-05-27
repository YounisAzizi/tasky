import 'package:Tasky/core/res/image_res.dart';
import 'package:Tasky/domain/riverpod/todos_riv.dart';
import 'package:Tasky/routes/routes.dart';
import 'package:Tasky/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:Tasky/theme/text_style.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/riverpod/sign_in_riv.dart';
import '../widget/custom_tab_bar_widget.dart';
import '../widget/task_list_view_widget.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  Status _selectedStatus = Status.all;

  void _onStatusSelected(Status status) {
    setState(() {
      _selectedStatus = status;
    });
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AuthServices().fetchTodos(1, ref.watch(storeTokenProvider),ref);
    },);
  }

  @override
  Widget build(BuildContext context) {
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
                        style: Styles.titleStyle,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async{
                               AuthServices().getProfile(ref.watch(storeTokenProvider), ref)
                              .whenComplete(() {
                              context.go(Routes.profileScreen);

                              },);
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
                                ref.watch(storeTokenProvider),
                                context
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
                      isSelected: _selectedStatus == status,
                      onTap: () => _onStatusSelected(status),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: TaskListView(status: _selectedStatus),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 80,
            right: 20,
            child: Container(
              height: 50,
              width: 50,
              color: Colors.white,
              child: CircleAvatar(
                radius: 30,
                child: Image.asset(ImageRes.iconQrCode,
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton:  FloatingActionButton(
          onPressed: () {
            context.go(Routes.addNewTaskScreen);
          },
        shape: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))
        ),
          backgroundColor: Colors.deepPurple,
          child: const Icon(
            Icons.add,
            color: Colors.white,
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
      return 'inprogress';
    case Status.waiting:
      return 'waiting';
    case Status.finished:
      return 'finished';
    default:
      return '';
  }
}

enum Status {
  all,
  inProgress,
  waiting,
  finished,
}
