import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_elevated_button.dart';

class KipappPegawaiOneScreen extends StatefulWidget {
  KipappPegawaiOneScreen({Key? key}) : super(key: key);
  @override
  _KipappPegawaiOneScreenState createState() => _KipappPegawaiOneScreenState();
}

class _KipappPegawaiOneScreenState extends State<KipappPegawaiOneScreen> {
  List<String> dropdownItemList = ["2024", "2025", "2026"];
  String selectedYear = "2024"; // Default year
  List<String> savedMonths = []; // Bulan yang sudah tersimpan di Firestore

  bool _isSubmitting = false; // Menandai status loading submit

  bool januarione = false;
  bool februarione = false;
  bool maretone = false;
  bool aprilone = false;
  bool meione = false;
  bool junione = false;
  bool julione = false;
  bool agustusone = false;
  bool septemberone = false;
  bool oktoberone = false;
  bool novemberone = false;
  bool desemberone = false;

  bool get isSubmitEnabled {
    // Check if at least one month is manually checked (not from Firestore)
    return (januarione && !savedMonths.contains("Januari")) ||
        (februarione && !savedMonths.contains("Februari")) ||
        (maretone && !savedMonths.contains("Maret")) ||
        (aprilone && !savedMonths.contains("April")) ||
        (meione && !savedMonths.contains("Mei")) ||
        (junione && !savedMonths.contains("Juni")) ||
        (julione && !savedMonths.contains("Juli")) ||
        (agustusone && !savedMonths.contains("Agustus")) ||
        (septemberone && !savedMonths.contains("September")) ||
        (oktoberone && !savedMonths.contains("Oktober")) ||
        (novemberone && !savedMonths.contains("November")) ||
        (desemberone && !savedMonths.contains("Desember"));
  }

  @override
  void initState() {
    super.initState();
    _fetchSavedMonths(); // Ambil data bulan yang tersimpan
  }

