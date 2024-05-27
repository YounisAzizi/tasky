import 'package:flutter/material.dart';

import '../../../theme/text_style.dart';

class CustomInformationContainerWidget extends StatelessWidget {
  const CustomInformationContainerWidget({super.key, required this.title, required this.subtitle,this.trailing,this.hasLeading=false});
  final String title;
  final String subtitle;
  final Widget? trailing;
  final bool hasLeading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
        color: Colors.grey.shade200,
          borderRadius: const BorderRadius.all(
            Radius.circular(12)
          )
        ),
        height: 80,
        child: ListTile(
          title: Text(title,
          style: Styles.fadeTextStyle,),
          subtitle: Text(subtitle,
          style: Styles.profileSubTitle,),
          trailing:hasLeading? trailing:const SizedBox(),
        ),
      ),
    );
  }
}
