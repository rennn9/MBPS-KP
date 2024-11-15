import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';
import '';
import '../../../core/app_export.dart';
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_text_form_field.dart';
import 'columnview1_item_widget.dart';

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
