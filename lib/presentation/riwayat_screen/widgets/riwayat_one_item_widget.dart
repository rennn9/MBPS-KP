import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

// ignore_for_file: must_be_immutable
class RiwayatOneItemWidget extends StatelessWidget {
  final String title;
  final String description;
  final String status;
  final String date;
  final VoidCallback? onTapRow;

  RiwayatOneItemWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.status,
    required this.date,
    this.onTapRow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapRow?.call();
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
                      color: Colors.black,
                    ),
                  ),
                  if (status.isNotEmpty) // Only show status if it's not empty
                    SizedBox(
                      width: double.maxFinite,
                      child: Row(
                        children: [
                          // Icon for status
                          _buildStatusIcon(status),
                          SizedBox(width: 4.h),
                          Text(
                            status,
                            style: TextStyle(
                              color: _getStatusColor(status),
                              fontSize: 10.h,
                            ),
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
              child: Text(
                date,
                style: theme.textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the status icon based on the status text
  Widget _buildStatusIcon(String status) {
    if (status.contains("Sedang diproses") || status.contains("Menunggu")) {
      return Container(
        height: 10.h,
        width: 10.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green,
        ),
      );
    } else if (status.contains("Disetujui")) {
      return CustomImageView(
        imagePath: ImageConstant.imgCheckmark,
        height: 10.h,
        width: 10.h,
      );
    } else if (status.contains("Ditolak") || status.contains("Dibatalkan")) {
      return CustomImageView(
        imagePath: ImageConstant.imgCrossCircle,
        height: 10.h,
        width: 10.h,
      );
    }
    return SizedBox.shrink(); // Default empty widget
  }

  /// Returns the color for the status text based on the status
  Color _getStatusColor(String status) {
    if (status.contains("Sedang diproses") || status.contains("Menunggu")) {
      return Colors.green;
    } else if (status.contains("Disetujui")) {
      return Colors.green;
    } else if (status.contains("Ditolak") || status.contains("Dibatalkan")) {
      return Colors.red;
    }
    return Colors.black; // Default color
  }
}
