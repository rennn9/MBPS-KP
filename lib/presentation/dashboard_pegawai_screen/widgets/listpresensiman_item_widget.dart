import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg

class ListpresensimanItemWidget extends StatelessWidget {
  final String text;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedTextColor; // Parameter untuk warna teks yang terpilih

  const ListpresensimanItemWidget({
    Key? key,
    required this.text,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
    required this.selectedTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 104.h,
        height: 90.h,
        padding: EdgeInsets.symmetric(
          horizontal: 20.h,
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
            // Menggunakan SvgPicture dengan color untuk efek perubahan warna
            SvgPicture.asset(
              imagePath,
              height: 30.h,
              width: 32.h,
              color: isSelected ? selectedTextColor : Colors.black, // Ganti warna saat dipilih
            ),
            SizedBox(height: 2.h),
            Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: CustomTextStyles.bodySmallPrimary.copyWith(
                height: 1.50,
                color: isSelected ? selectedTextColor : appTheme.gray500, // Ganti warna teks saat dipilih
              ),
            )
          ],
        ),
      ),
    );
  }
}
