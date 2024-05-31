import 'package:Tasky/const/const.dart';
import 'package:Tasky/routes/routes.dart';
import 'package:Tasky/screens/add_new_task_screen.dart';
import 'package:Tasky/screens/main_screen.dart';
import 'package:Tasky/screens/profile_screen.dart';
import 'package:Tasky/screens/sign_in_screen.dart';
import 'package:Tasky/screens/sign_up_screen.dart';
import 'package:Tasky/screens/task_details_screen.dart';
import 'package:Tasky/widgets/splash_wrapper_widget.dart';
import 'package:go_router/go_router.dart';

import '../screens/qr_scanner_screen.dart';

class AppRouter {
  static GoRouter createRouter() => GoRouter(
        initialLocation: Routes.splashWrapper,
        routes: [
          GoRoute(
            path: Routes.splashWrapper,
            builder: (context, state) {
              return const SplashWrapper();
            },
          ),
          GoRoute(
            path: Routes.signInScreen,
            builder: (context, state) {
              return SignInScreen();
            },
          ),
          GoRoute(
            path: Routes.signUpScreen,
            builder: (context, state) {
              return const SignUpScreen();
            },
          ),
          GoRoute(
            path: Routes.mainScreen,
            builder: (context, state) {
              return const MainScreen();
            },
          ),
          GoRoute(
            path: Routes.taskDetails,
            builder: (context, state) {
              final index = int.parse(state.pathParameters[paramsFieldName]!);
              return TaskDetailsScreen(index: index);
            },
          ),
          GoRoute(
            path: Routes.addNewTaskScreen,
            builder: (context, state) {
              final index = int.parse(state.pathParameters[paramsFieldName]!);

              return AddNewTaskScreen(index: index);
            },
          ),
          GoRoute(
            path: Routes.profileScreen,
            builder: (context, state) {
              return const ProfileScreen();
            },
          ),
          GoRoute(
              path: Routes.qrScanner,
              builder: (context, state) {
                return   QrScannerScreen();
              }),

        ],
      );
}
