import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

class MenuAbsenManualPegawai1Screen extends StatefulWidget {
  const MenuAbsenManualPegawai1Screen({Key? key}) : super(key: key);

  @override
  _MenuAbsenManualPegawai1ScreenState createState() =>
      _MenuAbsenManualPegawai1ScreenState();
}

class _MenuAbsenManualPegawai1ScreenState
    extends State<MenuAbsenManualPegawai1Screen> {
  /// Controller
  TextEditingController tanggalController =
      TextEditingController(); // Tanggal Kehadiran
  TextEditingController jamMulaiController =
      TextEditingController(); // Jam Mulai
  TextEditingController jamSelesaiController =
      TextEditingController(); // Jam Selesai
  TextEditingController deskripsiController =
      TextEditingController(); // Deskripsi

  /// Variabel memilih WFO/WFOL
  String selectedOption = ''; // 'WFO' / 'WFOL'

  /// Variabel untuk Tanggal
  DateTime? selectedDate = DateTime.now();

  /// Status loading saat submit
  bool _isSubmitting = false;

  /// Cek Form Valid
  bool isFormValid() {
    return selectedOption.isNotEmpty &&
        tanggalController.text.isNotEmpty &&
        jamMulaiController.text.isNotEmpty &&
        jamSelesaiController.text.isNotEmpty &&
        deskripsiController.text.isNotEmpty;
  }

  /// Fungsi menampilkan DatePicker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        // Format ke dd/MM/yyyy
        tanggalController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  /// Time Picker Spinner (Jam Mulai / Jam Selesai)
  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    DateTime selectedTime = DateTime.now();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TimePickerSpinner(
                is24HourMode: false,
                normalTextStyle:
                    const TextStyle(fontSize: 24, color: Colors.black54),
                highlightedTextStyle:
                    const TextStyle(fontSize: 24, color: Colors.black),
                spacing: 50,
                itemHeight: 60,
                isForce2Digits: true,
                onTimeChange: (time) {
                  selectedTime = time;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    controller.text = DateFormat.jm().format(selectedTime);
                  });
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Convert Tanggal + Waktu ke Timestamp
  Timestamp? _combineDateAndTime(String date, String time) {
    try {
      final parsedDate = DateFormat('dd/MM/yyyy').parse(date);
      final parsedTime = DateFormat.jm().parse(time);

      final combinedDateTime = DateTime(
        parsedDate.year,
        parsedDate.month,
        parsedDate.day,
        parsedTime.hour,
        parsedTime.minute,
      );

      return Timestamp.fromDate(combinedDateTime);
    } catch (e) {
      debugPrint("Error combining date and time: $e");
      return null;
    }
  }

  /// Submit data ke Firestore
  Future<void> _submitToFirestore() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User belum login!")),
        );
        return;
      }

      setState(() {
        _isSubmitting = true; // Mulai loading
      });

      final attendanceDate =
          _combineDateAndTime(tanggalController.text, jamMulaiController.text);
      final startTime =
          _combineDateAndTime(tanggalController.text, jamMulaiController.text);
      final endTime = _combineDateAndTime(
          tanggalController.text, jamSelesaiController.text);

      if (attendanceDate == null || startTime == null || endTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Format tanggal atau waktu tidak valid.")),
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

      await FirebaseFirestore.instance.collection('submissions').add({
        'user_id': user.uid,
        'status': status,
        'submission_type': "Presensi Manual",
        'submission_data': {
          'attendance_type': selectedOption,
          'attendance_date': attendanceDate,
          'start_time': startTime,
          'end_time': endTime,
          'description': deskripsiController.text,
        },
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      });

      // Pindah ke halaman "submitBerhasilScreen"
      Navigator.pushNamed(context, AppRoutes.submitBerhasilScreen);
    } catch (e) {
      debugPrint("Error: $e");
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
            appBar: _buildAppbar(context),
            body: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(
                    left: 14.h,
                    top: 20.h,
                    right: 14.h,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(left: 2.h),
                        padding: EdgeInsets.symmetric(horizontal: 14.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _buildTip(context),
                            SizedBox(height: 18.h),
                            _buildColumnTanggal(context),
                            SizedBox(height: 16.h),
                            _buildColumnJam(context),
                            SizedBox(height: 16.h),
                            _buildColumnDeskripsi(context),
                            SizedBox(height: 50.h),
                            _buildSubmit(context),
                          ],
                        ),
                      ),
                      SizedBox(height: 6.h),
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

  /// AppBar
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
        text: "Presensi Manuall",
      ),
      styleType: Style.bgFillTeal200,
    );
  }

  /// Bagian Pilihan WFO / WFOL
  Widget _buildWfo(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        height: 60.h,
        text: "WFO",
        buttonStyle: CustomButtonStyles.fillErrorContainer,
        buttonTextStyle: selectedOption == 'WFO'
            ? theme.textTheme.titleMedium!
            : CustomTextStyles.titleMediumErrorContainer_1,
        onPressed: () {
          setState(() {
            selectedOption = 'WFO';
          });
        },
      ),
    );
  }

  Widget _buildWfol(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        height: 60.h,
        text: "WFOL",
        buttonStyle: CustomButtonStyles.fillErrorContainer,
        buttonTextStyle: selectedOption == 'WFOL'
            ? theme.textTheme.titleMedium!
            : CustomTextStyles.titleMediumErrorContainer_1,
        onPressed: () {
          setState(() {
            selectedOption = 'WFOL';
          });
        },
      ),
    );
  }

  /// Bagian "Kehadiran"
  Widget _buildTip(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Kehadiran",
            style: CustomTextStyles.titleLargeErrorContainer,
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                _buildWfo(context),
                SizedBox(width: 28.h),
                _buildWfol(context)
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Bagian Tanggal
  Widget _buildColumnTanggal(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tanggal Kehadiran",
            style: CustomTextStyles.titleLargeErrorContainer,
          ),
          SizedBox(height: 10.h),

          // GestureDetector => showDatePicker
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: CustomTextFormField(
                controller: tanggalController,
                hintText: "Masukkan Tanggal",
                hintStyle: CustomTextStyles.bodyMediumErrorContainer_1,
                suffix: Container(
                  margin: EdgeInsets.fromLTRB(16.h, 12.h, 10.h, 12.h),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgVectorErrorcontainer,
                    height: 26.h,
                    width: 32.h,
                    fit: BoxFit.contain,
                  ),
                ),
                suffixConstraints: BoxConstraints(
                  maxHeight: 50.h,
                ),
                contentPadding: EdgeInsets.fromLTRB(14.h, 12.h, 10.h, 12.h),
                borderDecoration:
                    TextFormFieldStyleHelper.outlineErrorContainerTL41,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Bagian Jam (Mulai & Selesai)
  Widget _buildColumnJam(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Jam Kehadiran",
            style: CustomTextStyles.titleLargeErrorContainer,
          ),
          SizedBox(height: 20.h),

          // Jam Mulai
          GestureDetector(
            onTap: () => _selectTime(context, jamMulaiController),
            child: AbsorbPointer(
              child: CustomTextFormField(
                controller: jamMulaiController,
                hintText: "Masukkan Jam Mulai",
                hintStyle: CustomTextStyles.bodyMediumErrorContainer_1,
                contentPadding: EdgeInsets.all(14.h),
                borderDecoration:
                    TextFormFieldStyleHelper.outlineErrorContainerTL41,
                onChanged: (val) {
                  setState(() {});
                },
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // Jam Selesai
          GestureDetector(
            onTap: () => _selectTime(context, jamSelesaiController),
            child: AbsorbPointer(
              child: CustomTextFormField(
                controller: jamSelesaiController,
                hintText: "Masukkan Jam Selesai",
                hintStyle: CustomTextStyles.bodyMediumErrorContainer_1,
                contentPadding: EdgeInsets.all(14.h),
                borderDecoration:
                    TextFormFieldStyleHelper.outlineErrorContainerTL41,
                onChanged: (val) {
                  setState(() {});
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Bagian Deskripsi
  Widget _buildColumnDeskripsi(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deskripsi",
            style: CustomTextStyles.titleLargeErrorContainer,
          ),
          SizedBox(height: 20.h),
          CustomTextFormField(
            controller: deskripsiController,
            hintText: "Tulis deskripsi di sini...",
            hintStyle: CustomTextStyles.bodyMediumErrorContainer_1,
            onChanged: (val) {
              setState(() {});
            },
            contentPadding: EdgeInsets.all(14.h),
            borderDecoration:
                TextFormFieldStyleHelper.outlineErrorContainerTL41,
          ),
        ],
      ),
    );
  }

  /// Tombol Submit
  Widget _buildSubmit(BuildContext context) {
    return CustomElevatedButton(
      height: 32.h,
      width: 76.h,
      text: "Submit",
      margin: EdgeInsets.only(right: 2.h),
      buttonStyle: isFormValid()
          ? CustomButtonStyles.fillTeal
          : CustomButtonStyles.fillGray,
      buttonTextStyle: isFormValid()
          ? CustomTextStyles.titleSmallWhiteA700
          : CustomTextStyles.bodyMediumErrorContainer_1,
      onPressed: isFormValid() ? () => _submitToFirestore() : null,
    );
  }
}
