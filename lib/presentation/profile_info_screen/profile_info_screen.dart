import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class ProfileInfoScreen extends StatefulWidget {
  ProfileInfoScreen({Key? key}) : super(key: key);

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  File? _profileImage;

  /// Variabel untuk menyimpan data pengguna
  String? _name;
  String? _email;
  String? _username;
  String? _nip;
  String? _division;
  String? _position;

  bool _isLoading = true;

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

  /// Fungsi untuk mengambil nama divisi berdasarkan team_id
  Future<String> _fetchDivisionName(int teamId) async {
    try {
      final teamDoc = await FirebaseFirestore.instance
          .collection('teams')
          .doc(teamId.toString())
          .get();
      if (teamDoc.exists && teamDoc.data() != null) {
        return teamDoc.data()!['name'] ?? "Divisi tidak tersedia";
      }
    } catch (e) {
      debugPrint("Error fetching division name: $e");
    }
    return "Divisi tidak tersedia";
  }

  /// Fungsi untuk mengambil nama posisi berdasarkan position_id
  Future<String> _fetchPositionName(int positionId) async {
    try {
      final positionDoc = await FirebaseFirestore.instance
          .collection('positions')
          .doc(positionId.toString())
          .get();
      if (positionDoc.exists && positionDoc.data() != null) {
        return positionDoc.data()!['name'] ?? "Posisi tidak tersedia";
      }
    } catch (e) {
      debugPrint("Error fetching position name: $e");
    }
    return "Posisi tidak tersedia";
  }

  /// Fungsi untuk mengambil data pengguna dari Firestore
  Future<void> _fetchUserData() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) return;

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (userDoc.exists) {
        final data = userDoc.data();
        if (data != null) {
          int? teamId = data['team_id'];
          int? positionId = data['position_id'];

          // Ambil nama divisi dan posisi berdasarkan ID
          String divisionName = teamId != null
              ? await _fetchDivisionName(teamId)
              : "Divisi tidak tersedia";
          String positionName = positionId != null
              ? await _fetchPositionName(positionId)
              : "Posisi tidak tersedia";

          setState(() {
            _name = data['name'] ?? "Nama tidak tersedia";
            _email = data['email'] ?? "Email tidak tersedia";
            _username = data['username'] ?? "Username tidak tersedia";
            _nip = data['nip_bps'] ?? "NIP tidak tersedia";
            _division = divisionName;
            _position = positionName;
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error fetching user data: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Fungsi untuk logout
  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();

      // Navigasi ke halaman login dan hapus semua rute sebelumnya
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.signupUpScreen, // Rute halaman login Anda
        (route) => false, // Hapus semua rute sebelumnya
      );
    } catch (e) {
      // Tangani error jika logout gagal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout gagal: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppbar(context),
        body: _isLoading
            ? Center(child: CircularProgressIndicator()) // Loading indicator
            : _buildBody(context),
      ),
    );
  }

  /// Body utama
  Widget _buildBody(BuildContext context) {
    return Form(
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 40.h),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            /// Bagian informasi profil
            Expanded(
              child: Container(
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
                        _name ?? "Nama Tidak Tersedia",
                        style: CustomTextStyles.titleLargeErrorContainer,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        _division ?? "Divisi Tidak Tersedia",
                        style: CustomTextStyles.labelMediumErrorContainer,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    /// E-mail
                    _buildField("E-mail", _email ?? ""),

                    /// Username
                    _buildField("Username", _username ?? ""),

                    /// NIP
                    _buildField("NIP", _nip ?? ""),

                    /// Jabatan
                    _buildField("Jabatan", _position ?? ""),
                  ],
                ),
              ),
            ),

            /// Tombol Logout
            CustomElevatedButton(
              text: "Logout",
              onPressed: _logout,
              margin: EdgeInsets.symmetric(vertical: 20.h),
              buttonStyle: CustomButtonStyles.fillErrorContainer,
              buttonTextStyle: CustomTextStyles.titleSmallPrimary,
            ),
          ],
        ),
      ),
    );
  }

  /// Widget untuk menampilkan field informasi
  Widget _buildField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: CustomTextStyles.labelMediumBluegray200,
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: CustomTextStyles.labelLargeErrorContainerBold,
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 2.h),
        Divider(color: appTheme.blueGray100),
        SizedBox(height: 20.h),
      ],
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
}
