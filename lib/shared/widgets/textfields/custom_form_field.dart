import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/colors/color.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField({
    Key? key,
    this.controller,
    this.textInputAction,
    this.hintText,
    this.textInputType,
    this.textInputFormatter,
    this.validator,
    this.initialValue,
  }) : super(key: key);
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final String? hintText;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? textInputFormatter;
  final String? Function(String? value)? validator;
  final String? initialValue;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null && widget.controller != null) {
      widget.controller?.text = widget.initialValue ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Theme.of(context).primaryColorLight,
        ),
      ),
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 17,
              color: Theme.of(context).hintColor,
            ),
        textInputAction: widget.textInputAction,
        controller: widget.controller,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 12,
                color: hintColor,
              ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        inputFormatters: widget.textInputFormatter,
        keyboardType: widget.textInputType,
        validator: widget.validator,
      ),
    );
  }
}
