import 'package:flutter/material.dart';

class Utils{
  Utils._();
static double screenHeight(BuildContext context){
final screenHeight = MediaQuery.of(context).size.height;
return screenHeight;
}

  static double screenWidth(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth;
  }

  static void showSnackBar(BuildContext context,String content){
   ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(content))
  );
  }
  static void showLoadingDialog(BuildContext context,String content) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 70,
            width: 50,

            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircularProgressIndicator(),
                  Text('$content...')
                ],
              ),
            ),
          ),
        );
      },
    );
  }

 static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}