import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    super.key,
    required this.text,
    this.onFieldSubmitted,
    this.hintText,
    this.dateOnPressed,
    this.onEditingComplete,
    this.ref,
    this.timeOnPressed,
    this.isSuffix = false,
    this.isSearch = false,
    this.readOnly = false,
    this.isRequired = false,
    this.maxLines = 1,
    this.border,
    this.inputFormatters,
    this.validator,
    this.autoValidationMode,
    this.onChanged,
    this.textInputType,
    this.suffixIcon,
    this.prefix,
    this.obscureText = false,
    this.autoFocus = false,
    this.contentPadding,
    this.inputDecoration,
  });

  final String text;
  final ValueChanged<String>? onFieldSubmitted;
  final String? hintText;
  final VoidCallback? dateOnPressed;
  final VoidCallback? timeOnPressed;
  final VoidCallback? onEditingComplete;
  final WidgetRef? ref;
  final bool isSuffix;
  final bool isSearch;
  final bool readOnly;
  final bool isRequired;
  final bool obscureText;
  final bool autoFocus;
  final EdgeInsetsGeometry? contentPadding;
  final int maxLines;
  final InputBorder? border;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autoValidationMode;
  final ValueChanged<String>? onChanged;
  final TextInputType? textInputType;
  final Widget? suffixIcon;
  final Widget? prefix;
  final InputDecoration? inputDecoration;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  late TextEditingController controller;
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.text);
    if (widget.autoFocus) focusNode.requestFocus();
  }

  @override
  void didUpdateWidget(covariant TextFormFieldWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.text != widget.text && !focusNode.hasFocus) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => controller.text = widget.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) => TextFormField(
        onChanged: widget.onChanged,
        autovalidateMode: widget.autoValidationMode,
        style: const TextStyle(color: Colors.black),
        readOnly: widget.readOnly || widget.isSuffix,
        maxLines: widget.maxLines,
        focusNode: focusNode,
        obscureText: widget.obscureText,
        keyboardType: widget.textInputType,
        onEditingComplete: widget.onEditingComplete,
        decoration: widget.inputDecoration ??
            InputDecoration(
              hintText: widget.hintText,
              filled: true,
              fillColor: Colors.white,
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefix,
              contentPadding: widget.contentPadding,
            ),
        onFieldSubmitted: widget.onFieldSubmitted,
        validator: widget.validator,
        controller: controller,
        inputFormatters: widget.inputFormatters,
      );
}
