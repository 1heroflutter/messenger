import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:messenger/utils/constants/colors.dart';
import 'package:messenger/utils/constants/image_string.dart';
import 'package:messenger/utils/constants/sizes.dart';
import 'package:messenger/utils/device/device_utils.dart';
import 'package:messenger/utils/helpers/helper_functions.dart';
class MainScreenAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool? isTitleCenter;
  final List<Widget>? suffer;
  final Widget? leading;
  final Color? backgroundColor;

  const MainScreenAppbar({
    super.key,
    this.title,
    this.suffer,
    this.isTitleCenter = false,
    this.leading,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.primaryColor,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      leading: leading,
      centerTitle: isTitleCenter,
      title: title,
      actions: suffer,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtils.getAppBarHeight());
}