import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart'; // Import for time picker spinner
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class MenuAbsenManualPegawai1Screen extends StatefulWidget {
  MenuAbsenManualPegawai1Screen({Key? key}) : super(key: key);

  @override
  _MenuAbsenManualPegawai1ScreenState createState() =>
      _MenuAbsenManualPegawai1ScreenState();
}

class _MenuAbsenManualPegawai1ScreenState
    extends State<MenuAbsenManualPegawai1Screen> {
  TextEditingController stashdatadateliController = TextEditingController();
  TextEditingController masukkanjamController = TextEditingController();
  TextEditingController group37017oneController = TextEditingController();
  TextEditingController weuipencilfilleController = TextEditingController();

  String selectedOption = 'WFO'; // Track selected option
  DateTime selectedDate = DateTime.now();

  // Check if all fields are filled
  // Check if all fields (except WFO/WFOL) are filled and valid
  bool isFormValid() {
    return stashdatadateliController.text.isNotEmpty &&
        masukkanjamController.text.isNotEmpty &&
        group37017oneController.text.isNotEmpty &&
        weuipencilfilleController.text.isNotEmpty;
  }

  // Date Picker function
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        stashdatadateliController.text =
            DateFormat('dd/MM/yyyy').format(selectedDate);
      });
  }

  // Custom Time Picker with Spinner
  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    DateTime selectedTime = DateTime.now();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TimePickerSpinner(
                is24HourMode: false,
                normalTextStyle: TextStyle(fontSize: 24, color: Colors.black54),
                highlightedTextStyle:
                    TextStyle(fontSize: 24, color: Colors.black),
                spacing: 50,
                itemHeight: 60,
                isForce2Digits: true,
                onTimeChange: (time) {
                  selectedTime = time;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  controller.text = "${DateFormat.jm().format(selectedTime)}";
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          ),
        );
      },
    );
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
                        _buildTip(context),
                        SizedBox(height: 18.h),
                        _buildColumnmdtwo(context),
                        SizedBox(height: 16.h),
                        _buildColumnmdthree(context),
                        SizedBox(height: 16.h),
                        _buildColumnmdfour(context),
                        SizedBox(height: 50.h),
                        _buildSubmit(context)
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

  /// Section Widget
  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 43.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeftWhiteA700,
        margin: EdgeInsets.only(left: 33.h),
        onTap: () {},
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Absensi Manual",
      ),
      styleType: Style.bgFillTeal200,
    );
  }

  /// Section Widget for WFO Button
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

  /// Section Widget for WFOL Button
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

  /// Section Widget for selecting option
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

  Widget _buildStashdatadateli(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context), // Trigger the date picker on tap
      child: AbsorbPointer(
        child: CustomTextFormField(
          controller: stashdatadateliController,
          hintText: "Masukkan Tanggal",
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
        ),
      ),
    );
  }

  /// Section Widget for Masukkan Jam Mulai
  Widget _buildMasukkanjam(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectTime(context, masukkanjamController),
      child: AbsorbPointer(
        child: CustomTextFormField(
          controller: masukkanjamController,
          hintText: "Masukkan Jam Mulai",
          hintStyle: CustomTextStyles.bodyMediumErrorContainer_1,
          contentPadding: EdgeInsets.all(14.h),
          borderDecoration: TextFormFieldStyleHelper.outlineErrorContainerTL41,
        ),
      ),
    );
  }

  // Section Widget for Masukkan Jam Selesai
  Widget _buildGroup37017one(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectTime(context, group37017oneController),
      child: AbsorbPointer(
        child: CustomTextFormField(
          controller: group37017oneController,
          hintText: "Masukkan Jam Selesai",
          hintStyle: CustomTextStyles.bodyMediumErrorContainer_1,
          contentPadding: EdgeInsets.all(14.h),
          borderDecoration: TextFormFieldStyleHelper.outlineErrorContainerTL41,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnmdtwo(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tanggal Absen",
            style: CustomTextStyles.titleLargeErrorContainer,
          ),
          SizedBox(height: 10.h),
          _buildStashdatadateli(context)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnmdthree(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Jam Absen",
            style: CustomTextStyles.titleLargeErrorContainer,
          ),
          SizedBox(height: 14.h),
          _buildMasukkanjam(context),
          SizedBox(height: 14.h),
          _buildGroup37017one(context)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildWeuipencilfille(BuildContext context) {
    return CustomTextFormField(
      controller: weuipencilfilleController,
      hintText: "Berikan Alasan...",
      hintStyle: CustomTextStyles.bodyMediumErrorContainer_1,
      textInputAction: TextInputAction.done,
      suffix: Container(
        margin: EdgeInsets.fromLTRB(16.h, 12.h, 14.h, 12.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgWeuipencilfilled,
          height: 24.h,
          width: 24.h,
          fit: BoxFit.contain,
        ),
      ),
      suffixConstraints: BoxConstraints(
        maxHeight: 150.h,
      ),
      maxLines: 6,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 14.h,
        vertical: 12.h,
      ),
      borderDecoration: TextFormFieldStyleHelper.outlineErrorContainerTL41,
    );
  }

  /// Section Widget
  Widget _buildColumnmdfour(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Alasan",
            style: CustomTextStyles.titleLargeErrorContainer,
          ),
          SizedBox(height: 12.h),
          _buildWeuipencilfille(context)
        ],
      ),
    );
  }

    /// Section Widget
  Widget _buildSubmit(BuildContext context) {
    return CustomElevatedButton(
      height: 32.h,
      width: 76.h,
      text: "Submit",
      margin: EdgeInsets.only(right: 2.h),
      buttonStyle: CustomButtonStyles.fillTeal,
      buttonTextStyle: CustomTextStyles.titleSmallWhiteA700,
      onPressed: isFormValid() ? () => onTapSubmit(context) : null, // Disable the button if the form is invalid
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the menuAbsenManualPegawai2Screen when the action is triggered.
  onTapWfol(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.menuAbsenManualPegawai2Screen);
  }

  /// Navigates to the submitBerhasilScreen when the action is triggered.
  onTapSubmit(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.submitBerhasilScreen);
  }
}
