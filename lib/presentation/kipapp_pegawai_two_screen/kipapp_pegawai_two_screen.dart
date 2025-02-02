import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';

class KipappPegawaiTwoScreen extends StatefulWidget {
  KipappPegawaiTwoScreen({Key? key}) : super(key: key);

  @override
  _KipappPegawaiTwoScreenState createState() => _KipappPegawaiTwoScreenState();
}

class _KipappPegawaiTwoScreenState extends State<KipappPegawaiTwoScreen> {
  List<String> availableYears = ["2024", "2025", "2026", "2027", "2028"];
  Map<String, bool> yearCompletionStatus =
      {}; // Menyimpan status penyelesaian tiap tahun
  Map<String, bool> yearSelection = {}; // Status checkbox tiap tahun
  Map<String, bool> yearDisabledStatus = {}; // Status disable tiap tahun
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchYearCompletionStatus();
  }

  bool get canSubmit {
    return yearSelection.entries
        .any((entry) => !yearDisabledStatus[entry.key]! && entry.value);
  }

  /// Fetch status penyelesaian tiap tahun dari Firestore
  Future<void> _fetchYearCompletionStatus() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic>? userData =
            userDoc.data() as Map<String, dynamic>?;
        if (userData != null && userData['kip_app'] != null) {
          Map<String, dynamic> kipAppData = userData['kip_app'];
          setState(() {
            for (String year in availableYears) {
              if (kipAppData[year] != null) {
                List<String> submittedMonths =
                    List<String>.from(kipAppData[year]['months'] ?? []);
                bool isYearCompleted = submittedMonths.length == 12;
                bool isYearFinalized = kipAppData[year]['value'] == true;

                yearCompletionStatus[year] = isYearCompleted;
                yearDisabledStatus[year] = isYearFinalized || !isYearCompleted;
                yearSelection[year] = isYearFinalized;
              } else {
                yearCompletionStatus[year] = false;
                yearDisabledStatus[year] =
                    true; // Disable jika data tahun tidak ada
                yearSelection[year] =
                    false; // Default semua tahun tidak tercentang
              }
            }
          });
        }
      }
    } catch (e) {
      debugPrint("Error fetching year completion status: $e");
    }
  }

  /// Submit data tahunan ke Firestore
  Future<void> _submitYear(String year) async {
    try {
      setState(() {
        isLoading = true;
      });

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final batch = FirebaseFirestore.instance.batch();

      // Reference for the user's document
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      // Fetch existing submission for the user
      final submissionQuery = await FirebaseFirestore.instance
          .collection('submissions')
          .where('user_id', isEqualTo: user.uid)
          .where('submission_type', isEqualTo: "KipAPP")
          .where('submission_data.kipapp_type', isEqualTo: "Tahunan")
          .get();

      if (submissionQuery.docs.isNotEmpty) {
        // Update existing submission document
        final submissionDoc = submissionQuery.docs.first;
        final currentYears =
            List<String>.from(submissionDoc['submission_data']['years'] ?? []);

        // Avoid duplicate year entries
        if (!currentYears.contains(year)) {
          currentYears.add(year);
        }

        // Update the submission document in the batch
        batch.update(submissionDoc.reference, {
          'submission_data.years': currentYears,
          'updated_at': FieldValue.serverTimestamp(),
        });
      } else {
        // Create a new submission document
        final newSubmissionDoc =
            FirebaseFirestore.instance.collection('submissions').doc();
        batch.set(newSubmissionDoc, {
          'submission_type': "KiP APP",
          'submission_data': {
            'kipapp_type': "Tahunan",
            'years': [year], // Start with the first year
          },
          'user_id': user.uid,
          'created_at': FieldValue.serverTimestamp(),
          'updated_at': FieldValue.serverTimestamp(),
        });
      }

      // Update the `users` collection for the selected year
      batch.set(
          userDocRef,
          {
            'kip_app': {
              year: {'value': true},
            },
          },
          SetOptions(merge: true));

      // Commit the batch write
      await batch.commit();

      Navigator.pushNamed(
          context,
          AppRoutes
              .submitBerhasilScreen); // Pindah ke layar submitBerhasilScreen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menyimpan data: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: Stack(
          children: [
            SizedBox(
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            AppRoutes.kipappPegawaiOneScreen);
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
                                              "Bulanan",
                                              style: CustomTextStyles
                                                  .titleMediumPrimary,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 18.h),
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
                                            "Tahunan",
                                            style: CustomTextStyles
                                                .titleMediumWhiteA700,
                                          ),
                                        ],
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
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  for (String year in availableYears)
                                    _buildYearCheckbox(context, year),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: CustomElevatedButton(
                                height: 32.h,
                                width: 76.h,
                                text: "Submit",
                                buttonStyle: canSubmit
                                    ? CustomButtonStyles.fillTeal
                                    : CustomButtonStyles.fillGray,
                                buttonTextStyle:
                                    CustomTextStyles.titleSmallWhiteA700,
                                onPressed: canSubmit
                                    ? () {
                                        for (String year
                                            in yearSelection.keys) {
                                          if (yearSelection[year] == true &&
                                              !yearDisabledStatus[year]!) {
                                            _submitYear(year);
                                          }
                                        }
                                      }
                                    : null,
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
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 43.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeftWhiteA700,
        height: 16.h,
        margin: EdgeInsets.only(left: 33.h),
        onTap: () {
          Navigator.pushNamed(context,
              AppRoutes.dashboardPegawaiScreen); // Navigasi ke dashboard
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "KipAPP",
      ),
      styleType: Style.bgFillTeal200,
    );
  }

  Widget _buildYearCheckbox(BuildContext context, String year) {
    bool isDisabled = yearDisabledStatus[year] ?? false;
    bool isSelected = yearSelection[year] ?? false;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Checkbox(
            value: isSelected,
            onChanged: isDisabled
                ? null
                : (value) {
                    setState(() {
                      yearSelection[year] = value ?? false;
                    });
                  },
            activeColor: Colors.blue[600],
            checkColor: Colors.white,
          ),
          const SizedBox(width: 8.0),
          Text(
            year,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
              color: isDisabled ? Colors.grey : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
