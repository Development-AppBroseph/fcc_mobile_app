import 'package:fcc_app_front/shared/constants/colors/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
    required this.onChanged,
    required this.selectedIndex,
    required this.items,
  });

  final int selectedIndex;
  final List<BottomNavBarItem> items;
  final void Function(int) onChanged;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: <BoxShadow>[
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ...widget.items
              .map(
                (BottomNavBarItem e) => Expanded(
                  child: Container(
                    width: 30,
                    height: 30,
                    margin: EdgeInsets.only(top: 15.h),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(60),
                          ),
                          onTap: () => widget.onChanged(
                                widget.items.indexOf(e),
                              ),
                          child: Ink(child: e.svgPicture)),
                    ),
                  ),
                ),
              )
              ,
        ],
      ),
    );
  }
}

class BottomNavBarItem {
  Widget svgPicture;
  BottomNavBarItem({required this.svgPicture});
}
