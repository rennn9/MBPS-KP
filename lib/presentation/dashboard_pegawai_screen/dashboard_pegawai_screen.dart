import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'widgets/listpresensiman_item_widget.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';

class DashboardPegawaiScreen extends StatefulWidget {
  DashboardPegawaiScreen({Key? key}) : super(key: key);

  @override
  _DashboardPegawaiScreenState createState() => _DashboardPegawaiScreenState();
}

class _DashboardPegawaiScreenState extends State<DashboardPegawaiScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(top: 100),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 48),
                  decoration: BoxDecoration(
                    color: appTheme.cyan100,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70),
                      topRight: Radius.circular(70),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 90),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildListpresensiman(context),
                        SizedBox(height: 14),
                        // Tombol Riwayat
                        CustomElevatedButton(
                          height: 50.h,
                          text: "Riwayat",
                          margin: EdgeInsets.symmetric(horizontal: 10.h),
                          buttonStyle: CustomButtonStyles.fillWhiteA,
                          buttonTextStyle: CustomTextStyles.titleSmallPrimary,
                          onPressed: () {
                            // Tambahkan logika untuk tombol "Riwayat"
                          },
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildColumnprice(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListpresensiman(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 10,
          children: List.generate(
            3,
            (index) {
              final texts = ["Presensi\nManual", "Pengajuan\nCuti", "KiP APP"];
              final imagePaths = [
                ImageConstant.imgEdit,
                ImageConstant.imgCalendar,
                ImageConstant.imgDownload
              ];
              return ListpresensimanItemWidget(
                text: texts[index],
                imagePath: imagePaths[index],
                isSelected: selectedIndex == index,
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                selectedTextColor: Color(0xFF3E9B97),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildColumnprice(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 24.h),
        padding: EdgeInsets.symmetric(horizontal: 18.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(horizontal: 12.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgLogoBps,
                    height: 28.h,
                    width: 38.h,
                    alignment: Alignment.center,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10.h,
                      top: 4.h,
                    ),
                    child: Text(
                      "BADAN PUSAT STATISTIK",
                      style: theme.textTheme.titleSmall,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                horizontal: 10.h,
                vertical: 12.h,
              ),
              decoration: BoxDecoration(
                color: appTheme.whiteA700,
                borderRadius: BorderRadiusStyle.roundedBorder14,
                border: Border.all(
                  color: appTheme.gray30001,
                  width: 1.h,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgAvatars3dAvatar21,
                          height: 40.h,
                          width: 40.h,
                          alignment: Alignment.center,
                          onTap: () {},
                        ),
                        SizedBox(width: 8.h),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "Hi, Ruthveralda Sakoikoi",
                                  style: theme.textTheme.titleSmall,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "IPDS",
                                  style: CustomTextStyles
                                      .labelMediumErrorContainer,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(right: 2.h),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                      color: appTheme.gray5001,
                      borderRadius: BorderRadiusStyle.roundedBorder14,
                      border: Border.all(
                        color: appTheme.gray30001,
                        width: 1.h,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Jadwal Anda Hari Ini",
                          style: CustomTextStyles.titleSmallPrimary,
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgArrowLeft,
                              height: 18.h,
                              width: 18.h,
                              alignment: Alignment.topCenter,
                              margin: EdgeInsets.only(top: 4.h),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 6.h),
                              child: Text(
                                "07:30",
                                style:
                                    CustomTextStyles.titleLargeErrorContainer,
                              ),
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgUser,
                              height: 24.h,
                              width: 24.h,
                              margin: EdgeInsets.only(left: 18.h),
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgArrowDown,
                              height: 18.h,
                              width: 20.h,
                              alignment: Alignment.topCenter,
                              margin: EdgeInsets.only(
                                left: 22.h,
                                top: 4.h,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 6.h),
                              child: Text(
                                "16:00",
                                style:
                                    CustomTextStyles.titleLargeErrorContainer,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
