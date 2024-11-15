import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class SignupUpScreen extends StatelessWidget {
  SignupUpScreen({Key? key}) : super(key: key);

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: SizedBox(
                height: SizeUtils.height,
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgGroup1,
                      height: 126.h,
                      width: double.maxFinite,
                    ),
                    SizedBox(height: 40.h),
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(
                        left: 18.h,
                        right: 14.h,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 14.h),
                      child: Column(
                        children: [
                          Text(
                            "Welcome ",
                            style: theme.textTheme.headlineLarge,
                          ),
                          Text(
                            "Login SSO",
                            style: CustomTextStyles.headlineSmallExtraBold,
                          ),
                          SizedBox(height: 32.h),
                          CustomImageView(
                            imagePath: ImageConstant.imgLogoBps,
                            height: 162.h,
                            width: double.maxFinite,
                            margin: EdgeInsets.only(
                              left: 50.h,
                              right: 54.h,
                            ),
                          ),
                          SizedBox(height: 30.h),
                          Padding(
                            padding: EdgeInsets.only(right: 4.h),
                            child: CustomTextFormField(
                              controller: userNameController,
                              hintText: "Username",
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.h,
                                vertical: 12.h,
                              ),
                              borderDecoration:
                                  TextFormFieldStyleHelper.outlinePrimary,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Padding(
                            padding: EdgeInsets.only(right: 4.h),
                            child: CustomTextFormField(
                              controller: passwordController,
                              hintText: "Password",
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.visiblePassword,
                              obscureText: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.h,
                                vertical: 12.h,
                              ),
                              borderDecoration:
                                  TextFormFieldStyleHelper.outlinePrimary,
                            ),
                          ),
                          SizedBox(height: 26.h),
                          CustomElevatedButton(
                            height: 38.h,
                            width: 166.h,
                            text: "Sign In",
                            buttonStyle: CustomButtonStyles.fillPrimary,
                            buttonTextStyle:
                                CustomTextStyles.titleMediumWhiteA700,
                            onPressed: () {},
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            "Forgot  Password?",
                            style: CustomTextStyles.bodySmallPoppinsTeal200
                                .copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Text(
                            "Contact Tim IPDS",
                            style: CustomTextStyles.bodySmallPoppins,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Navigates to the dashboardPegawaiScreen when the action is triggered.
  onTapSignin(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.dashboardPegawaiScreen);
  }
}
