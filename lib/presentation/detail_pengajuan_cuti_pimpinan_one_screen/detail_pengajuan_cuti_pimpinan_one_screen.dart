import 'package:flutter/material.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

// ignore_for_file: must_be_immutable
class DetailPengajuanCutiPimpinanOneScreen extends StatelessWidget {
  DetailPengajuanCutiPimpinanOneScreen({Key? key}) : super(key: key);

  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              height: 734,
              width: double.maxFinite,
              padding: EdgeInsets.only(
                left: 28,
                top: 18,
                right: 28,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 592,
                    width: double.maxFinite,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.only(
                            left: 8,
                            top: 24,
                            right: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Color(0XFFCBD5E0),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 40),
                              Text(
                                "Rendi Wijaya",
                                style: TextStyle(
                                  color: Color(0X19000000).withOpacity(1),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "IPDS",
                                style: TextStyle(
                                  color: Color(0X19000000).withOpacity(0.7),
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 18),
                              SizedBox(
                                width: double.maxFinite,
                                child: Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(0X19000000).withOpacity(0.3),
                                  indent: 18,
                                  endIndent: 14,
                                ),
                              ),
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 4),
                                  child: Text(
                                    "Info Pengajuan",
                                    style: TextStyle(
                                      color: Color(0X19000000).withOpacity(1),
                                      fontSize: 14,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 14),
                              Container(
                                width: double.maxFinite,
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                child: _buildRowtanggal(
                                  context,
                                  tanggalOne: "Tipe",
                                  p10oktober2024: "1 Hari",
                                ),
                              ),
                              SizedBox(height: 4),
                              SizedBox(
                                width: double.maxFinite,
                                child: Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(0X19000000),
                                  indent: 4,
                                ),
                              ),
                              SizedBox(height: 8),
                              Container(
                                width: double.maxFinite,
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                child: _buildRowtanggal(
                                  context,
                                  tanggalOne: "Tanggal Pengajuan",
                                  p10oktober2024: "10 Oktober 2024",
                                ),
                              ),
                              SizedBox(height: 4),
                              SizedBox(
                                width: double.maxFinite,
                                child: Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(0X19000000),
                                  indent: 4,
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: double.maxFinite,
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                child: _buildRowtanggal(
                                  context,
                                  tanggalOne: "Tanggal Cuti",
                                  p10oktober2024: "15 Oktober 2024",
                                ),
                              ),
                              SizedBox(height: 4),
                              SizedBox(
                                width: double.maxFinite,
                                child: Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(0X19000000),
                                  indent: 4,
                                ),
                              ),
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 4),
                                  child: Text(
                                    "Alasan Cuti",
                                    style: TextStyle(
                                      color: Color(0X19000000).withOpacity(0.4),
                                      fontSize: 13,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 6),
                              Container(
                                width: 294,
                                margin: EdgeInsets.only(left: 4),
                                child: TextFormField(
                                  focusNode: FocusNode(),
                                  autofocus: true,
                                  controller: descriptionController,
                                  style: TextStyle(
                                    color: Color(0X19000000).withOpacity(1),
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textInputAction: TextInputAction.done,
                                  maxLines: 6,
                                  decoration: InputDecoration(
                                    hintText:
                                        "Lorem ipsum dolor sit amet consectetur. Arcu quisque pretium feugiat sapien egestas consectetur. A maecenas purus at odio a lorem. Fermentum vel auctor suspendisse id volutpat viverra aliquam enim. Vitae quis mattis eu ultricies vulputate ipsum eu.",
                                    hintStyle: TextStyle(
                                      color: Color(0X19000000).withOpacity(1),
                                      fontSize: 12,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                        color: Color(0X19000000),
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                        color: Color(0X19000000),
                                        width: 1,
                                      ),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                        color: Color(0X19000000),
                                        width: 1,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                        color: Color(0X19000000),
                                        width: 1,
                                      ),
                                    ),
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12, 8, 12, 4),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: double.maxFinite,
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                child: _buildRowtanggal(
                                  context,
                                  tanggalOne: "Status",
                                  p10oktober2024: "Disetujui Ketua Tim",
                                ),
                              ),
                              SizedBox(height: 4),
                              SizedBox(
                                width: double.maxFinite,
                                child: Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(0X19000000),
                                  indent: 4,
                                ),
                              ),
                              SizedBox(height: 52),
                              Container(
                                width: double.maxFinite,
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        width: double.maxFinite,
                                        height: 28,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            backgroundColor: Color(0XFFFF4948),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            visualDensity: const VisualDensity(
                                              vertical: -4,
                                              horizontal: -4,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 30,
                                              vertical: 4,
                                            ),
                                          ),
                                          onPressed: () {},
                                          child: Text(
                                            "Tolak",
                                            style: TextStyle(
                                              color: Color(0XFFFFFFFF),
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: SizedBox(
                                        width: double.maxFinite,
                                        height: 28,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            backgroundColor: Color(0XFF01C971),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            visualDensity: const VisualDensity(
                                              vertical: -4,
                                              horizontal: -4,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 30,
                                              vertical: 4,
                                            ),
                                          ),
                                          onPressed: () {},
                                          child: Text(
                                            "Terima",
                                            style: TextStyle(
                                              color: Color(0XFFFFFFFF),
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            "assets/images/img_profile_picture.png",
                            height: 98,
                            width: 106,
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
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 10,
      leading: AppbarLeadingImage(
        imagePath: "assets/images/img_arrow_left_white_a700.svg",
        margin: EdgeInsets.only(left: 30),
        onTap: () {},
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Pengajuan Cuti",
      ),
      styleType: Style.bgFillTeal200,
    );
  }

  /// Common widget
  Widget _buildRowtanggal(
    BuildContext context, {
    required String tanggalOne,
    required String p10oktober2024,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 2),
            child: Text(
              tanggalOne,
              style: TextStyle(
                color: Color(0X19000000).withOpacity(0.4),
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 24),
          child: Text(
            p10oktober2024,
            style: TextStyle(
              color: Color(0X19000000).withOpacity(1),
              fontSize: 13,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
