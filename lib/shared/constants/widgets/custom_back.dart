import 'dart:developer';

import 'package:fcc_app_front/export.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    this.path,
    this.pop = false,
    Key? key,
  }) : super(key: key);
  final String? path;
  final bool pop;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (pop == false) {
          if (path != null) {
            try {
              if (path == RoutesNames.menu) {
                if (context.read<SelectedMembershipCubit>().state == null) {
                  context.read<SelectedMembershipCubit>().change(
                        MembershipType.standard,
                      );
                }
                context.goNamed(RoutesNames.menu);
              } else {
                context.goNamed(path!);
              }
            } catch (e) {
              log("Couldn't go to page: $e");
            }
          } else {
            canPopThenPop(context);
          }
        } else {
          canPopThenPop(context);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: 5.h,
          bottom: 5.h,
          right: 5.w,
        ),
        child: Row(
          children: <Widget>[
            const Icon(
              Icons.arrow_back_ios_new,
              size: 13,
              color: primaryColorDark,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              'Назад',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
