import 'package:Tasky/domain/riverpod/experience_level_riv.dart';
import 'package:Tasky/presentation/widget/experience_level_drop_down_widget.dart';
import 'package:Tasky/routes/routes.dart';
import 'package:Tasky/services/auth_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:Tasky/theme/text_style.dart';

import '../../core/res/image_res.dart';
import '../../core/utils/utils.dart';
import '../../domain/riverpod/sign_in_riv.dart';
import '../../theme/colors.dart';
import '../widget/custom_elevated_button.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}
final _nameController = TextEditingController();
final _phoneController = TextEditingController();
final _yearOfExController = TextEditingController();
final _addressController = TextEditingController();
final _passwordController = TextEditingController();

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
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
              Stack(
                children: [
                  Container(
                    color: Colors.white,
                    height: Utils.screenHeight(context)/2.5,
                    width: Utils.screenWidth(context),
                    child: Image.asset(ImageRes.appSticker,
                      fit: BoxFit.fitWidth,),),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Text('Login',
                    style: Styles.titleStyle,),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 20,right: 20),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                     TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          labelText: 'Name...',
                          ),
                    ),
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
                        print(phone.completeNumber); // Get the complete phone number
                        ref.read(completeNumberProvider.notifier).state = phone.completeNumber;
                      },
                    ),
                    const SizedBox(height: 15,),
                     TextField(
                       keyboardType: TextInputType.phone,
                      controller: _yearOfExController,
                      decoration: InputDecoration(
                          labelText: 'Years of experience...',
                         ),
                    ),
                    const SizedBox(height: 20,),
                    ExperienceLevelDropDownWidget(),
                    const SizedBox(height: 20,),
                     TextField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        labelText: 'Address...',
                      ),
                    ),
                    const SizedBox(height: 20,),
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
                      onPressed: () async{
                        print('signUp clicked');
                        final experienceYears = int.tryParse(_yearOfExController.text);

                       await   authServices. signUp(
                         password:
                             _passwordController.text,
                         address:
                             _addressController.text,
                             displayName: _nameController.text,
                             experienceYears: experienceYears!,
                             level: '${ref.watch(selectedLevelProvider)}',
                         phone:
                         ref.watch(completeNumberProvider),
                         context: context,
                         ref: ref
                         ).then((_) {
                           print('Sign Up process completed');
                         }).catchError((e) {
                           print('Error during sign up: $e');
                         });

                      },
                      child: const Text('Sign Up',
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
                        text: 'Already have an account?  ',
                        style: Styles.fadeTextStyle
                    ),
                    TextSpan(
                      recognizer:TapGestureRecognizer()
                        ..onTap = (){
                          context.go(Routes.signInScreen);
                        },
                        text: 'Sign In',
                        style:Styles.linkStyle
                    )
                  ]
              )),
              const SizedBox(height: 30,)
            ]),
      ),
    );
  }
}
