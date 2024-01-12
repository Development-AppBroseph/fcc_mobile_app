import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/constants/colors/color.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/on_tap_scale.dart';

// test
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.onChanged,
    required this.selectedIndex,
    required this.items,
  }) : super(key: key);

  final int selectedIndex;
  final List<BottomNavBarItem> items;
  final void Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(
              0,
              2,
            ),
            color: primaryColorDark.withOpacity(
              0.1,
            ),
            blurRadius: 40,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...items
              .map(
                (e) => Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 20.h),
                      child: OnTapScaleAndFade(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          onChanged(items.indexOf(e));
                        },
                        child: e.svgPicture,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}

class BottomNavBarItem {
  Widget svgPicture;
  BottomNavBarItem({required this.svgPicture});
}
