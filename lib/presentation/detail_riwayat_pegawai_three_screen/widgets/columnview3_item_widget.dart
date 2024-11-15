import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';
import '';
import '../../../core/app_export.dart';
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_text_form_field.dart';

class Columnview3ItemWidget extends StatelessWidget {
  const Columnview3ItemWidget({Key? key})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 10.h,
          width: 10.h,
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimaryContainer,
            borderRadius: BorderRadius.circular(
              5.h,
            ),
            border: Border.all(
              color: appTheme.green50002,
              width: 1.h,
            ),
          ),
        )
      ],
    );
  }
}
