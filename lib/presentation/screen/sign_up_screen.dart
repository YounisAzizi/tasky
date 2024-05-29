import 'package:Tasky/domain/riverpod/experience_level_riv.dart';
import 'package:Tasky/presentation/widget/custom_text_field.dart';
import 'package:Tasky/presentation/widget/experience_level_drop_down_widget.dart';
import 'package:Tasky/routes/routes.dart';
import 'package:Tasky/services/auth_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_form_field/phone_form_field.dart';
import '../../domain/riverpod/password_bool_riv.dart';
import '../../domain/riverpod/sign_in_riv.dart';
import '../../theme/colors.dart';
import '../widget/custom_elevated_button.dart';
import '../widget/sticker_widget.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

final _nameController = TextEditingController();
final _phoneController = PhoneController();
final _yearOfExController = TextEditingController();
final _addressController = TextEditingController();
final _passwordController = TextEditingController();

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    AuthServices authServices = AuthServices();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  StickerWidget(
                    isSignUp: true,
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: Color.fromRGBO(36, 37, 44, 1)),
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                        controller: _nameController, hintText: 'Name...'),
                    const SizedBox(
                      height: 20,
                    ),
                    PhoneFormField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(186, 186, 186, 1))),
                          hintText: '123456-7890',
                          hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(186, 186, 186, 1))),
                      countrySelectorNavigator:
                          const CountrySelectorNavigator.page(),
                      onChanged: (phoneNumber) {
                        print(phoneNumber.international);
                        ref
                            .read(appDataProvider.notifier)
                            .setCompleteNumber(phoneNumber.international);
                      },
                      enabled: true,
                      isCountrySelectionEnabled: true,
                      isCountryButtonPersistent: true,
                      countryButtonStyle: const CountryButtonStyle(
                          showFlag: true,
                          flagSize: 22,
                          textStyle: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(127, 127, 127, 1))),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                      controller: _yearOfExController,
                      hintText: 'Years of experience...',
                      textInputAction: TextInputType.phone,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ExperienceLevelDropDownWidget(),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                        controller: _addressController, hintText: 'Address...'),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Password...',
                      isObscure: ref.watch(passwordBoolProvider).beSecure,
                      suffixIcon: IconButton(
                          onPressed: () {
                            ref.read(passwordBoolProvider).toggleSecure();
                          },
                          style: ButtonStyle(
                            iconColor: WidgetStateProperty.all(Colors.grey),
                          ),
                          icon: Icon(!ref.watch(passwordBoolProvider).beSecure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomElevatedButton(
                      onPressed: () async {
                        print('signUp clicked');
                        final experienceYears =
                            int.tryParse(_yearOfExController.text);
                        if (_nameController.text.isNotEmpty &&
                            _yearOfExController.text.isNotEmpty &&
                            _addressController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty &&
                            ref
                                .watch(appDataProvider)
                                .completeNumber
                                .isNotEmpty &&
                            ref
                                .watch(levelManagerNotifierProvider)
                                .selectedLevel!
                                .isNotEmpty) {
                          await authServices
                              .signUp(
                                  password: _passwordController.text,
                                  address: _addressController.text,
                                  displayName: _nameController.text,
                                  experienceYears: experienceYears!,
                                  level:
                                      '${ref.watch(levelManagerNotifierProvider).selectedLevel}',
                                  phone:
                                      ref.watch(appDataProvider).completeNumber,
                                  context: context,
                                  ref: ref)
                              .then((_) {
                            print('Sign Up process completed');
                          }).catchError((e) {
                            print('Error during sign up: $e');
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('fill the textFields')));
                        }
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 17),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: 'Already have an account?  ',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(186, 186, 186, 1))),
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.go(Routes.signInScreen);
                      },
                    text: 'Sign in',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.mainThemColor))
              ])),
              const SizedBox(
                height: 30,
              )
            ]),
      ),
    );
  }
}
