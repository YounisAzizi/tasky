import 'package:flutter/material.dart';

class CustomTaskDetailsContainerWidget extends StatelessWidget {
  const CustomTaskDetailsContainerWidget(
      {super.key, required this.isDate, required this.title, required this.icon});
  final bool isDate;
  final Widget title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
      color: Colors.deepPurple.withOpacity(0.1),
        borderRadius: const BorderRadius.all(
          Radius.circular(10)
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding:isDate?const EdgeInsets.only(left: 14,top: 10): const EdgeInsets.only(top: 18.0,bottom: 8.0,left: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isDate)
                  const Text(
                    'End Date',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                title
              ],
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(icon,color: Colors.deepPurple,size: 20,))
        ],
      ),
    );
  }
}
