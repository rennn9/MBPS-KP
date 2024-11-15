import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class Listpresensiman2ItemWidget extends StatelessWidget {
  const Listpresensiman2ItemWidget({Key? key})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 104.h,
      padding: EdgeInsets.symmetric(
        horizontal: 26.h,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgEdit,
            height: 30.h,
            width: 32.h,
          ),
          SizedBox(height: 2.h),
          Text(
            "Presensi\nManual",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: CustomTextStyles.bodySmallPrimary.copyWith(
              height: 1.50,
            ),
          )
        ],
      ),
    );
  }
}
