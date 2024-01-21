import 'package:fcc_app_front/export.dart';

class ErrorSnackBar {
  static Future<void> showErrorSnackBar(
      BuildContext context, String message, double textScaleFactor, EdgeInsets padding, int maxLines) async {
    showTopSnackBar(
      Overlay.of(context),
      SizedBox(
        width: 330.w,
        child: CustomSnackBar.error(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ],
          maxLines: maxLines,
          borderRadius: BorderRadius.circular(10),
          icon: const Icon(null),
          textScaleFactor: 0.9,
          messagePadding: padding,
          message: message,
          textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 14,
                color: scaffoldBackgroundColor,
              ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      ),
    );
  }
}
