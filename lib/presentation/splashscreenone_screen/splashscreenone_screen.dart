import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_icon_button.dart';

class SplashscreenoneScreen extends StatefulWidget {
  const SplashscreenoneScreen({Key? key}) : super(key: key);

  @override
  State<SplashscreenoneScreen> createState() => _SplashscreenoneScreenState();
}

class _SplashscreenoneScreenState extends State<SplashscreenoneScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkUserLogin();
  }

  /// Check if the user is logged in and navigate to the appropriate dashboard
  Future<void> _checkUserLogin() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          final userData = userDoc.data() as Map<String, dynamic>;
          final roleId = userData['role_id'];

          // Navigate to the appropriate dashboard based on role_id
          if (roleId == 1) {
            // Navigator.pushReplacementNamed(context, AppRoutes.dashboardRootScreen);
          } else if (roleId == 2) {
            // Navigator.pushReplacementNamed(context, AppRoutes.dashboardAdminScreen);
          } else if (roleId == 3) {
            Navigator.pushReplacementNamed(
                context, AppRoutes.dashboardPegawaiScreen);
          } else if (roleId == 4) {
            Navigator.pushReplacementNamed(
                context, AppRoutes.dashboardKetuaTimScreen);
          } else if (roleId == 5) {
            Navigator.pushReplacementNamed(
                context, AppRoutes.dashboardPimpinanScreen);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Role tidak dikenal, hubungi admin.')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Data pengguna tidak ditemukan, hubungi admin.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Terjadi kesalahan saat memuat data pengguna: $e')),
        );
      }
    } else {
      // No logged-in user
      setState(() {
        _isLoading = false; // Stop loading and show splash screen UI
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // Show loading indicator while checking user login
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Show splash screen UI after loading
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 14.h,
            vertical: 60.h,
          ),
          child: Column(
            children: [
              Spacer(),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: 2.h),
                padding: EdgeInsets.symmetric(horizontal: 18.h),
                child: Column(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgLogoBps,
                      height: 180.h,
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(horizontal: 36.h),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "BADAN PUSAT STATISTIK\nSULAWESI SELATAN",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.headlineSmall_1.copyWith(
                        height: 1.20,
                      ),
                    ),
                    SizedBox(height: 174.h),
                    SizedBox(
                      height: 8.h,
                      child: AnimatedSmoothIndicator(
                        activeIndex: 0,
                        count: 3,
                        effect: ScrollingDotsEffect(
                          spacing: 9,
                          activeDotColor: appTheme.gray800,
                          dotColor: appTheme.gray800.withOpacity(0.6),
                          dotHeight: 8.h,
                          dotWidth: 8.h,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    CustomIconButton(
                      height: 42.h,
                      width: 42.h,
                      padding: EdgeInsets.all(10.h),
                      decoration: IconButtonStyleHelper.outlineErrorContainer,
                      onTap: () => onTapBtnArrowforward(context),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgArrowForwardIos,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Manual navigation to the next screen (if no user is logged in)
  onTapBtnArrowforward(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.splashscreentwoScreen);
  }
}
