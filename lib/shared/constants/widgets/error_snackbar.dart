import 'package:fcc_app_front/shared/constants/colors/color.dart';
import 'package:flutter/material.dart';

showErrorSnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: primaryColorLight,
          ),
    ),
    backgroundColor: textColor,
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
