import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

// ignore_for_file: must_be_immutable
class RiwayatOneItemWidget extends StatelessWidget {
  final String title;
  final String description;
  final String status;
  final String date;
  final VoidCallback? onTapRow18oktober;

  RiwayatOneItemWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.status,
    required this.date,
    this.onTapRow18oktober,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapRow18oktober?.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.h,
          vertical: 6.h,
        ),
        decoration: BoxDecoration(
          color: appTheme.whiteA700,
          borderRadius: BorderRadiusStyle.roundedBorder14,
          border: Border.all(
            color: theme.colorScheme.errorContainer,
            width: 1.h,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.errorContainer.withOpacity(0.25),
              spreadRadius: 2.h,
              blurRadius: 2.h,
              offset: Offset(
                0,
                4,
              ),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgCalendarErrorcontainer,
              height: 40.h,
              width: 40.h,
            ),
            SizedBox(width: 12.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 10.h,
                      color: Colors.black
                    ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: status == "Disetujui"
                            ? ImageConstant.imgCheckmark
                            : ImageConstant.imgCrossCircle,
                          height: 10.h,
                          width: 10.h,
                        ),
                        SizedBox(width: 4.h),
                        Text(
                          status,
                          style: TextStyle(
                            color: status == "Disetujui" ? Colors.green : Colors.red,
                            fontSize: 10.h
                          )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.h),
            Align(
              alignment: Alignment.topCenter,
              child: 
              Text(
                date,
                style: theme.textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
