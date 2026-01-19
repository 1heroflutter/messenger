import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class FormDivider extends StatelessWidget {
  final String dividerText;
  const FormDivider({
    super.key,
    required this.dark,
    required this.theme, required this.dividerText,
  });

  final bool dark;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Flexible(child: Divider(
        color: dark ? AppColors.darkGrey : AppColors.grey,
        thickness: 0.5,
        indent: 60,
        endIndent: 5,)),
      Text(
        dividerText, style: theme.textTheme.labelMedium,),
      Flexible(child: Divider(
        color: dark ? AppColors.darkGrey : AppColors.grey,
        thickness: 0.5,
        indent:0,
        endIndent: 60,))
    ],);
  }
}
