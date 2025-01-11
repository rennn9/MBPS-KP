import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_radio_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../pengajuan_cuti_pegawai_screen/pengajuan_cuti_pegawai_screen.dart';
import '../dashboard_pegawai_screen/dashboard_pegawai_screen.dart';

// ignore_for_file: must_be_immutable

class PengajuanCutiSetengahHariPegawaiScreen extends StatefulWidget {
  @override
  _PengajuanCutiSetengahHariPegawaiScreenState createState() =>
      _PengajuanCutiSetengahHariPegawaiScreenState();
}

class _PengajuanCutiSetengahHariPegawaiScreenState
    extends State<PengajuanCutiSetengahHariPegawaiScreen> {
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
  String selectedOption =
      "Cuti Setengah Hari"; // Default to "Cuti Setengah Hari"
  TextEditingController berikanController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  DateTime? selectedTanggal;
  String radioGroup = "";

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
      setState(() {
        tanggalController.text = DateFormat('dd/MM/yyyy').format(picked);

        // Hitung jumlah hari kerja dari hari ini ke tanggal yang dipilih
        DateTime now = DateTime.now();
        int workingDays = 0;
        DateTime current = now.isBefore(picked) ? now : picked;
        DateTime endDate = now.isBefore(picked) ? picked : now;

        while (current.isBefore(endDate) || current.isAtSameMomentAs(endDate)) {
          if (current.weekday != DateTime.saturday &&
              current.weekday != DateTime.sunday) {
            workingDays++;
          }
          current = current.add(Duration(days: 1));
        }

        // Validasi: Tanggal harus dalam 3 hari kerja dari hari ini
        if (workingDays > 4) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('Tanggal cuti harus dalam 3 hari kerja dari hari ini.'),
            ),
          );
          selectedTanggal = null;
          tanggalController.clear();
        } else {
          selectedTanggal = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      Spacer(),
                      CustomElevatedButton(
                        height: 32.h,
                        width: 76.h,
                        text: "Submit",
                        margin: EdgeInsets.only(bottom: 20.h),
                        buttonStyle: isFormValid()
                            ? CustomButtonStyles.fillTeal // Active style
                            : CustomButtonStyles.fillGray, // Disabled style
                        buttonTextStyle: isFormValid()
                            ? CustomTextStyles.titleSmallWhiteA700
                            : CustomTextStyles.bodyMediumErrorContainer_1,
                        onPressed: isFormValid()
                            ? () => onTapSubmit(context)
                            : null, // Disable button if form is invalid
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
              builder: (context) => DashboardPegawaiScreen(),
            ),
            (route) => false, // Clears the navigation stack
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
                    if (value != "Cuti Setengah Hari") {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PengajuanCutiPegawaiScreen(),
                        ),
                        (route) => false,
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
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: CustomRadioButton(
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
          ),
        ],
      ),
    );
  }

  /// Navigates to the submitBerhasilScreen when the action is triggered.
  onTapSubmit(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.submitBerhasilScreen);
  }
}
