import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

import '../pengajuan_cuti_setengah_hari_pegawai_screen/pengajuan_cuti_setengah_hari_pegawai_screen.dart';
import '../dashboard_pegawai_screen/dashboard_pegawai_screen.dart';

class PengajuanCutiPegawaiScreen extends StatefulWidget {
  const PengajuanCutiPegawaiScreen({Key? key}) : super(key: key);

  @override
  _PengajuanCutiPegawaiScreenState createState() =>
      _PengajuanCutiPegawaiScreenState();
}

class _PengajuanCutiPegawaiScreenState
    extends State<PengajuanCutiPegawaiScreen> {
  /// List opsi jenis cuti (dropdown)
  final List<String> dropdownItemList = [
    "Tahunan",
    "Besar",
    "Sakit",
    "Melahirkan",
    "Alasan Penting",
    "Cuti Luar Tanggungan",
    "Perpanjangan CLTN",
    "Cuti Setengah Hari"
  ];

  /// Nilai default dropdown
  String selectedOption = "Tahunan";

  /// Controller untuk form
  final TextEditingController lamaCutiController = TextEditingController();
  final TextEditingController tanggalSelesaiController =
      TextEditingController();
  final TextEditingController alasanController = TextEditingController();
  final TextEditingController tanggalMulaiController = TextEditingController();

  /// Variabel untuk menyimpan tanggal aslinya
  DateTime? selectedMulaiDate;
  DateTime? selectedSelesaiDate;

  /// Status loading saat submit
  bool _isSubmitting = false;

  /// Cek apakah seluruh form terisi
  bool isFormValid() {
    return lamaCutiController.text.isNotEmpty &&
        tanggalSelesaiController.text.isNotEmpty &&
        tanggalMulaiController.text.isNotEmpty &&
        alasanController.text.isNotEmpty;
  }

  /// Menghitung hari kerja di antara rentang tanggal (tidak termasuk Sabtu/Minggu)
  int _calculateLeaveDays(DateTime start, DateTime end) {
    int leaveDays = 0;
    DateTime current = start;
    while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
      if (current.weekday != DateTime.saturday &&
          current.weekday != DateTime.sunday) {
        leaveDays++;
      }
      current = current.add(const Duration(days: 1));
    }
    return leaveDays;
  }

  /// ShowDatePicker + set State
  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
    DateTime? initialDate,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        // Format dd/MM/yyyy
        controller.text = DateFormat('dd/MM/yyyy').format(picked);

        // Jika user memilih tanggal mulai
        if (controller == tanggalMulaiController) {
          if (!_isWithinThreeWorkdays(picked)) {
            // Jika tanggal melebihi 3 hari kerja, tampilkan error
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Pengajuan cuti harus dalam 3 hari kerja dari tanggal mulai.'),
              ),
            );
            selectedMulaiDate = null;
            controller.clear();
          } else if (selectedSelesaiDate != null &&
              picked.isAfter(selectedSelesaiDate!)) {
            // Jika tanggal mulai lebih besar dari tanggal selesai
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Tanggal mulai tidak boleh lebih besar dari tanggal selesai.'),
              ),
            );
            selectedMulaiDate = null;
            controller.clear();
          } else {
            selectedMulaiDate = picked;

            // Hitung durasi cuti jika tanggal selesai valid
            if (selectedSelesaiDate != null) {
              int leaveDays = _calculateLeaveDays(picked, selectedSelesaiDate!);
              _validateLeaveDuration(context, leaveDays);
            }
          }
        }

        // Jika user memilih tanggal selesai
        else if (controller == tanggalSelesaiController) {
          if (selectedMulaiDate != null &&
              picked.isBefore(selectedMulaiDate!)) {
            // Jika tanggal selesai lebih kecil dari tanggal mulai
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Tanggal selesai tidak boleh lebih kecil dari tanggal mulai.'),
              ),
            );
            selectedSelesaiDate = null;
            controller.clear();
          } else {
            selectedSelesaiDate = picked;

            // Hitung durasi cuti jika tanggal mulai valid
            if (selectedMulaiDate != null) {
              int leaveDays = _calculateLeaveDays(selectedMulaiDate!, picked);
              _validateLeaveDuration(context, leaveDays);
            }
          }
        }
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

  /// Fungsi untuk validasi durasi cuti
  void _validateLeaveDuration(BuildContext context, int leaveDays) {
    if (leaveDays > 3) {
      // Durasi cuti tidak boleh lebih dari 5 hari kerja
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Durasi cuti tidak boleh lebih dari 3 hari kerja.'),
        ),
      );

      // Reset tanggal selesai dan lama cuti
      setState(() {
        selectedSelesaiDate = null;
        tanggalSelesaiController.clear();
        lamaCutiController.clear();
      });
    } else {
      // Update lama cuti jika valid
      setState(() {
        lamaCutiController.text = leaveDays.toString();
      });
    }
  }

  /// Menyimpan data cuti ke Firestore
  Future<void> _submitToFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User belum login!')),
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
      _isSubmitting = true;
    });

    try {
      await FirebaseFirestore.instance.collection('submissions').add({
        'user_id': user.uid,
        'status': status,
        'submission_type': "Pengajuan Cuti",
        'submission_data': {
          'duration_leave': int.tryParse(lamaCutiController.text) ?? 0,
          'end_time': selectedSelesaiDate ?? DateTime.now(),
          'leave_type': selectedOption,
          'reason': alasanController.text,
          'start_time': selectedMulaiDate ?? DateTime.now(),
        },
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      });

      Navigator.pushNamed(context, AppRoutes.submitBerhasilScreen);
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan data: $e')),
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
                            _buildJenisCutiDropdown(context),
                            SizedBox(height: 24.h),
                            _buildMulai(context),
                            SizedBox(height: 16.h),
                            _buildSelesai(context),
                            SizedBox(height: 16.h),
                            _buildLamaCuti(context),
                            SizedBox(height: 16.h),
                            _buildAlasan(context),
                            SizedBox(height: 122.h),
                            _buildSubmitButton(context),
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
          // Overlay untuk loading
          if (_isSubmitting)
            Container(
              color: Colors.black.withOpacity(0.5), // Transparansi overlay
              child: const Center(
                child: CircularProgressIndicator(), // Loading indikator
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
          // Kembali ke Dashboard Pegawai (atau pop)
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
      title: AppbarTitle(text: "Pengajuan Cuti"),
      styleType: Style.bgFillTeal200,
    );
  }

  /// Dropdown Pilihan Jenis Cuti
  Widget _buildJenisCutiDropdown(BuildContext context) {
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
              borderRadius: BorderRadius.circular(4.h),
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
                    // Jika user pilih "Cuti Setengah Hari", pindah screen lain
                    if (value == "Cuti Setengah Hari") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const PengajuanCutiSetengahHariPegawaiScreen(),
                        ),
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

  /// Field "Mulai"
  Widget _buildMulai(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Mulai",
            style: CustomTextStyles.titleLargeErrorContainer,
          ),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: () =>
                _selectDate(context, tanggalMulaiController, selectedMulaiDate),
            child: AbsorbPointer(
              child: CustomTextFormField(
                controller: tanggalMulaiController,
                hintText: "Pilih Tanggal Mulai",
                hintStyle: CustomTextStyles.bodyMediumErrorContainer_1,
                onChanged: (val) {
                  setState(() {});
                },
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

  /// Field "Selesai"
  Widget _buildSelesai(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Selesai",
            style: CustomTextStyles.titleLargeErrorContainer,
          ),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: () => _selectDate(
                context, tanggalSelesaiController, selectedSelesaiDate),
            child: AbsorbPointer(
              child: CustomTextFormField(
                controller: tanggalSelesaiController,
                hintText: "Pilih Tanggal Selesai",
                hintStyle: CustomTextStyles.bodyMediumErrorContainer_1,
                onChanged: (val) {
                  setState(() {});
                },
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

  /// Field "Lama Cuti" (READONLY)
  Widget _buildLamaCuti(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Lama Cuti",
            style: CustomTextStyles.titleLargeErrorContainer,
          ),
          SizedBox(height: 12.h),
          TextFormField(
            controller: lamaCutiController,
            // Hilangkan onChanged, readOnly agar user tidak mengetik
            readOnly: true,
            style: theme.textTheme.bodySmall,
            decoration: InputDecoration(
              hintText: "Lama Cuti (Hari)",
              hintStyle: CustomTextStyles.bodyMediumErrorContainer_1,
              contentPadding: EdgeInsets.fromLTRB(14.h, 12.h, 10.h, 12.h),
              filled: true,
              fillColor: appTheme.whiteA700,
              border: TextFormFieldStyleHelper.outlineErrorContainerTL4,
              enabledBorder: TextFormFieldStyleHelper.outlineErrorContainerTL4,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.h),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Field "Alasan"
  Widget _buildAlasan(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Alasan",
            style: CustomTextStyles.titleLargeErrorContainer,
          ),
          SizedBox(height: 12.h),
          CustomTextFormField(
            controller: alasanController,
            hintText: "Berikan Alasan...",
            hintStyle: CustomTextStyles.bodyMediumErrorContainer_1,
            onChanged: (val) {
              setState(() {});
            },
            contentPadding: EdgeInsets.fromLTRB(14.h, 12.h, 10.h, 12.h),
            borderDecoration: TextFormFieldStyleHelper.outlineErrorContainerTL4,
            filled: true,
            fillColor: appTheme.whiteA700,
          ),
        ],
      ),
    );
  }

  /// Tombol "Submit"
  Widget _buildSubmitButton(BuildContext context) {
    return CustomElevatedButton(
      height: 32.h,
      width: 76.h,
      text: "Submit",
      margin: EdgeInsets.only(right: 2.h),
      buttonStyle: isFormValid() && !_isSubmitting
          ? CustomButtonStyles.fillTeal
          : CustomButtonStyles.fillGray,
      buttonTextStyle: isFormValid() && !_isSubmitting
          ? CustomTextStyles.titleSmallWhiteA700
          : CustomTextStyles.bodyMediumErrorContainer_1,
      onPressed:
          isFormValid() && !_isSubmitting ? () => _onTapSubmit(context) : null,
    );
  }

  void _onTapSubmit(BuildContext context) {
    _submitToFirestore();
  }
}
