import 'dart:convert';
import 'dart:developer';

import 'package:fcc_app_front/shared/constants/colors/color.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

dynamic showLoginErrorSnackbar(BuildContext context, Response response) {
  try {
    final Map body = jsonDecode(
      utf8.decode(
        response.bodyBytes,
      ),
    ) as Map;
    String message = '';
    try {
      if (body['date_of_birth'] != null) {
        message = (body['date_of_birth'] as List).first;
      }
    } catch (e) {
      log('Error while date_of_birth');
    }
    try {
      if (body['username'] != null) {
        message = (body['username'] as List).first;
      }
    } catch (e) {
      log('Error while date_of_birth');
    }
    try {
      if (body['messages'] != null) {
        message = (body['messages'] as List).first;
      }
    } catch (e) {
      log('Error while date_of_birth');
    }
    if (message == '') {
      message = 'Что-то пошло не так, пожалуйста, введите свои данные еще раз.';
    }
    final SnackBar snackBar = SnackBar(
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
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Error happened',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: primaryColorLight,
              ),
        ),
      ),
    );
  }
}
