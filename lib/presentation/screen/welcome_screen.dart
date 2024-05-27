import 'package:Tasky/core/res/image_res.dart';
import 'package:Tasky/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:Tasky/core/utils/utils.dart';
import 'package:Tasky/presentation/widget/custom_elevated_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Container(
              color: Colors.white,
                height: Utils.screenHeight(context)/1.8,
                width: Utils.screenWidth(context),
                child: Image.asset(ImageRes.appSticker,
                fit: BoxFit.cover,),),
            const Text('Task Management & \n To-Do List',
            textAlign: TextAlign.center,
            style:TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontFamily: 'Phosphate',
              fontWeight: FontWeight.w500,
              height: 0,
            ),),
            const SizedBox(height: 20,),
            const Text(
                'This productive tool is designed to help\n'
                '\n'
                    'you better manage your task\n'
                    '\n'
                    'project-wise conveniently',
              textAlign: TextAlign.center,
              style:TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Phosphate',
                fontWeight: FontWeight.w300,
                height: 0,
              ),),
            const SizedBox(height: 30,),
            CustomElevatedButton(
              onPressed: () {
                context.go(Routes.signInScreen);
              },
              child:  Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Let\'s Start',
                style: TextStyle(color: Colors.white,fontWeight:
                FontWeight.bold,
                fontSize: 18),),
                SizedBox(width: 5,),
                SvgPicture.asset(ImageRes.forwardButton,height: 30,width: 30,),
              ],
            ), )
        ]),
      ),
    );
  }
}
