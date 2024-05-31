import 'package:Tasky/const/image_res.dart';
import 'package:Tasky/routes/routes.dart';
import 'package:Tasky/state_managers/screens/profile_screen_provider.dart';
import 'package:Tasky/theme/colors.dart';
import 'package:Tasky/widgets/profile/custom_information_container_widget.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDataProvider).userData;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 42.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      context.go(Routes.mainScreen);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          ImageRes.backButton,
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            CustomInformationContainerWidget(
              title: 'Name',
              subtitle: userData['displayName'],
            ),
            CustomInformationContainerWidget(
                title: 'Phone',
                subtitle: userData['username'],
                hasLeading: true,
                trailing: InkWell(
                  onTap: () {
                    FlutterClipboard.copy(userData['username']).then((value) =>
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('${userData['username']} copied'))));
                  },
                  child: const Icon(
                    Icons.copy,
                    color: AppColors.mainThemColor,
                    size: 24,
                  ),
                )),
            CustomInformationContainerWidget(
                title: 'Level', subtitle: userData['level']),
            CustomInformationContainerWidget(
                title: 'Years of experience',
                subtitle: '${userData['experienceYears'].toString()} years'),
            CustomInformationContainerWidget(
                title: 'Location', subtitle: userData['address']),
          ],
        ),
      ),
    );
  }
}
