import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_text_form_field.dart';
import '../dashboard_pimpinan_screen/dashboard_pimpinan_screen.dart';


// ignore_for_file: must_be_immutable

class ProfileInfoPimpinanScreen extends StatelessWidget {
  ProfileInfoPimpinanScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController group1150oneController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
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
                          "Pimpinan",
                          style: CustomTextStyles.titleLargeErrorContainer,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Badan Pusat Statistik",
                          style: CustomTextStyles.labelMediumErrorContainer,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      Text(
                        "E-mail",
                        style: CustomTextStyles.labelMediumBluegray200,
                      ),
                      SizedBox(height: 4.h),
                      _buildEmail(context),
                      SizedBox(height: 20.h),
                      Text(
                        "Username",
                        style: CustomTextStyles.labelMediumBluegray200,
                      ),
                      SizedBox(height: 4.h),
                      _buildUserName(context),
                      SizedBox(height: 20.h),
                      Text(
                        "NIP",
                        style: CustomTextStyles.labelMediumBluegray200,
                      ),
                      SizedBox(height: 2.h),
                      _buildGroup1150one(context),
                      SizedBox(height: 20.h),
                      Text(
                        "Phone Number",
                        style: CustomTextStyles.labelMediumBluegray200,
                      ),
                      SizedBox(height: 2.h),
                      _buildPhoneNumber(context),
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardPimpinanScreen(),
            ),
          );
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Profile Info",
      ),
      styleType: Style.bgFillTeal200,
    );
  }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
    return CustomTextFormField(
      controller: emailController,
      hintText: "pimpinan@email.com",
      hintStyle: CustomTextStyles.labelLargeErrorContainerBold,
      textInputType: TextInputType.emailAddress,
      contentPadding: EdgeInsets.fromLTRB(12.h, 12.h, 12.h, 4.h),
      borderDecoration: TextFormFieldStyleHelper.underLineBlueGray,
    );
  }

  /// Section Widget
  Widget _buildUserName(BuildContext context) {
    return CustomTextFormField(
      controller: userNameController,
      hintText: "Pimpinan",
      hintStyle: CustomTextStyles.labelLargeErrorContainerBold,
      contentPadding: EdgeInsets.fromLTRB(12.h, 12.h, 12.h, 4.h),
      borderDecoration: TextFormFieldStyleHelper.underLineBlueGray,
    );
  }

  /// Section Widget
  Widget _buildGroup1150one(BuildContext context) {
    return CustomTextFormField(
      controller: group1150oneController,
      hintText: "202111111111111111111111111",
      hintStyle: CustomTextStyles.labelLargeErrorContainerBold,
      contentPadding: EdgeInsets.fromLTRB(12.h, 12.h, 12.h, 4.h),
      borderDecoration: TextFormFieldStyleHelper.underLineBlueGray,
    );
  }

  /// Section Widget
  Widget _buildPhoneNumber(BuildContext context) {
    return CustomTextFormField(
      controller: phoneNumberController,
      hintText: "08xxxxxxxxxx",
      hintStyle: CustomTextStyles.labelLargeErrorContainerBold,
      textInputAction: TextInputAction.done,
      contentPadding: EdgeInsets.fromLTRB(12.h, 12.h, 12.h, 4.h),
      borderDecoration: TextFormFieldStyleHelper.underLineBlueGray,
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
