import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

// ignore_for_file: must_be_immutable
class ListpresensimanItemWidget extends StatelessWidget {
  ListpresensimanItemWidget({Key? key, this.onTapColumnpresensim})
      : super(key: key);

  VoidCallback? onTapColumnpresensim;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 104.h,
      child: GestureDetector(
        onTap: () {
          onTapColumnpresensim?.call();
        },
        child: Container(
          width: 104.h,
          padding: EdgeInsets.symmetric(
            horizontal: 26.h,
            vertical: 16.h,
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
              SizedBox(height: 12.h),
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
        ),
      ),
    );
  }
}
