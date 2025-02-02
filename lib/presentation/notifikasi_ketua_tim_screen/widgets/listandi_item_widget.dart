import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

// ignore_for_file: must_be_immutable
class ListandiItemWidget extends StatelessWidget {
  final String userName;
  final String description;
  final String status;
  final String type;
  final Color backgroundColor;
  final VoidCallback? onTapRow;

  ListandiItemWidget({
    Key? key,
    required this.userName,
    required this.description,
    required this.status,
    required this.type,
    required this.backgroundColor,
    this.onTapRow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapRow,
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
                      imagePath: type == "Pengajuan Cuti"
                          ? ImageConstant.imgEllipse59
                          : type == "Presensi Manual"
                              ? ImageConstant.imgEllipse60
                              : ImageConstant.imgEllipse61,
                      height: 48.h,
                      width: double.maxFinite,
                      radius: BorderRadius.circular(24.0.h),
                    ),
                    CustomImageView(
                      imagePath: type == "Pengajuan Cuti"
                          ? ImageConstant.imgCalendarErrorcontainer
                          : type == "Presensi Manual"
                              ? ImageConstant.imgEditErrorcontainer
                              : ImageConstant.imgDownloadErrorcontainer,
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
                      userName,
                      style: theme.textTheme.titleSmall,
                    ),
                    Text(
                      description,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.h),
            if (status.isNotEmpty) // Tampilkan hanya jika status tidak kosong
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 4.h,
                  vertical: 2.h,
                ),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadiusStyle.roundedBorder4,
                ),
                child: Text(
                  status,
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
