import 'package:Tasky/domain/riverpod/password_bool_riv.dart';
import 'package:Tasky/presentation/widget/custom_text_field.dart';
import 'package:Tasky/presentation/widget/sticker_widget.dart';
import 'package:Tasky/routes/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_form_field/phone_form_field.dart';
import '../../core/utils/utils.dart';
import '../../domain/riverpod/sign_in_riv.dart';
import '../../services/auth_services.dart';
import '../../theme/colors.dart';
import '../widget/custom_elevated_button.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}
final _phoneController = PhoneController();
final _passwordController = TextEditingController();

class _SignInScreenState extends ConsumerState<SignInScreen> {

  @override
  void dispose() {
    super.dispose();
  }
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
              StickerWidget(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal:  35),
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
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),),
                    const SizedBox(height: 30,),
                PhoneFormField(
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(186, 186, 186, 1)
                      )
                    ),
                    hintText: '123456-7890',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(186, 186, 186, 1)
                        )
                  ),
                  onChanged: (phoneNumber){
                    print(phoneNumber.international);
                    ref.read(appDataProvider.notifier).setCompleteNumber(
                        phoneNumber.international);
                  },
                  enabled: true,
                  isCountrySelectionEnabled: true,
                  isCountryButtonPersistent: true,
                  countryButtonStyle: const CountryButtonStyle(
                      showFlag: true,

                      flagSize: 22,
                    textStyle: TextStyle(

                      fontSize: 14,
                      color: Color.fromRGBO(127, 127, 127, 1)
                    )
                  ),
                ),
                    const SizedBox(height: 15,),
                     CustomTextField(controller: _passwordController, hintText: 'Password...',
                     isObscure:ref.watch(passwordBoolProvider).beSecure ,
                     suffixIcon:  IconButton(onPressed:(){
                       ref.read(passwordBoolProvider).toggleSecure();
                     },
                         style: ButtonStyle(
                           iconColor:WidgetStateProperty.all(Colors.grey),
                         ),
                         icon:  Icon(
                             color: Color.fromRGBO(186, 186, 186, 1),
                             !ref.watch(passwordBoolProvider).beSecure?
                             Icons.visibility_off_outlined:
                             Icons.visibility_outlined)),),
                    const SizedBox(height: 20,),
                    CustomElevatedButton(
                      onPressed: ()async {
                        if(ref.watch(appDataProvider).completeNumber.isNotEmpty && _passwordController.text.isNotEmpty) {
                          await authServices.signIn(
                              phone: ref.watch(appDataProvider).completeNumber,
                              password: _passwordController.text,
                              context: context,
                            ref: ref
                          );
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('fill the textFields'))
                          );
                        }
                      },
                      child: const Text('Sign In',
                        style: TextStyle(color: Colors.white,fontWeight:
                        FontWeight.w700,
                            fontSize: 17),), )


                  ],
                ),
              ),
               const SizedBox(height: 10,),
               RichText(text:
                TextSpan(
                 children: [
                   TextSpan(
                     text: 'Didn\'t have any account?  ',
                     style: TextStyle(
                       fontSize: 14,
                       fontWeight: FontWeight.w400,
                       color: Color.fromRGBO(186, 186, 186, 1)
                     )
                   ),
                   TextSpan(
                     recognizer:  TapGestureRecognizer()
                       ..onTap = (){
                         context.go(Routes.signUpScreen);
                       },
                     text: 'Sign Up here',
                       style:TextStyle(
                         decoration: TextDecoration.underline,
                           fontSize: 14,
                           fontWeight: FontWeight.w700,
                           color: AppColors.mainThemColor
                       )
                   )
                 ]
               )),
              const SizedBox(height: 20,),

            ]),
      ),
    );
  }
}
