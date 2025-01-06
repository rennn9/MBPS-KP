import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class Columndiajukan1ItemWidget extends StatelessWidget {
  const Columndiajukan1ItemWidget({Key? key})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(
        left: 10.h,
        bottom: 24.h,
      ),
      padding: EdgeInsets.only(left: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Diajukan",
            style: CustomTextStyles.labelLargeMedium,
          )
        ],
      ),
    );
  }
}
