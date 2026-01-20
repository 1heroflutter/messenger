import 'package:flutter/material.dart';

import '../../../../../utils/helpers/helper_functions.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({
    super.key,
    required this.icon,
    required this.title,
    this.subTitle,
    this.trailing,
    this.onTap,
    this.titleColor,
  });

  final IconData icon;
  final String title;
  final String? subTitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final textColor =  dark?Colors.white:Colors.black;
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: titleColor ?? textColor, size: 22),
      title: Text(
        title,
        style: TextStyle(color: titleColor ??textColor, fontSize: 14),
      ),
      trailing: trailing ?? (onTap != null ? const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey) : null),
    );
  }
}