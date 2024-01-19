import 'package:fcc_app_front/export.dart';

dynamic showErrorSnackbar(BuildContext context, String message) {
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
}