  /// Fungsi untuk mengambil data dari Firestore
  Future<void> _fetchSavedMonths() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      // Ambil data dari Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic>? userData =
            userDoc.data() as Map<String, dynamic>?;
        if (userData != null &&
            userData['kip_app'] != null &&
            userData['kip_app'][selectedYear] != null) {
          setState(() {
            // Perbarui `savedMonths` hanya untuk tahun yang dipilih
            savedMonths = List<String>.from(
                userData['kip_app'][selectedYear]['months'] ?? []);

            // Reset semua bulan
            januarione = savedMonths.contains("Januari");
            februarione = savedMonths.contains("Februari");
            maretone = savedMonths.contains("Maret");
            aprilone = savedMonths.contains("April");
            meione = savedMonths.contains("Mei");
            junione = savedMonths.contains("Juni");
            julione = savedMonths.contains("Juli");
            agustusone = savedMonths.contains("Agustus");
            septemberone = savedMonths.contains("September");
            oktoberone = savedMonths.contains("Oktober");
            novemberone = savedMonths.contains("November");
            desemberone = savedMonths.contains("Desember");
          });
        } else {
          // Jika tidak ada data untuk tahun tertentu, kosongkan `savedMonths`
          setState(() {
            savedMonths = [];
            // Reset semua bulan ke false
            januarione = februarione = maretone = aprilone = meione = junione =
                julione = agustusone = septemberone =
                    oktoberone = novemberone = desemberone = false;
          });
        }
      }
    } catch (e) {
      debugPrint("Error fetching saved months: $e");
    }
  }

  /// Fungsi untuk submit data ke Firestore
  Future<void> _submitToFirestore() async {
    try {
      setState(() {
        _isSubmitting = true; // Mulai proses submit
      });

      // Ambil daftar bulan yang dicentang
      List<String> selectedMonths = [];
      if (januarione && !savedMonths.contains("Januari"))
        selectedMonths.add("Januari");
      if (februarione && !savedMonths.contains("Februari"))
        selectedMonths.add("Februari");
      if (maretone && !savedMonths.contains("Maret"))
        selectedMonths.add("Maret");
      if (aprilone && !savedMonths.contains("April"))
        selectedMonths.add("April");
      if (meione && !savedMonths.contains("Mei")) selectedMonths.add("Mei");
      if (junione && !savedMonths.contains("Juni")) selectedMonths.add("Juni");
      if (julione && !savedMonths.contains("Juli")) selectedMonths.add("Juli");
      if (agustusone && !savedMonths.contains("Agustus"))
        selectedMonths.add("Agustus");
      if (septemberone && !savedMonths.contains("September"))
        selectedMonths.add("September");
      if (oktoberone && !savedMonths.contains("Oktober"))
        selectedMonths.add("Oktober");
      if (novemberone && !savedMonths.contains("November"))
        selectedMonths.add("November");
      if (desemberone && !savedMonths.contains("Desember"))
        selectedMonths.add("Desember");

      final user = FirebaseAuth.instance.currentUser;

      // Simpan data ke koleksi `submissions`
      await FirebaseFirestore.instance.collection('submissions').add({
        'submission_type': "KiP APP",
        'submission_data': {
          'kipapp_type': "Bulanan",
          'year': selectedYear,
          'months': selectedMonths,
        },
        'user_id': user?.uid,
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      });

      // Update atau buat dokumen di koleksi `users`
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(user?.uid);

      await userDocRef.set({
        'kip_app': {
          selectedYear: {
            'months': FieldValue.arrayUnion(
                selectedMonths), // Tambahkan bulan ke array
          },
        },
      }, SetOptions(merge: true));

      // Navigasi ke halaman submit berhasil
      Navigator.pushNamed(context, AppRoutes.submitBerhasilScreen);
    } catch (e) {
      // Tampilkan error jika gagal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menyimpan data: $e")),
      );
    } finally {
      setState(() {
        _isSubmitting = false; // Proses submit selesai
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            appBar: _buildAppbar(context),
            body: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(
                    left: 14.h,
                    top: 24.h,
                    right: 14.h,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 4.h),
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(left: 2.h),
                        padding: EdgeInsets.symmetric(horizontal: 16.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: double.maxFinite,
                              margin: EdgeInsets.only(
                                left: 2.h,
                                right: 6.h,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: double.maxFinite,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.primary,
                                        borderRadius:
                                            BorderRadiusStyle.roundedBorder10,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomImageView(
                                            imagePath: ImageConstant.imgGrid,
                                            height: 32.h,
                                            width: 36.h,
                                          ),
                                          Text(
                                            "Bulanan",
                                            style: CustomTextStyles
                                                .titleMediumWhiteA700,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 18.h),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            AppRoutes.kipappPegawaiTwoScreen);
                                      },
                                      child: Container(
                                        width: double.maxFinite,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.h),
                                        decoration: BoxDecoration(
                                          color: appTheme.blueGray50,
                                          borderRadius:
                                              BorderRadiusStyle.roundedBorder10,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomImageView(
                                              imagePath: ImageConstant.imgClose,
                                              height: 32.h,
                                              width: 36.h,
                                            ),
                                            Text(
                                              "Tahunan",
                                              style: CustomTextStyles
                                                  .titleMediumPrimary,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30.h),
                            Container(
                              width: double.maxFinite,
                              margin: EdgeInsets.only(right: 4.h),
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.h,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: appTheme.whiteA700,
                                borderRadius: BorderRadiusStyle.roundedBorder10,
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.colorScheme.errorContainer
                                        .withOpacity(0.05),
                                    spreadRadius: 2.h,
                                    blurRadius: 2.h,
                                    offset: Offset(
                                      0,
                                      0,
                                    ),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CustomDropDown(
                                    width: 94.h,
                                    hintText: "2024",
                                    hintStyle:
                                        CustomTextStyles.bodyMediumOnPrimary,
                                    items: dropdownItemList,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedYear =
                                            value; // Perbarui tahun yang dipilih
                                        _fetchSavedMonths(); // Ambil bulan berdasarkan tahun
                                      });
                                    },
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 8.h),
                                    borderDecoration:
                                        DropDownStyleHelper.fillIndigo,
                                    fillColor: appTheme.indigo50,
                                  ),
                                  SizedBox(height: 10.h),
                                  _buildJanuarione(context),
                                  SizedBox(height: 10.h),
                                  _buildFebruarione(context),
                                  SizedBox(height: 12.5.h),
                                  _buildMaretone(context),
                                  SizedBox(height: 10.h),
                                  _buildAprilone(context),
                                  SizedBox(height: 10.h),
                                  _buildMeione(context),
                                  SizedBox(height: 12.5.h),
                                  _buildJunione(context),
                                  SizedBox(height: 12.5.h),
                                  _buildJulione(context),
                                  SizedBox(height: 12.5.h),
                                  _buildAgustusone(context),
                                  SizedBox(height: 12.5.h),
                                  _buildSeptemberone(context),
                                  SizedBox(height: 12.5.h),
                                  _buildOktoberone(context),
                                  SizedBox(height: 12.5.h),
                                  _buildNovemberone(context),
                                  SizedBox(height: 12.5.h),
                                  _buildDesemberone(context),
                                  SizedBox(height: 12.5.h),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: CustomElevatedButton(
                                height: 32.h,
                                width: 76.h,
                                text: "Submit",
                                buttonStyle: isSubmitEnabled
                                    ? CustomButtonStyles.fillTeal
                                    : CustomButtonStyles.fillGray,
                                buttonTextStyle:
                                    CustomTextStyles.titleSmallWhiteA700,
                                onPressed:
                                    isSubmitEnabled ? _submitToFirestore : null,
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
          ),
          if (_isSubmitting)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 43.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeftWhiteA700,
        height: 16.h,
        margin: EdgeInsets.only(left: 33.h),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "KipAPP",
      ),
      styleType: Style.bgFillTeal200,
    );
  }

  /// Checkbox Builder
  Widget _buildMonthCheckbox({
    required BuildContext context,
    required String label,
    required bool value,
    required ValueChanged<bool?> onChanged,
    required bool isDisabled,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
            color: const Color.fromARGB(255, 0, 0, 0)), // Warna border
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged:
                isDisabled ? null : onChanged, // Disable jika sudah tersimpan
            activeColor: Colors.blue[600],
            checkColor: Colors.white,
          ),
          const SizedBox(width: 8.0), // Jarak antara checkbox dan teks
          Text(
            label,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
              color: isDisabled
                  ? Colors.grey
                  : Colors.black, // Teks abu-abu jika disabled
            ),
          ),
        ],
      ),
    );
  }

  /// Checkbox untuk setiap bulan
  Widget _buildJanuarione(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "Januari",
      value: savedMonths.contains("Januari") || januarione,
      onChanged: (value) {
        setState(() {
          januarione = value ?? false;
        });
      },
      isDisabled: savedMonths.contains("Januari"),
    );
  }

  Widget _buildFebruarione(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "Februari",
      value: savedMonths.contains("Februari") || februarione,
      onChanged: (value) {
        setState(() {
          februarione = value ?? false;
        });
      },
      isDisabled: savedMonths.contains("Februari"),
    );
  }

  Widget _buildMaretone(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "Maret",
      value: savedMonths.contains("Maret") || maretone,
      onChanged: (value) {
        setState(() {
          maretone = value ?? false;
        });
      },
      isDisabled: savedMonths.contains("Maret"),
    );
  }

  Widget _buildAprilone(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "April",
      value: savedMonths.contains("April") || aprilone,
      onChanged: (value) {
        setState(() {
          aprilone = value ?? false;
        });
      },
      isDisabled: savedMonths.contains("April"),
    );
  }

  Widget _buildMeione(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "Mei",
      value: savedMonths.contains("Mei") || meione,
      onChanged: (value) {
        setState(() {
          meione = value ?? false;
        });
      },
      isDisabled: savedMonths.contains("Mei"),
    );
  }

  Widget _buildJunione(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "Juni",
      value: savedMonths.contains("Juni") || junione,
      onChanged: (value) {
        setState(() {
          junione = value ?? false;
        });
      },
      isDisabled: savedMonths.contains("Juni"),
    );
  }

  Widget _buildJulione(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "Juli",
      value: savedMonths.contains("Juli") || julione,
      onChanged: (value) {
        setState(() {
          julione = value ?? false;
        });
      },
      isDisabled: savedMonths.contains("Juli"),
    );
  }

  Widget _buildAgustusone(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "Agustus",
      value: savedMonths.contains("Agustus") || agustusone,
      onChanged: (value) {
        setState(() {
          agustusone = value ?? false;
        });
      },
      isDisabled: savedMonths.contains("Agustus"),
    );
  }

  Widget _buildSeptemberone(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "September",
      value: savedMonths.contains("September") || septemberone,
      onChanged: (value) {
        setState(() {
          septemberone = value ?? false;
        });
      },
      isDisabled: savedMonths.contains("September"),
    );
  }

  Widget _buildOktoberone(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "Oktober",
      value: savedMonths.contains("Oktober") || oktoberone,
      onChanged: (value) {
        setState(() {
          oktoberone = value ?? false;
        });
      },
      isDisabled: savedMonths.contains("Oktober"),
    );
  }

  Widget _buildNovemberone(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "November",
      value: savedMonths.contains("November") || novemberone,
      onChanged: (value) {
        setState(() {
          novemberone = value ?? false;
        });
      },
      isDisabled: savedMonths.contains("November"),
    );
  }

  Widget _buildDesemberone(BuildContext context) {
    return _buildMonthCheckbox(
      context: context,
      label: "Desember",
      value: savedMonths.contains("Desember") || desemberone,
      onChanged: (value) {
        setState(() {
          desemberone = value ?? false;
        });
      },
      isDisabled: savedMonths.contains("Desember"),
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pushNamed(
        context, AppRoutes.dashboardPegawaiScreen); // Navigasi ke dashboard
  }

  /// Navigates to the kipappPegawaiTwoScreen when the action is triggered.
  onTapColumncloseone(BuildContext context) {
    Navigator.pushNamed(
        context,
        AppRoutes
            .kipappPegawaiTwoScreen); // Pindah ke layar kipappPegawaiTwoScreen
  }

  /// Navigates to the submitBerhasilScreen when the action is triggered.
  onTapSubmit(BuildContext context) {
    Navigator.pushNamed(context,
        AppRoutes.submitBerhasilScreen); // Pindah ke layar submitBerhasilScreen
  }
}
