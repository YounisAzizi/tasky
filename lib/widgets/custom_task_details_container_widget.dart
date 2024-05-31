import 'package:Tasky/const/image_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/colors.dart';

class CustomTaskDetailsContainerWidget extends StatelessWidget {
  const CustomTaskDetailsContainerWidget(
      {super.key,
      required this.isDate,
      required this.title,
      required this.icon});
  final bool isDate;
  final Widget title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          color: Color.fromRGBO(240, 236, 255, 1),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: isDate
                ? const EdgeInsets.only(left: 14, top: 10)
                : const EdgeInsets.only(top: 18.0, bottom: 8.0, left: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isDate)
                  const Text(
                    'End Date',
                    style: TextStyle(
                        color: Color.fromRGBO(110, 106, 124, 1),
                        fontSize: 9,
                        fontWeight: FontWeight.w400),
                  ),
                if (isDate)
                  SizedBox(
                    height: 5,
                  ),
                title
              ],
            ),
          ),
          isDate
              ? Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: SvgPicture.asset(ImageRes.calender),
                )
              : IconButton(
                  onPressed: () {},
                  icon: Icon(
                    icon,
                    color: AppColors.mainThemColor,
                    size: 24,
                  ))
        ],
      ),
    );
  }
}
