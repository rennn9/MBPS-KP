import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../pengajuan_cuti_setengah_hari_pegawai_screen/pengajuan_cuti_setengah_hari_pegawai_screen.dart';
import '../dashboard_pegawai_screen/dashboard_pegawai_screen.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

// ignore_for_file: must_be_immutable
class PengajuanCutiPegawaiScreen extends StatefulWidget {
  PengajuanCutiPegawaiScreen({Key? key}) : super(key: key);

  @override
  _PengajuanCutiPegawaiScreenState createState() =>
      _PengajuanCutiPegawaiScreenState();
}

class _PengajuanCutiPegawaiScreenState
    extends State<PengajuanCutiPegawaiScreen> {
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
  String selectedOption = "Tahunan"; // Track selected dropdown option

  TextEditingController group37040oneController = TextEditingController();
  TextEditingController stashdatadateliController = TextEditingController();
  TextEditingController berikanController = TextEditingController();
  TextEditingController mulaiController = TextEditingController();

  DateTime? selectedMulaiDate;
  DateTime? selectedSelesaiDate;

  bool isFormValid() {
    return selectedOption.isNotEmpty &&
        group37040oneController.text.isNotEmpty &&
        stashdatadateliController.text.isNotEmpty &&
        mulaiController.text.isNotEmpty &&
        berikanController.text.isNotEmpty;
  }

  // Fungsi untuk menghitung jumlah hari kerja
  int _workingDaysBetween(DateTime start, DateTime end) {
    int days = 0;
    DateTime current = start;

    while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
      if (current.weekday != DateTime.saturday &&
          current.weekday != DateTime.sunday) {
        days++;
      }
      current = current.add(Duration(days: 1));
    }
    return days;
  }

  Future<void> _selectDate(BuildContext context,
      TextEditingController controller, DateTime? initialDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('dd/MM/yyyy').format(picked);
        if (controller == mulaiController) {
          selectedMulaiDate = picked;
          group37040oneController.clear();
        } else if (controller == stashdatadateliController) {
          selectedSelesaiDate = picked;
          if (selectedMulaiDate != null) {
            if (selectedSelesaiDate!.isBefore(selectedMulaiDate!)) {
              selectedSelesaiDate = null;
              stashdatadateliController.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Tanggal selesai tidak boleh sebelum tanggal mulai.'),
                ),
              );
            } else {
              int daysBetween =
                  _workingDaysBetween(selectedMulaiDate!, DateTime.now());
              if (daysBetween <= 4) {
                group37040oneController.text = daysBetween.toString();
              } else {
                selectedSelesaiDate = null;
                stashdatadateliController.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          'Pengajuan cuti harus dalam 3 hari kerja dari tanggal mulai.')),
                );
              }
            }
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                        _buildOpsijeniscuti(context),
                        SizedBox(height: 24.h),
                        _buildColumnmdone(context),
                        SizedBox(height: 14.h),
                        _buildMulai(context),
                        SizedBox(height: 16.h),
                        _buildSelesai(context),
                        SizedBox(height: 16.h),
                        _buildColumnmdfour(context),
                        SizedBox(height: 122.h),
                        _buildSubmit(context),
                      ],
                    ),
                  ),
                  SizedBox(height: 6.h)
                ],
              ),
            ),
          ),
        ),
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
              builder: (context) =>
                  DashboardPegawaiScreen(), // Update with the correct screen class
            ),
            (route) => false, // Clears the navigation stack
          );
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Pengajuan Cuti",
      ),
      styleType: Style.bgFillTeal200,
    );
  }

  Widget _buildOpsijeniscuti(BuildContext context) {
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
                    if (value == "Cuti Setengah Hari") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PengajuanCutiSetengahHariPegawaiScreen(),
                        ),
                      );
                    }
                  });
                },
                isExpanded: true, // Ensures the dropdown expands fully
                icon: Icon(Icons.arrow_drop_down), // Ensures arrow is visible
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroup37040one(BuildContext context) {
    return TextFormField(
      controller: group37040oneController,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: theme.textTheme.bodySmall,
      decoration: InputDecoration(
        hintText: "Masukkan Lama Cuti (Hari)",
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
    );
  }

  Widget _buildColumnmdone(BuildContext context) {
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
          _buildGroup37040one(context),
        ],
      ),
    );
  }

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
                _selectDate(context, mulaiController, selectedMulaiDate),
            child: AbsorbPointer(
              child: CustomTextFormField(
                controller: mulaiController,
                hintText: "Pilih Tanggal Mulai",
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

  Widget _buildStashdatadateli(BuildContext context) {
    return CustomTextFormField(
      controller: stashdatadateliController,
      hintText: "Pilih Tanggal Selesai",
      hintStyle: CustomTextStyles.bodyMediumErrorContainer_1,
      suffix: Container(
        margin: EdgeInsets.fromLTRB(16.h, 12.h, 10.h, 12.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgStashdatadatelight,
          height: 26.h,
          width: 32.h,
          fit: BoxFit.contain,
        ),
      ),
      suffixConstraints: BoxConstraints(
        maxHeight: 50.h,
      ),
      contentPadding: EdgeInsets.fromLTRB(14.h, 12.h, 10.h, 12.h),
      borderDecoration: TextFormFieldStyleHelper.outlineErrorContainerTL41,
    );
  }

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
                context, stashdatadateliController, selectedSelesaiDate),
            child: AbsorbPointer(
              child: CustomTextFormField(
                controller: stashdatadateliController,
                hintText: "Pilih Tanggal Selesai",
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

  Widget _buildColumnmdfour(BuildContext context) {
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
            controller: berikanController,
            hintText: "Berikan Alasan...",
            hintStyle: CustomTextStyles.bodyMediumErrorContainer_1,
            contentPadding: EdgeInsets.fromLTRB(14.h, 12.h, 10.h, 12.h),
            borderDecoration: TextFormFieldStyleHelper.outlineErrorContainerTL4,
            filled: true,
            fillColor: appTheme.whiteA700,
          ),
        ],
      ),
    );
  }

  Widget _buildSubmit(BuildContext context) {
    return CustomElevatedButton(
      height: 32.h,
      width: 76.h,
      text: "Submit",
      margin: EdgeInsets.only(right: 2.h),
      buttonStyle: isFormValid()
          ? CustomButtonStyles.fillTeal // Active button style
          : CustomButtonStyles.fillGray, // Disabled button style
      buttonTextStyle: isFormValid()
          ? CustomTextStyles.titleSmallWhiteA700 // Active text style
          : CustomTextStyles.bodyMediumErrorContainer_1, // Disabled text style
      onPressed: isFormValid()
          ? () => onTapSubmit(context)
          : null, // Disable the button if the form is invalid
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the submitBerhasilScreen when the action is triggered.
  onTapSubmit(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.submitBerhasilScreen);
  }
}
