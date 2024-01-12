import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fcc_app_front/shared/constants/widgets/custom_back.dart';
import 'package:fcc_app_front/shared/constants/widgets/sizedbox.dart';

import '../../../../shared/constants/colors/color.dart';

class FscDataPage extends StatelessWidget {
  const FscDataPage({
    Key? key,
    required this.data,
  }) : super(key: key);
  final MapEntry data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.h,
                  ),
                  child: CustomBackButton(),
                ),
                sized10,
                Text(
                  data.key,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: primaryColorDark,
                      ),
                ),
                sized30,
                Text(
                  data.value,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                sized20,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
