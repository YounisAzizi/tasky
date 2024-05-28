import 'package:Tasky/core/res/image_res.dart';
import 'package:Tasky/domain/riverpod/sign_in_riv.dart';
import 'package:Tasky/routes/routes.dart';
import 'package:Tasky/services/auth_services.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:Tasky/presentation/widget/profile/custom_information_container_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../domain/riverpod/profile_data_riv.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {


  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userDataProvider).userData;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      context.go(Routes.mainScreen);
                    },
                    icon: Row(
                      children: [
                        SvgPicture.asset(
                          ImageRes.backButton,
                          height: 30,
                          width: 30,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ],
                    )),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            CustomInformationContainerWidget(
                title: 'Name', subtitle: userData['displayName']),
            CustomInformationContainerWidget(
              title: 'Phone',
              subtitle: userData['username'],
              hasLeading: true,
              trailing: IconButton(
                  onPressed: () {
                    FlutterClipboard.copy(userData['username']).then((value) =>
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('${userData['username']} copied'))));
                  },
                  icon: const Icon(
                    Icons.copy,
                    color: Colors.deepPurple,
                  )),
            ),
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
