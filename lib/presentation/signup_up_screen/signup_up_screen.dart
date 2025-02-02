import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../services/auth_service.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';

class SignupUpScreen extends StatefulWidget {
  SignupUpScreen({Key? key}) : super(key: key);

  @override
  State<SignupUpScreen> createState() => _SignupUpScreenState();
}

class _SignupUpScreenState extends State<SignupUpScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isLoading = false; // State untuk efek loading

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: SizedBox(
                  height: SizeUtils.height,
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgGroup1,
                        height: 126.h,
                        width: double.maxFinite,
                      ),
                      SizedBox(height: 40.h),
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.symmetric(horizontal: 18.h),
                        padding: EdgeInsets.symmetric(horizontal: 14.h),
                        child: Column(
                          children: [
                            Text(
                              "WELCOME",
                              style: theme.textTheme.headlineLarge,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              "Login SSO BPS\nProvinsi Sulawesi Selatan",
                              style: CustomTextStyles.headlineSmallExtraBold,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10.h),
                            CustomImageView(
                              imagePath: ImageConstant.imgLogoBps,
                              height: 162.h,
                              width: double.maxFinite,
                              margin: EdgeInsets.symmetric(horizontal: 50.h),
                            ),
                            SizedBox(height: 30.h),
                            // Username Field
                            Padding(
                              padding: EdgeInsets.only(bottom: 14.h),
                              child: TextFormField(
                                controller: userNameController,
                                decoration: InputDecoration(
                                  hintText: "Username",
                                  hintStyle: CustomTextStyles.bodySmallGray500,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.h,
                                    vertical: 12.h,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.h),
                                  ),
                                ),
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            // Password Field
                            TextFormField(
                              controller: passwordController,
                              obscureText: !_isPasswordVisible,
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: CustomTextStyles
                                    .bodySmallGray500, // Sesuaikan dengan gaya teks
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.h,
                                  vertical: 12.h,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors
                                        .grey, // Warna ikon menjadi abu-abu
                                    size: 18.0, // Ukuran ikon lebih kecil
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      5.h), // Border untuk input field
                                ),
                              ),
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),

                            SizedBox(height: 26.h),
                            // Sign In Button
                            CustomElevatedButton(
                              height: 38.h,
                              width: 166.h,
                              text: "Sign In",
                              buttonStyle: CustomButtonStyles.fillPrimary,
                              buttonTextStyle:
                                  CustomTextStyles.titleMediumWhiteA700,
                              onPressed: () async {
                                setState(() => _isLoading = true);
                                await _authService.signIn(
                                  username: userNameController.text,
                                  password: passwordController.text,
                                  context: context,
                                );
                                setState(() => _isLoading = false);
                              },
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              "Forgot Password?",
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
            if (_isLoading)
              Container(
                color:
                    Colors.black.withOpacity(0.5), // Background semi-transparan
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
