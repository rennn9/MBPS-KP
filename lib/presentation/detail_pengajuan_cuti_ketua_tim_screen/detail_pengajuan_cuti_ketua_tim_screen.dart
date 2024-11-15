import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class DetailPengajuanCutiKetuaTimScreen extends StatelessWidget {
  DetailPengajuanCutiKetuaTimScreen({Key? key}) : super(key: key);

  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              height: 734.h,
              width: double.maxFinite,
              padding: EdgeInsets.only(
                left: 28.h,
                top: 18.h,
                right: 28.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 592.h,
                    width: double.maxFinite,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.only(
                            left: 8.h,
                            top: 24.h,
                            right: 8.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusStyle.roundedBorder14,
                            border: Border.all(
                              color: appTheme.blueGray100,
                              width: 1.h,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 40.h),
                              Text(
                                "Rendi Wijaya",
                                style: theme.textTheme.titleMedium,
                              ),
                              Text(
                                "IPDS",
                                style:
                                    CustomTextStyles.titleSmallErrorContainer,
                              ),
                              SizedBox(height: 18.h),
                              SizedBox(
                                width: double.maxFinite,
                                child: Divider(
                                  color: theme.colorScheme.errorContainer
                                      .withOpacity(0.3),
                                  indent: 18.h,
                                  endIndent: 14.h,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 4.h),
                                  child: Text(
                                    "Info Pengajuan",
                                    style: CustomTextStyles.titleSmallMedium,
                                  ),
                                ),
                              ),
                              SizedBox(height: 14.h),
                              Container(
                                width: double.maxFinite,
                                margin: EdgeInsets.symmetric(horizontal: 4.h),
                                child: _buildRowtanggal(
                                  context,
                                  tanggalOne: "Tipe",
                                  p10oktober2024: "1 Hari",
                                ),
                              ),
                              SizedBox(height: 4.h),
                              SizedBox(
                                width: double.maxFinite,
                                child: Divider(
                                  indent: 4.h,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                width: double.maxFinite,
                                margin: EdgeInsets.symmetric(horizontal: 4.h),
                                child: _buildRowtanggal(
                                  context,
                                  tanggalOne: "Tanggal Pengajuan",
                                  p10oktober2024: "10 Oktober 2024",
                                ),
                              ),
                              SizedBox(height: 4.h),
                              SizedBox(
                                width: double.maxFinite,
                                child: Divider(
                                  indent: 4.h,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Container(
                                width: double.maxFinite,
                                margin: EdgeInsets.symmetric(horizontal: 4.h),
                                child: _buildRowtanggal(
                                  context,
                                  tanggalOne: "Tanggal Cuti",
                                  p10oktober2024: "15 Oktober 2024",
                                ),
                              ),
                              SizedBox(height: 4.h),
                              SizedBox(
                                width: double.maxFinite,
                                child: Divider(
                                  indent: 4.h,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 4.h),
                                  child: Text(
                                    "Alasan Cuti",
                                    style: theme.textTheme.labelLarge,
                                  ),
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Padding(
                                padding: EdgeInsets.only(left: 4.h),
                                child: CustomTextFormField(
                                  controller: descriptionController,
                                  hintText:
                                      "Lorem ipsum dolor sit amet consectetur. Arcu quisque pretium feugiat sapien egestas consectetur. A maecenas purus at odio a lorem. Fermentum vel auctor suspendisse id volutpat viverra aliquam enim. Vitae quis mattis eu ultricies vulputate ipsum eu.",
                                  textInputAction: TextInputAction.done,
                                  maxLines: 6,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(12.h, 8.h, 12.h, 4.h),
                                ),
                              ),
                              SizedBox(height: 84.h),
                              Container(
                                width: double.maxFinite,
                                margin: EdgeInsets.symmetric(horizontal: 16.h),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomElevatedButton(
                                        text: "Tolak",
                                      ),
                                    ),
                                    SizedBox(width: 16.h),
                                    Expanded(
                                      child: CustomElevatedButton(
                                        text: "Terima",
                                        buttonStyle:
                                            CustomButtonStyles.fillGreenA,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.imgProfilePicture,
                          height: 98.h,
                          width: 106.h,
                          alignment: Alignment.topCenter,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
/// Section Widget
PreferredSizeWidget _buildAppbar(BuildContext context) {
  return CustomAppBar(
    leadingWidth: 40.h,
    leading: AppbarLeadingImage(
      imagePath: ImageConstant.imgArrowLeftWhiteA700,
      margin: EdgeInsets.only(left: 30.h),
      onTap: () {},
    ),
    centerTitle: true,
    title: AppbarTitle(
      text: "Pengajuan Cuti",
    ),
    styleType: Style.bgFillTeal200,
  );
}

/// Common widget
Widget _buildRowtanggal(
  BuildContext context, {
  required String tanggalOne,
  required String p10oktober2024,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: Text(
            tanggalOne,
            style: theme.textTheme.labelLarge!.copyWith(
              color: theme.colorScheme.errorContainer.withOpacity(0.4),
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(right: 24.h),
        child: Text(
          p10oktober2024,
          style: CustomTextStyles.labelLargeErrorContainer.copyWith(
            color: theme.colorScheme.errorContainer.withOpacity(1),
          ),
        ),
      )
    ],
  );
}

/// Navigates back to the previous screen.
onTapArrowleftone(BuildContext context) {
  Navigator.pop(context);
}
}
