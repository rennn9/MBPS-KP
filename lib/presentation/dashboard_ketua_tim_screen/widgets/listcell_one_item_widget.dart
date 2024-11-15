import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class ListcellOneItemWidget extends StatelessWidget {
  ListcellOneItemWidget({Key? key}) : super(key: key);

  TextEditingController cellthreeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
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
        _buildCellthree(context),
        Container(
          height: 36.h,
          width: 118.h,
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
      ],
    );
  }

  /// Section Widget
  Widget _buildCellthree(BuildContext context) {
    return Expanded(
      child: CustomTextFormField(
        controller: cellthreeController,
        textInputAction: TextInputAction.done,
        contentPadding: EdgeInsets.all(12.h),
        borderDecoration: TextFormFieldStyleHelper.outlineGray,
      ),
    );
  }
}
