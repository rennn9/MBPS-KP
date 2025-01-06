import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

// ignore_for_file: must_be_immutable
class Listandi1ItemWidget extends StatelessWidget {
  Listandi1ItemWidget({Key? key, this.onTapRowandilatifah}) : super(key: key);

  final VoidCallback? onTapRowandilatifah;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapRowandilatifah,
      child: Container(
        padding: EdgeInsets.all(6.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusStyle.roundedBorder4,
          border: Border.all(
            color: appTheme.gray30001,
            width: 1.h,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 48.h,
                width: 48.h,
                margin: EdgeInsets.symmetric(vertical: 8.h),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgEllipse59,
                      height: 48.h,
                      width: double.maxFinite,
                      radius: BorderRadius.circular(24.0.h),
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgCalendarErrorcontainer,
                      height: 30.h,
                      width: 32.h,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Andi Latifah",
                      style: theme.textTheme.titleSmall,
                    ),
                    Text(
                      "Distribusi",
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.h),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 4.h,
                vertical: 2.h,
              ),
              decoration: BoxDecoration(
                color: appTheme.yellowA700,
                borderRadius: BorderRadiusStyle.roundedBorder4,
              ),
              child: Text(
                "Menunggu Persetujuan",
                textAlign: TextAlign.left,
                style: theme.textTheme.labelSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
