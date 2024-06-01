import 'package:Tasky/routes/routes.dart';
import 'package:Tasky/state_managers/screens/password_bool_riv.dart';
import 'package:Tasky/state_managers/screens/sign_up_screen_provider.dart';
import 'package:Tasky/theme/colors.dart';
import 'package:Tasky/utils/shared_prefs.dart';
import 'package:Tasky/widgets/custom_elevated_button.dart';
import 'package:Tasky/widgets/experience_level_drop_down_widget.dart';
import 'package:Tasky/widgets/sticker_widget.dart';
import 'package:Tasky/widgets/text_form_field_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_form_field/phone_form_field.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpScreenState = ref.watch(signUpScreenProvider);
    final signUpModel = signUpScreenState.signUpModel;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                StickerWidget(isSignUp: true),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Text(
                    'SignUp',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Color.fromRGBO(36, 37, 44, 1),
                    ),
                  ),
                )
              ],
            ),
            Form(
              key: signUpScreenState.formKey,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormFieldWidget(
                      hintText: 'Name...',
                      text: signUpModel.displayName,
                      onChanged: (name) {
                        final newSignUpModel =
                            signUpModel.copyWith(displayName: name);

                        ref.read(signUpScreenProvider).signUpModel =
                            newSignUpModel;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    PhoneFormField(
                      initialValue: PhoneNumber(isoCode: IsoCode.EG, nsn: ''),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(186, 186, 186, 1),
                          ),
                        ),
                        hintText: '123456-7890',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(186, 186, 186, 1),
                        ),
                      ),
                      countrySelectorNavigator:
                          const CountrySelectorNavigator.page(),
                      onChanged: (phoneNumber) async {
                        await SharedPrefs.setCompleteNumber(
                          phoneNumber.international,
                        );
                        final newSignUpModel = signUpModel.copyWith(
                            phone: phoneNumber.international);

                        ref.read(signUpScreenProvider).signUpModel =
                            newSignUpModel;
                      },
                      enabled: true,
                      isCountrySelectionEnabled: true,
                      isCountryButtonPersistent: true,
                      countryButtonStyle: const CountryButtonStyle(
                        showFlag: true,
                        flagSize: 22,
                        textStyle: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(127, 127, 127, 1),
                        ),
                      ),
                      validator: (phoneNumber) {
                        if (phoneNumber == null ||
                            phoneNumber.international.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormFieldWidget(
                      text: '${signUpModel.experienceYears ?? ''}',
                      hintText: 'Years of experience...',
                      textInputType: TextInputType.number,
                      onChanged: (yearsOfExperience) {
                        if (yearsOfExperience.isNotEmpty) {
                          final newSignUpModel = signUpModel.copyWith(
                            experienceYears: int.parse(yearsOfExperience),
                          );

                          ref.read(signUpScreenProvider).signUpModel =
                              newSignUpModel;
                        }
                      },
                      validator: (yearsExperience) {
                        if (yearsExperience == null ||
                            yearsExperience.isEmpty) {
                          return 'Please enter your years of experience';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ExperienceLevelDropDownWidget(),
                    const SizedBox(height: 20),
                    TextFormFieldWidget(
                      text: '${signUpModel.address}',
                      hintText: 'Address...',
                      onChanged: (address) {
                        final newSignUpModel = signUpModel.copyWith(
                          address: address,
                        );

                        ref.read(signUpScreenProvider).signUpModel =
                            newSignUpModel;
                      },
                      validator: (address) {
                        if (address == null || address.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormFieldWidget(
                      text: '${signUpModel.password}',
                      hintText: 'Password...',
                      obscureText: ref.watch(passwordBoolProvider).beSecure,
                      suffixIcon: IconButton(
                        onPressed: () {
                          ref.read(passwordBoolProvider).toggleSecure();
                        },
                        style: ButtonStyle(
                          iconColor: WidgetStateProperty.all(Colors.grey),
                        ),
                        icon: Icon(!ref.watch(passwordBoolProvider).beSecure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                      ),
                      onChanged: (password) {
                        final newSignUpModel = signUpModel.copyWith(
                          password: password,
                        );

                        ref.read(signUpScreenProvider).signUpModel =
                            newSignUpModel;
                      },
                      validator: (password) {
                        if (password == null || password.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    CustomElevatedButton(
                      onPressed: () async {
                        print('signUp clicked');
                        if (signUpScreenState.formKey.currentState!
                            .validate()) {
                          ref
                              .read(signUpScreenProvider)
                              .signUp(context: context, ref: ref);
                        }
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'Already have an account?  ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(186, 186, 186, 1),
                  ),
                ),
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
                    color: AppColors.mainThemColor,
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
