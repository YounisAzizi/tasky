import 'package:Tasky/presentation/screen/add_new_task_screen.dart';
import 'package:Tasky/presentation/screen/main_screen.dart';
import 'package:Tasky/presentation/screen/profile_screen.dart';
import 'package:Tasky/presentation/screen/sign_in_screen.dart';
import 'package:Tasky/presentation/screen/sign_up_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:Tasky/routes/routes.dart';

import '../presentation/screen/task_details_screen.dart';
import '../presentation/widget/splash_wrapper_widget.dart';

class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(initialLocation: Routes.splashWrapper, routes: [
      //splashWrapper
      GoRoute(
          path: Routes.splashWrapper,
          builder: (context, state) {
            return const SplashWrapper();
          }),
      //signInScreen
      GoRoute(
          path: Routes.signInScreen,
          builder: (context, state) {
            return const SignInScreen();
          }),
      //signUpScreen
      GoRoute(
          path: Routes.signUpScreen,
          builder: (context, state) {
            return const SignUpScreen();
          }),
      //mainScreen
      GoRoute(
          path: Routes.mainScreen,
          builder: (context, state) {
            return const MainScreen();
          }),
      //taskDetails
      GoRoute(
          path: Routes.taskDetails,
          builder: (context, state) {
            final index = int.parse(state.pathParameters["index"]!);
            return  TaskDetailsScreen(index: index,);
          }),
      //addNewTaskScreen
      GoRoute(
        path: Routes.addNewTaskScreen,
        builder: (context, state) {
          final index = int.parse(state.pathParameters["index"]!);
          return AddNewTaskScreen(
            index: index,
          );
        },
      ),

      //profileScreen
      GoRoute(
          path: Routes.profileScreen,
          builder: (context, state) {
            return const ProfileScreen();
          }),
    ]);
  }
}
