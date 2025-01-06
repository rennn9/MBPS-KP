import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable

class ProfileInfoScreen extends StatelessWidget {
  ProfileInfoScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController group1155oneController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppbar(context),
        body: Form(
          key: _formKey,
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(
              left: 14.h,
              top: 40.h,
              right: 14.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(left: 2.h),
                  padding: EdgeInsets.symmetric(horizontal: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgAvatars3dAvatar21120x120,
                        height: 120.h,
                        width: 122.h,
                        alignment: Alignment.center,
                      ),
                      SizedBox(height: 18.h),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Ruthveralda Sakoikoi",
                          style: CustomTextStyles.titleLargeErrorContainer,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "IPDS",
                          style: CustomTextStyles.labelMediumErrorContainer,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "E-mail",
                        style: CustomTextStyles.labelMediumBluegray200,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "ruth@gmail.com",
                        style: CustomTextStyles.labelLargeErrorContainerBold,
                      ),
                      SizedBox(height: 2.h),
                      SizedBox(
                        width: double.maxFinite,
                        child: Divider(
                          color: appTheme.blueGray100,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "Username",
                        style: CustomTextStyles.labelMediumBluegray200,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Ruth",
                        style: CustomTextStyles.labelLargeErrorContainerBold,
                      ),
                      SizedBox(height: 2.h),
                      SizedBox(
                        width: double.maxFinite,
                        child: Divider(
                          color: appTheme.blueGray100,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "NIP",
                        style: CustomTextStyles.labelMediumBluegray200,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "20241234567890",
                        style: CustomTextStyles.labelLargeErrorContainerBold,
                      ),
                      SizedBox(height: 2.h),
                      SizedBox(
                        width: double.maxFinite,
                        child: Divider(
                          color: appTheme.blueGray100,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "Jabatan",
                        style: CustomTextStyles.labelMediumBluegray200,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Ahli Madya",
                        style: CustomTextStyles.labelLargeErrorContainerBold,
                      ),
                      SizedBox(height: 2.h),
                      SizedBox(
                        width: double.maxFinite,
                        child: Divider(
                          color: appTheme.blueGray100,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 43.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeftWhiteA700,
        margin: EdgeInsets.only(left: 33.h),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Profile Info",
      ),
      styleType: Style.bgFillTeal200,
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
