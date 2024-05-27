import 'package:Tasky/core/res/image_res.dart';
import 'package:Tasky/routes/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:Tasky/theme/text_style.dart';

import '../../core/utils/utils.dart';
import '../../domain/riverpod/sign_in_riv.dart';
import '../../services/auth_services.dart';
import '../../theme/colors.dart';
import '../widget/custom_elevated_button.dart';
import '../widget/splash_wrapper_widget.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}
final _phoneController = TextEditingController();
final _passwordController = TextEditingController();

class _SignInScreenState extends ConsumerState<SignInScreen> {

  @override
  Widget build(BuildContext context) {
    AuthServices authServices = AuthServices();
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
              Container(
                padding: const EdgeInsets.only(left: 20,right: 20),
                color: Colors.white,
                height: Utils.screenHeight(context)/2.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Login',
                      textAlign: TextAlign.left,
                      style:TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'Phosphate',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),),
                    const SizedBox(height: 20,),
                    IntlPhoneField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                  decoration:  InputDecoration(
                    labelText: 'Phone Number',
                    hintStyle:TextStyle(
                      color: AppColors.colorGrey.withOpacity(0.5),
                      fontSize: 12
                    ),
                  ),
                initialCountryCode: 'EG', // Set the initial country code
                onChanged: (phone) {
                  print(phone.completeNumber);
                  ref.read(completeNumberProvider.notifier).state = phone.completeNumber;
                  // Get the complete phone number
                },
              ),
                    const SizedBox(height: 15,),
                     TextField(
                       controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password...',
                        suffixIcon: IconButton(onPressed:(){},
                            style: ButtonStyle(
                              iconColor:WidgetStateProperty.all(Colors.grey),
                            ),
                            icon: const Icon(Icons.visibility_outlined))
                      ),

                      ),
                    const SizedBox(height: 20,),
                    CustomElevatedButton(
                      onPressed: ()async {
                        if(_phoneController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                          await authServices.signIn(
                              phone: ref.watch(completeNumberProvider),
                              password: _passwordController.text,
                              context: context,
                            ref: ref
                          ).whenComplete(() {
                            ref.read(isUserLoggedInProvider.notifier).state =true;
                          },);
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('fill the textFields'))
                          );
                        }
                      },
                      child: const Text('Sign In',
                        style: TextStyle(color: Colors.white,fontWeight:
                        FontWeight.bold,
                            fontSize: 18),), )


                  ],
                ),
              ),
               const SizedBox(height: 20,),
               RichText(text:
                TextSpan(
                 children: [
                   TextSpan(
                     text: 'Didn\'t have any account?  ',
                     style: Styles.fadeTextStyle
                   ),
                   TextSpan(
                     recognizer:  TapGestureRecognizer()
                       ..onTap = (){
                         context.go(Routes.signUpScreen);
                       },
                     text: 'Sign Up here',
                       style:Styles.linkStyle
                   )
                 ]
               ))
            ]),
      ),
    );
  }
}
