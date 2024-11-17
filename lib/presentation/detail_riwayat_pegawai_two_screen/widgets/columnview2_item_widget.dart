import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class Columnview2ItemWidget extends StatelessWidget {
  const Columnview2ItemWidget({Key? key})
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
