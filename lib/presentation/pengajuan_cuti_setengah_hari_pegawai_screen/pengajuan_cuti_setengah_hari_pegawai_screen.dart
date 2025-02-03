import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_radio_button.dart';
import '../../widgets/custom_text_form_field.dart';

import '../pengajuan_cuti_pegawai_screen/pengajuan_cuti_pegawai_screen.dart';
import '../dashboard_pegawai_screen/dashboard_pegawai_screen.dart';

class PengajuanCutiSetengahHariPegawaiScreen extends StatefulWidget {
  const PengajuanCutiSetengahHariPegawaiScreen({Key? key}) : super(key: key);

  @override
  _PengajuanCutiSetengahHariPegawaiScreenState createState() =>
      _PengajuanCutiSetengahHariPegawaiScreenState();
}

class _PengajuanCutiSetengahHariPegawaiScreenState
    extends State<PengajuanCutiSetengahHariPegawaiScreen> {
  // Daftar jenis cuti
  List<String> dropdownItemList = [
    "Tahunan",
    "Besar",
    "Sakit",
    "Melahirkan",
    "Alasan Penting",
    "Cuti Luar Tanggungan",
    "Perpanjangan CLTN",
    "Cuti Setengah Hari"
  ];

  // Default ke "Cuti Setengah Hari"
  String selectedOption = "Cuti Setengah Hari";

  // Controller untuk alasan dan tanggal
  TextEditingController berikanController = TextEditingController(); // reason
  TextEditingController tanggalController =
      TextEditingController(); // date (string)

  DateTime? selectedTanggal;
  String radioGroup =
      ""; // "Sesi pagi: 07.30-12.00" / "Sesi siang: 13.00-16.00"

  // Variabel untuk status loading
  bool _isSubmitting = false;

  bool isFormValid() {
    return selectedOption.isNotEmpty &&
        berikanController.text.isNotEmpty &&
        radioGroup.isNotEmpty &&
        selectedTanggal != null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedTanggal ?? DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      if (!_isWithinThreeWorkdays(picked)) {
        // Jika tanggal melebihi 3 hari kerja dari hari ini, tampilkan error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Tanggal cuti harus dalam 3 hari kerja dari hari ini.'),
          ),
        );
        return; // Tidak melanjutkan penyimpanan tanggal
      }

      setState(() {
        selectedTanggal = picked;
        tanggalController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  // Fungsi untuk validasi pengajuan cuti 3 hari kerja
  bool _isWithinThreeWorkdays(DateTime startDate) {
    final DateTime lastAllowedDate = _addWorkingDays(startDate, 3);
    final DateTime today = DateTime.now();

    return !today.isAfter(lastAllowedDate);
  }

  DateTime _addWorkingDays(DateTime start, int daysToAdd) {
    int added = 0;
    DateTime current = start;

    while (added < daysToAdd) {
      current = current.add(const Duration(days: 1));

      if (current.weekday != DateTime.saturday &&
          current.weekday != DateTime.sunday) {
        added++;
      }
    }

    return current;
  }

  // Fungsi untuk menyesuaikan radioGroup ("Sesi pagi: 07.30-12.00") -> "pagi" / "siang"
  String _parseSession(String radioValue) {
    if (radioValue.contains("pagi")) {
      return "pagi";
    } else if (radioValue.contains("siang")) {
      return "siang";
    }
    return ""; // default jika tidak match
  }

  // Fungsi submit ke Firestore
  // Fungsi submit ke Firestore
  Future<void> _submitToFirestore() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User belum login!")),
        );
        return;
      }

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final userData = userDoc.data();
      final role_id = userData?['role_id'];
      String status = '';

      if (role_id == 4) {
        status = 'TEAM_APPROVED';
      } else {
        status = 'PROCESSING';
      }

      setState(() {
        _isSubmitting = true; // Mulai loading
      });

      final sessionValue = _parseSession(radioGroup); // "pagi" / "siang"
      final timestampDate = selectedTanggal; // DateTime?

      await FirebaseFirestore.instance.collection('submissions').add({
        'status': status,
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
        'user_id': user.uid,
        'submission_type': 'Pengajuan Cuti',
        'submission_data': {
          'leave_type': selectedOption,
          'date': timestampDate,
          'leave_session': sessionValue,
          'reason': berikanController.text.trim(),
        }
      });

      // Navigasi ke halaman submit berhasil
      Navigator.pushNamed(context, AppRoutes.submitBerhasilScreen);
    } catch (e) {
      debugPrint("Error submitting data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal submit data: $e")),
      );
    } finally {
      setState(() {
        _isSubmitting = false; // Selesai loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppbar(context),
            body: Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(
                left: 14.h,
                top: 20.h,
                right: 14.h,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(left: 2.h),
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDropdown(context),
                          SizedBox(height: 14.h),
                          _buildDateSelection(context),
                          SizedBox(height: 14.h),
                          _buildColumnmdtwo(context),
                          SizedBox(height: 14.h),
                          Padding(
                            padding: EdgeInsets.only(left: 4.h),
                            child: Text(
                              "Sesi Cuti",
                              style: CustomTextStyles.titleLargeErrorContainer,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          _buildGroup1134(context),
                          const Spacer(),
                          CustomElevatedButton(
                            height: 32.h,
                            width: 76.h,
                            text: "Submit",
                            margin: EdgeInsets.only(bottom: 20.h),
                            buttonStyle: isFormValid()
                                ? CustomButtonStyles.fillTeal
                                : CustomButtonStyles.fillGray,
                            buttonTextStyle: isFormValid()
                                ? CustomTextStyles.titleSmallWhiteA700
                                : CustomTextStyles.bodyMediumErrorContainer_1,
                            onPressed: isFormValid() && !_isSubmitting
                                ? () => _submitToFirestore()
                                : null,
                            alignment: Alignment.centerRight,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h)
                ],
              ),
            ),
          ),
          // Overlay untuk loading
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

  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 43.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeftWhiteA700,
        margin: EdgeInsets.only(left: 33.h),
        onTap: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const DashboardPegawaiScreen(),
            ),
            (route) => false,
          );
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Cuti",
      ),
      styleType: Style.bgFillTeal200,
    );
  }

  Widget _buildDropdown(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Jenis Cuti",
            style: CustomTextStyles.titleLargeErrorContainer,
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
              borderRadius: BorderRadius.circular(8.h),
              border: Border.all(color: appTheme.gray400, width: 1),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.h),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedOption,
                items: dropdownItemList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedOption = value!;
                    // Jika user pilih jenis lain (bukan "Cuti Setengah Hari"),
                    // pindah ke screen pengajuan_cuti_pegawai_screen.
                    if (value != "Cuti Setengah Hari") {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const PengajuanCutiPegawaiScreen(),
                        ),
                        (route) => false,
                      );
                    }
                  });
                },
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tanggal",
            style: CustomTextStyles.titleLargeErrorContainer,
          ),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: CustomTextFormField(
                controller: tanggalController,
                hintText: "Pilih Tanggal",
                hintStyle: CustomTextStyles.bodyMediumErrorContainer_1,
                contentPadding: EdgeInsets.fromLTRB(14.h, 12.h, 10.h, 12.h),
                borderDecoration:
                    TextFormFieldStyleHelper.outlineErrorContainerTL4,
                filled: true,
                fillColor: appTheme.whiteA700,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildColumnmdtwo(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Alasan",
            style: CustomTextStyles.titleLargeErrorContainer,
          ),
          SizedBox(height: 12.h),
          CustomTextFormField(
            controller: berikanController,
            hintText: "Masukkan Alasan",
            hintStyle: CustomTextStyles.bodyMediumErrorContainer_1,
            contentPadding: EdgeInsets.all(14.h),
            borderDecoration:
                TextFormFieldStyleHelper.outlineErrorContainerTL41,
          ),
        ],
      ),
    );
  }

  Widget _buildGroup1134(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.h),
      child: Column(
        children: [
          // Sesi pagi
          CustomRadioButton(
            text: "Sesi pagi\n07.30-12.00",
            value: "Sesi pagi\n07.30-12.00",
            groupValue: radioGroup,
            isExpandedText: true,
            onChange: (value) {
              setState(() {
                radioGroup = value;
              });
            },
          ),
          SizedBox(height: 10.h),
          // Sesi siang
          CustomRadioButton(
            text: "Sesi siang\n13:00-16:00",
            value: "Sesi siang\n13:00-16:00",
            groupValue: radioGroup,
            isExpandedText: true,
            onChange: (value) {
              setState(() {
                radioGroup = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
