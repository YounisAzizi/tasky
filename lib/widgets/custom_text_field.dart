import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      this.isObscure = false,
      this.suffixIcon,
      required this.hintText,
      this.textInputAction = TextInputType.emailAddress});
  final TextEditingController controller;
  final bool? isObscure;
  final Widget? suffixIcon;
  final String hintText;
  final TextInputType? textInputAction;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        keyboardType: widget.textInputAction!,
        controller: widget.controller,
        obscureText: widget.isObscure!,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(127, 127, 127, 1)),
          suffixIcon: widget.suffixIcon,
        ),
      ),
    );
  }
}
