import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

// ignore_for_file: must_be_immutable
class ProfileInfoPimpinanScreen extends StatefulWidget {
  ProfileInfoPimpinanScreen({Key? key}) : super(key: key);

  @override
  State<ProfileInfoPimpinanScreen> createState() =>
      _ProfileInfoPimpinanScreenState();
}

class _ProfileInfoPimpinanScreenState extends State<ProfileInfoPimpinanScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController nipController = TextEditingController();
  TextEditingController jabatanController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? _profileImage;

  /// Fungsi untuk memilih gambar dari galeri
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

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
                      /// Foto Profil dengan Tombol Edit
                      Align(
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            ClipOval(
                              child: _profileImage != null
                                  ? Image.file(
                                      _profileImage!,
                                      height: 120.h,
                                      width: 120.h,
                                      fit: BoxFit.cover,
                                    )
                                  : CustomImageView(
                                      imagePath: ImageConstant
                                          .imgAvatars3dAvatar21120x120,
                                      height: 120.h,
                                      width: 120.h,
                                    ),
                            ),
                            GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 18.h),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "PIMPINAN",
                          style: CustomTextStyles.titleLargeErrorContainer,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "PIMPINAN",
                          style: CustomTextStyles.labelMediumErrorContainer,
                        ),
                      ),
                      SizedBox(height: 20.h),

                      /// E-mail
                      Text(
                        "E-mail",
                        style: CustomTextStyles.labelMediumBluegray200,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "pimpinanipds@gmail.com",
                        style: CustomTextStyles.labelLargeErrorContainerBold,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 2.h),
                      Divider(color: appTheme.blueGray100),
                      SizedBox(height: 20.h),

                      /// Username
                      Text(
                        "Username",
                        style: CustomTextStyles.labelMediumBluegray200,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "pimpinan",
                        style: CustomTextStyles.labelLargeErrorContainerBold,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 2.h),
                      Divider(color: appTheme.blueGray100),
                      SizedBox(height: 20.h),

                      /// NIP
                      Text(
                        "NIP BPS",
                        style: CustomTextStyles.labelMediumBluegray200,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "20241234567891",
                        style: CustomTextStyles.labelLargeErrorContainerBold,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 2.h),
                      Divider(color: appTheme.blueGray100),
                      SizedBox(height: 20.h),

                      /// Jabatan
                      Text(
                        "Jabatan",
                        style: CustomTextStyles.labelMediumBluegray200,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Pimpinan Utama",
                        style: CustomTextStyles.labelLargeErrorContainerBold,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 2.h),
                      Divider(color: appTheme.blueGray100),
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

  /// AppBar untuk halaman profil
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

  /// Navigasi kembali ke halaman sebelumnya
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
