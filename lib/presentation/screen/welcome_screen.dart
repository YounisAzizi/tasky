import 'package:Tasky/core/res/image_res.dart';
import 'package:Tasky/presentation/widget/sticker_widget.dart';
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
            StickerWidget(),
            const Text('Task Management & \n To-Do List',
            textAlign: TextAlign.center,
            style:TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontFamily: 'Phosphate',
              fontWeight: FontWeight.w700,
              height: 0,
            ),),
            const SizedBox(height: 20,),
            const Text(
                'This productive tool is designed to help\n'
                    'you better manage your task\n'
                    'project-wise conveniently',
              textAlign: TextAlign.center,
              style:TextStyle(
                color: Color.fromRGBO(110, 106, 124, 1),
                fontSize: 14,
                height: 1.5,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w400,
              ),),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: CustomElevatedButton(
                onPressed: () {
                  context.go(Routes.signInScreen);
                },
                child:  Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Let\'s Start',
                  style: TextStyle(color: Colors.white,fontWeight:
                  FontWeight.w700,
                  fontSize: 19),),
                  SizedBox(width: 5,),
                  SvgPicture.asset(ImageRes.forwardButton,height: 24,width: 24,),
                ],
              ), ),
            )
        ]),
      ),
    );
  }
}
