import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../theme/custom_button_style.dart';
import '../../../widgets/custom_outlined_button.dart';

// ignore_for_file: must_be_immutable
class ExpandablelistsItemWidget extends StatelessWidget {
  ExpandablelistsItemWidget({Key? key, this.onTapRowone}) : super(key: key);

  VoidCallback? onTapRowone;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadiusStyle.roundedBorder10,
        boxShadow: [
          BoxShadow(
            color: appTheme.blue4003f,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(0, 0),
          )
        ],
      ),
      margin: EdgeInsets.only(right: 4.h),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.only(
            left: 14.h,
            right: 4.h,
          ),
          title: SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    "IPDS",
                    style: CustomTextStyles.titleSmallExtraBold,
                  ),
                )
              ],
            ),
          ),
          children: [
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(bottom: 4.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadiusStyle.roundedBorder4,
                border: Border.all(
                  color: appTheme.gray700,
                  width: 1.h,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomOutlinedButton(
                        height: 36.h,
                        width: 76.h,
                        text: "Nama",
                        buttonStyle: CustomButtonStyles.outlineGray1,
                        buttonTextStyle:
                            CustomTextStyles.labelLargeErrorContainer12,
                      ),
                      CustomOutlinedButton(
                        height: 36.h,
                        width: 138.h,
                        text: "Jenis Pengajuan",
                        buttonStyle: CustomButtonStyles.outlineGray1,
                        buttonTextStyle:
                            CustomTextStyles.labelLargeErrorContainer12,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 26.h,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: appTheme.whiteA700.withOpacity(0.05),
                          border: Border(
                            top: BorderSide(
                              color: appTheme.gray700,
                              width: 1.h,
                            ),
                            left: BorderSide(
                              color: appTheme.gray700,
                              width: 1.h,
                            ),
                          ),
                        ),
                        child: Text(
                          "Status",
                          textAlign: TextAlign.left,
                          style: CustomTextStyles.labelLargeErrorContainer12,
                        ),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      onTapRowone?.call();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.h,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: appTheme.gray700,
                                width: 1.h,
                              ),
                              left: BorderSide(
                                color: appTheme.gray700,
                                width: 1.h,
                              ),
                            ),
                          ),
                          child: Text(
                            "Javier",
                            textAlign: TextAlign.left,
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 22.h,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: appTheme.gray700,
                                width: 1.h,
                              ),
                              left: BorderSide(
                                color: appTheme.gray700,
                                width: 1.h,
                              ),
                            ),
                          ),
                          child: Text(
                            "Presensi Manual",
                            textAlign: TextAlign.left,
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(4.h, 6.h, 6.h, 6.h),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: appTheme.gray700,
                                width: 1.h,
                              ),
                              left: BorderSide(
                                color: appTheme.gray700,
                                width: 1.h,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(4.h),
                                decoration: BoxDecoration(
                                  color: appTheme.yellowA700,
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder4,
                                ),
                                child: Text(
                                  "Menunggu Persetujuan",
                                  textAlign: TextAlign.left,
                                  style: CustomTextStyles.interErrorContainer,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Container(
                          height: 36.h,
                          width: 76.h,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: appTheme.gray700,
                                width: 1.h,
                              ),
                              left: BorderSide(
                                color: appTheme.gray700,
                                width: 1.h,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 36.h,
                            width: 138.h,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: appTheme.gray700,
                                  width: 1.h,
                                ),
                                left: BorderSide(
                                  color: appTheme.gray700,
                                  width: 1.h,
                                ),
                              ),
                            ),
                          ),
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.imgCell,
                          height: 36.h,
                          width: 104.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Container(
                          height: 36.h,
                          width: 76.h,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: appTheme.gray700,
                                width: 1.h,
                              ),
                              left: BorderSide(
                                color: appTheme.gray700,
                                width: 1.h,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 36.h,
                            width: 138.h,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: appTheme.gray700,
                                  width: 1.h,
                                ),
                                left: BorderSide(
                                  color: appTheme.gray700,
                                  width: 1.h,
                                ),
                              ),
                            ),
                          ),
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.imgCell36x104,
                          height: 36.h,
                          width: 104.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Container(
                          height: 36.h,
                          width: 76.h,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: appTheme.gray700,
                                width: 1.h,
                              ),
                              left: BorderSide(
                                color: appTheme.gray700,
                                width: 1.h,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 36.h,
                            width: 138.h,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: appTheme.gray700,
                                  width: 1.h,
                                ),
                                left: BorderSide(
                                  color: appTheme.gray700,
                                  width: 1.h,
                                ),
                              ),
                            ),
                          ),
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.imgCell1,
                          height: 36.h,
                          width: 104.h,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
  
                