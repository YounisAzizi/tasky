import 'package:Tasky/routes/routes.dart';
import 'package:Tasky/state_managers/data/sign_in_data_provider.dart';
import 'package:Tasky/state_managers/screens/password_bool_riv.dart';
import 'package:Tasky/utils/shared_prefs.dart';
import 'package:Tasky/utils/utils.dart';
import 'package:Tasky/widgets/custom_elevated_button.dart';
import 'package:Tasky/widgets/sticker_widget.dart';
import 'package:Tasky/widgets/text_form_field_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../theme/colors.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completeNumber = SharedPrefs.getCompleteNumber();
    final signInDataState = ref.watch(signInDataProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StickerWidget(),
            Form(
              key: signInDataState.formKey,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Login',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 30),
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
                      onChanged: (phoneNumber) => SharedPrefs.setCompleteNumber(
                        phoneNumber.international,
                      ),
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
                      text: signInDataState.password,
                      hintText: 'Password...',
                      obscureText: ref.watch(passwordBoolProvider).beSecure,
                      onChanged: (password) {
                        ref.read(signInDataProvider).password = password;
                      },
                      validator: (password) {
                        if (password == null || password.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        onPressed: () {
                          ref.read(passwordBoolProvider).toggleSecure();
                        },
                        style: ButtonStyle(
                          iconColor: WidgetStateProperty.all(Colors.grey),
                        ),
                        icon: Icon(
                          color: Color.fromRGBO(186, 186, 186, 1),
                          !ref.watch(passwordBoolProvider).beSecure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomElevatedButton(
                      onPressed: () async {
                        if (signInDataState.formKey.currentState!.validate()) {
                          await ref.read(signInDataProvider).signIn(
                                phone: completeNumber,
                                context: context,
                                ref: ref,
                              );
                        }
                      },
                      child: const Text(
                        'Sign In',
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
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'Didn\'t have any account?  ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(186, 186, 186, 1),
                  ),
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.go(Routes.signUpScreen);
                    },
                  text: 'Sign Up here',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mainThemColor,
                  ),
                )
              ]),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
