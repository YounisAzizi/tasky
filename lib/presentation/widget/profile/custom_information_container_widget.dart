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
      padding:  EdgeInsets.all(8.0),
      child: Container(
          constraints: BoxConstraints(
            minHeight: 80,
          ),
        decoration: BoxDecoration(
        color: Colors.grey.shade200,
          borderRadius: const BorderRadius.all(
            Radius.circular(12)
          )
        ),
        child: ListTile(
          title: Text(title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(47, 47, 47, 0.4)
          ),),
          subtitle: Text(subtitle,
          textAlign: TextAlign.start,
          style: Styles.profileSubTitle,),
          trailing:hasLeading? trailing:const SizedBox(),
        ),
      ),
    );
  }
}
